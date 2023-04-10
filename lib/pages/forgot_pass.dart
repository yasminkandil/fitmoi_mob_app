import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitmoi_mob_app/widgets/reg_textinput.dart';
import 'package:flutter/material.dart';
import 'package:fitmoi_mob_app/widgets/btn_widget.dart';
import 'package:fitmoi_mob_app/widgets/header_container.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/user_model.dart';
import '../utils/color.dart';
import '../widgets/app_bar.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({Key? key}) : super(key: key);

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  TextEditingController _emailController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: ""),
      body: Container(
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          children: <Widget>[
            HeaderContainer("Forgot Password"),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: IntrinsicHeight(
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        RegTextInput(
                          controller: _emailController,
                          hint: "Email",
                          icon: Icons.email,
                          torf: false,
                          errormssg: emailerrormssg,
                          regexp: eregexp,
                          enable: true,
                        ),
                        Expanded(
                          child: Center(
                            child: ButtonWidget(
                              onClick: () {
                                auth
                                    .sendPasswordResetEmail(
                                        email: _emailController.text)
                                    .then(
                                  (value) {
                                    Fluttertoast.showToast(
                                      msg: "Email Sent...",
                                      //backgroundColor: mintColors
                                    );
                                    Navigator.of(context).pop();
                                  },
                                );
                              },
                              btnText: "Reset Password",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
