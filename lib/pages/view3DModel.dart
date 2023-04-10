import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitmoi_mob_app/pages/edit_measurments.dart';
import 'package:fitmoi_mob_app/services/api_getM.dart';
import 'package:flutter/material.dart';
import '../models/measurments.dart';
import '../models/user_model.dart';
import '../shop/details/components/generate_model.dart';
import '../utils/color.dart';
import '../widgets/app_bar.dart';
import '../widgets/btn_widget.dart';
import '../widgets/image_text_inp.dart';
import '../widgets/reg_textinput.dart';
import 'package:url_launcher/url_launcher.dart';

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
                    onClick: () async {
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
      appBar: CustomAppBar(text: "3D Model"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/3dmodel.png",
              height: 550,
              width: 400,
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
                      onClick: () async {
                        const url = 'http://127.0.0.1:8050';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
