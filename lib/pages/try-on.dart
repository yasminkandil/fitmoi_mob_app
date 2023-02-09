import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitmoi_mob_app/pages/edit_measurments.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../utils/color.dart';
import '../widgets/app_bar.dart';
import '../widgets/btn_widget.dart';
import '../widgets/image_text_inp.dart';
import '../widgets/reg_textinput.dart';

class TryOn extends StatefulWidget {
  //String id;
  TryOn({
    Key? key,
    //required this.id,
  });

  @override
  State<TryOn> createState() => _TryOnState();
}

TextEditingController _heightController = TextEditingController();
TextEditingController _weightController = TextEditingController();

class _TryOnState extends State<TryOn> {
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
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(text: "Try-On"),
      body: Container(
          child: Column(
        children: [
          InkWell(
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
              width: 100,
              height: 100,
              image: AssetImage(
                'assets/hanger.png',
              ),
            ),
          ),
          SizedBox(
            height: 550,
            width: 200,
          ),
          ListTile(
            title: Row(
              children: <Widget>[
                Expanded(
                  child: ButtonWidget2(
                    btnText: "Edit Measurments",
                    onClick: () {
                      setState(() {
                        showModalBottomSheet(
                            context: context,
                            builder: (builder) {
                              return EditMeasurments();
                            });
                      });
                    },
                  ),
                ),
                Expanded(
                  child: ButtonWidget2(
                    btnText: "Recommend outfit",
                    onClick: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
