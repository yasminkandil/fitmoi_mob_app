import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

import '../../../models/user_model.dart';
import '../../../utils/color.dart';
import '../../../widgets/btn_widget.dart';
import '../../../widgets/image_text_inp.dart';

TextEditingController _heightController = TextEditingController();
TextEditingController _weightController = TextEditingController();

class TryyOn extends StatefulWidget {
  const TryyOn({super.key});

  @override
  State<TryyOn> createState() => _TryyOnState();
}

class _TryyOnState extends State<TryyOn> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  late VoidCallback _showPersBottomSheetCallBack;
  void initState() {
    super.initState();
    _showPersBottomSheetCallBack = _showModalSheet;
  }

  void _showModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            color: Colors.tealAccent,
            child: new Center(
              child: Column(
                children: [
                  Text(
                    "Height",
                    style: TextStyle(
                        color: mintColors,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  ImageTextInp(
                      controller: _heightController,
                      icon: 'heightt.jpg',
                      hint: "height in cm",
                      torf: false,
                      errormssg: herrormessage,
                      regexp: mregexp,
                      enable: true),
                  Text(
                    "Weight",
                    style: TextStyle(
                        color: mintColors,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  ImageTextInp(
                      controller: _weightController,
                      icon: 'weightt.jpg',
                      hint: "weight in kg",
                      torf: false,
                      errormssg: werrormessage,
                      regexp: mregexp,
                      enable: true),
                  ButtonWidget(
                    btnText: "Generate Model",
                    onClick: () {
                      final addHandW = FirebaseFirestore.instance
                          .collection('users')
                          .doc()
                          .update({
                        'height': _heightController.text,
                        'weight': _weightController.text,
                      }).then((value) => null);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          setState(() {
            showModalBottomSheet(
                context: context,
                builder: (builder) {
                  return new Container(
                    color: GreyLightColors,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Center(
                        child: Column(
                          children: [
                            Text(
                              "Height",
                              style: TextStyle(
                                  color: mintColors,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            ImageTextInp(
                                controller: _heightController,
                                icon: 'assets/heightt.jpg',
                                hint: "height in cm",
                                torf: false,
                                errormssg: herrormessage,
                                regexp: mregexp,
                                enable: true),
                            SizedBox(
                              height: 20,
                              width: 20,
                            ),
                            Text(
                              "Weight",
                              style: TextStyle(
                                  color: mintColors,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            ImageTextInp(
                                controller: _weightController,
                                icon: 'assets/weightt.jpg',
                                hint: "weight in kg",
                                torf: false,
                                errormssg: werrormessage,
                                regexp: mregexp,
                                enable: true),
                            SizedBox(
                              height: 20,
                              width: 20,
                            ),
                            ButtonWidget(
                              btnText: "Generate Model",
                              onClick: () {
                                final addHandW = FirebaseFirestore.instance
                                    .collection('users')
                                    .doc()
                                    .update({
                                  'height':
                                      double.parse(_heightController.text),
                                  'weight':
                                      double.parse(_weightController.text),
                                }).then((value) => null);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          });
        }, // Image tapped
        splashColor: Colors.white10, // Splash color over image
        child: Ink.image(
          fit: BoxFit.cover, // Fixes border issues
          width: 50,
          height: 50,
          image: AssetImage(
            'assets/hangerr.png',
          ),
        ),
      ),
    );
  }
}
