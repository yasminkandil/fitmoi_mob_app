// ignore_for_file: dead_code

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:fitmoi_mob_app/pages/regi_page.dart';
import 'package:fitmoi_mob_app/utils/color.dart';
import 'package:fitmoi_mob_app/widgets/btn_widget.dart';
import 'package:fitmoi_mob_app/widgets/header_container.dart';

import '../admin/admin.dart';
import '../home/home_page.dart';
import '../models/auth_service.dart';
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
                          textInput(
                              controller: emailController,
                              hint: "Email",
                              icon: Icons.email,
                              torf: false),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.only(left: 10),
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: obscureText,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                prefixIcon: const Icon(
                                  Icons.vpn_key,
                                  color: Color.fromARGB(255, 249, 118, 3),
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: _togglePasswordVisibility,
                                  child: obscureText
                                      ? Icon(Icons.visibility)
                                      : Icon(Icons.visibility_off),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty ||
                                    passwordController.text.length < 6) {
                                  return "Password must not be less than 6 characters";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                child: const Text(
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 249, 118, 3)),
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
                                          "sahar@gmail.com") {
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
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: mintLightColors,
                              textStyle: const TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 64, 64, 64),
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              AuthService().signInWithGoogle();
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePage()));
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Login with Google'),
                                SizedBox(
                                  width: 2,
                                ),
                                const Image(
                                  image: NetworkImage(
                                      'https://image.similarpng.com/very-thumbnail/2020/12/Colorful-google-logo-design-on-transparent-PNG-1.png'),
                                  width: 20,
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
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

  Widget textInput({controller, hint, icon, torf}) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.only(left: 10),
      child: TextFormField(
        obscureText: torf,
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(
            icon,
            color: Color.fromARGB(255, 249, 118, 3),
          ),
        ),
        validator: (value) {
          bool emailValid = RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value!);
          if (value.isEmpty || !emailValid) {
            return "Enter Email Correctly";
          } else {
            return null;
          }
        },
      ),
    );
  }
}
