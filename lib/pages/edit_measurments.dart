import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitmoi_mob_app/widgets/btn_widget.dart';
import 'package:fitmoi_mob_app/widgets/image_text_inp.dart';
import 'package:fitmoi_mob_app/widgets/reg_textinput.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/user_model.dart';
import '../utils/color.dart';
import '../widgets/alert.dart';

class EditMeasurments extends StatelessWidget {
  EditMeasurments({
    super.key,
  });

  final userr = FirebaseAuth.instance.currentUser!;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        color: GreyLightColors,
        child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .where('email', isEqualTo: userr.email)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var data = snapshot.data!.docs[index];
                          TextEditingController _heightController =
                              TextEditingController(
                                  text: data['height'].toString());
                          TextEditingController _weightController =
                              TextEditingController(
                                  text: data['weight'].toString());
                          TextEditingController _chestController =
                              TextEditingController(
                                  text: data['chest'].toString());
                          TextEditingController _backController =
                              TextEditingController(
                                  text: data['back'].toString());
                          TextEditingController _hipController =
                              TextEditingController(
                                  text: data['hip'].toString());
                          return Column(
                            children: [
                              Form(
                                  child: Column(
                                children: [
                                  Text(
                                    "Height in CM",
                                    style: TextStyle(
                                        color: mintColors,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  ImageTextInp(
                                      controller: _heightController,
                                      icon: 'assets/heightt.jpg',
                                      hint: data['height'].toString(),
                                      torf: false,
                                      errormssg: herrormessage,
                                      regexp: mregexp,
                                      enable: true),
                                  Text(
                                    "Weight in Kg",
                                    style: TextStyle(
                                        color: mintColors,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  ImageTextInp(
                                      controller: _weightController,
                                      icon: 'assets/weightt.jpg',
                                      hint: data['weight'].toString(),
                                      torf: false,
                                      errormssg: werrormessage,
                                      regexp: mregexp,
                                      enable: true),
                                  Text(
                                    "Chest",
                                    style: TextStyle(
                                        color: mintColors,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  ImageTextInp(
                                      controller: _chestController,
                                      icon: 'assets/chest.jpg',
                                      hint: data['chest'].toString(),
                                      torf: false,
                                      errormssg: cerrormessage,
                                      regexp: mregexp,
                                      enable: true),
                                  Text(
                                    "Back",
                                    style: TextStyle(
                                        color: mintColors,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  ImageTextInp(
                                      controller: _backController,
                                      icon:
                                          'assets/shoulders-circumference-black-glyph-icon-2256521.jpg',
                                      hint: data['back'].toString(),
                                      torf: false,
                                      errormssg: berrormessage,
                                      regexp: mregexp,
                                      enable: true),
                                  Text(
                                    "Hips",
                                    style: TextStyle(
                                        color: mintColors,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  ImageTextInp(
                                      controller: _hipController,
                                      icon: 'assets/hip.jpg',
                                      hint: data['hip'].toString(),
                                      torf: false,
                                      errormssg: hiperrormessage,
                                      regexp: mregexp,
                                      enable: true),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ButtonWidget(
                                    btnText: "Regenerate Model",
                                    onClick: () {
                                      final editMeas = FirebaseFirestore
                                          .instance
                                          .collection('users')
                                          .doc(userr.uid)
                                          .update({
                                        "height": double.parse(
                                            _heightController.text),
                                        "weight": double.parse(
                                            _weightController.text),
                                        "chest":
                                            double.parse(_chestController.text),
                                        "back":
                                            double.parse(_backController.text),
                                        "hips":
                                            double.parse(_hipController.text),
                                      });
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ))
                            ],
                          );
                        });
                  } else if (snapshot.hasError) {
                    return showAlertDialog(context, "Sorry an error occured");
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                })),
      ),
    );
  }
}
