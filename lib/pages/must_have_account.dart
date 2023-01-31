import 'package:flutter/material.dart';
import 'package:fitmoi_mob_app/pages/login_page.dart';
import 'package:fitmoi_mob_app/pages/regi_page.dart';
import 'package:fitmoi_mob_app/widgets/app_bar.dart';

import '../utils/color.dart';

class MustHaveAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: ""),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 150.0),
        child: Column(
          children: [
            Center(
                child: Container(
              child: Image.asset('assets/6712526.jpg'),
              height: 140,
              width: 140,
            )),
            SizedBox(
              height: 30,
              width: 30,
            ),
            Center(
              child: Text(
                  style: TextStyle(color: mintColors),
                  'Sorry...You must have an account to view this page.'),
            ),
            SizedBox(
              height: 70,
              width: 70,
            ),
            InkWell(
              child: RichText(
                text: TextSpan(children: [
                  const TextSpan(
                      text: "Don't have an account ? ",
                      style: TextStyle(color: Colors.black)),
                  TextSpan(
                      text: "Register", style: TextStyle(color: mintColors)),
                ]),
              ),
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => RegisterPage())),
            ),
            InkWell(
              child: RichText(
                text: TextSpan(children: [
                  const TextSpan(
                      text: "Already a member ? ",
                      style: TextStyle(color: Colors.black)),
                  TextSpan(
                      text: "Login",
                      style: TextStyle(
                        color: mintColors,
                      )),
                ]),
              ),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => LoginPage())),
            )
          ],
        ),
      ),
    );
  }
}
