// ignore_for_file: dead_code

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitmoi_mob_app/widgets/btn_with_image.dart';
import 'package:fitmoi_mob_app/widgets/passwordfield.dart';
import 'package:fitmoi_mob_app/widgets/reg_textinput.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:fitmoi_mob_app/pages/regi_page.dart';
import 'package:fitmoi_mob_app/utils/color.dart';
import 'package:fitmoi_mob_app/widgets/btn_widget.dart';
import 'package:fitmoi_mob_app/widgets/header_container.dart';

import '../admin/admin.dart';
import '../home/home_page.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';
import '../widgets/app_bar.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("No user found");
        Fluttertoast.showToast(
            msg: "No User Found", backgroundColor: mintColors);
      } else if (e.code == 'wrong-password') {
        print("wrong password");
        Fluttertoast.showToast(
            msg: "Wrong Password", backgroundColor: mintColors);
      }
    }
    return user;
  }

  /* @override
  void dispose() {
    // * TextEditingControllers should be always disposed
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
*/
  bool obscureText = true;
  void _togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(text: ""),
      body: Container(
        padding: const EdgeInsets.only(bottom: 30),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              HeaderContainer("Login"),
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: IntrinsicHeight(
                    child: Container(
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 30),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          RegTextInput(
                            controller: emailController,
                            hint: "Email",
                            icon: Icons.email,
                            torf: false,
                            errormssg: emailerrormssg,
                            regexp: eregexp,
                            enable: true,
                          ),
                          PasswordField(
                              hintText: "Password",
                              obscureText: obscureText,
                              Controller: passwordController,
                              perrormssg:
                                  "Password must not be less than 6 characters"),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                child: const Text(
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 10, 169, 159)),
                                    "Forgot Password?"),
                                onPressed: () {
                                  Navigator.pushNamed(context, 'forgot_pass');
                                }),
                          ),
                          Expanded(
                            child: Center(
                              child: ButtonWidget(
                                onClick: () async {
                                  User? user = await loginUsingEmailPassword(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      context: context);
                                  print(user);
                                  if (user != null &&
                                      emailController.text ==
                                          "fitmoi@gmail.com") {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) => Admin()));
                                  } else if (user != null) {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MyHomePage()));
                                  }
                                  if (formKey.currentState!.validate()) {
                                    Fluttertoast.showToast(
                                        msg: "Logging in...",
                                        backgroundColor: mintColors);
                                  }
                                },
                                btnText: "LOGIN",
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Expanded(
                              child: Center(
                            child: ButtonWithImage(
                              btnText: "LOGIN WITH GOOGLE",
                              onClick: () async {
                                AuthService().handleSignIn();
                              },
                            ),
                          )),
                          InkWell(
                            child: RichText(
                              text: TextSpan(children: [
                                const TextSpan(
                                    text: "Don't have an account ? ",
                                    style: TextStyle(color: Colors.black)),
                                TextSpan(
                                    text: "Register",
                                    style: TextStyle(color: mintColors)),
                              ]),
                            ),
                            onTap: () =>
                                Navigator.pushNamed(context, 'register'),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
