import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fitmoi_mob_app/pages/view_account.dart';
import 'package:fitmoi_mob_app/utils/color.dart';
import '../models/contact_us_model.dart';
import '../widgets/app_bar.dart';

class ContactUs extends StatefulWidget {
  @override
  ContactUsForm createState() => ContactUsForm();
}

final userEm = FirebaseAuth.instance.currentUser!.email;

class ContactUsForm extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: 'Contact Us',
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 32.0),
                  TextField(
                    controller: emaillController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: mintColors,
                      hintText: userEm,
                      enabled: false,
                      border: InputBorder.none,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextField(
                    controller: messageController,
                    maxLines: 7,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: mintColors,
                      hintText: "Your Message",
                      border: InputBorder.none,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  MaterialButton(
                    height: 60.0,
                    minWidth: double.infinity,
                    color: GreyColors,
                    onPressed: () {
                      userId = FirebaseAuth.instance.currentUser!.uid;
                      addMessages(userEm!, messageController.text, userId)
                          .then((value) {
                        print("Message Sent");
                        Fluttertoast.showToast(
                          msg: "Message sent...",
                          //backgroundColor: mintColors
                        );
                        Navigator.pushNamed(context, 'home');
                      });
                    },
                    child: Text("SUBMIT",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: mintColors,
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
