import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitmoi_mob_app/models/measurments.dart';
import 'package:fitmoi_mob_app/models/user_model.dart';
import 'package:fitmoi_mob_app/pages/edit_measurments.dart';
import 'package:fitmoi_mob_app/pages/humanModelPage.dart';
import 'package:fitmoi_mob_app/widgets/app_bar.dart';
import 'package:fitmoi_mob_app/widgets/btn_widget.dart';
import 'package:fitmoi_mob_app/widgets/image_text_inp.dart';
import 'package:fitmoi_mob_app/widgets/start.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/color.dart';

class bodyMeasurments extends StatefulWidget {
  Measurements measurements;
  String height;
  String gender;
  bodyMeasurments(
      {super.key,
      required this.measurements,
      required this.height,
      required this.gender});

  @override
  State<bodyMeasurments> createState() => _bodyMeasurmentsState();
}

class _bodyMeasurmentsState extends State<bodyMeasurments> {
  List<TextEditingController> controllers = [];
  final userr = FirebaseAuth.instance.currentUser!;
  @override
  void initState() {
    String height = widget.measurements.height == null
        ? ''
        : widget.measurements.height.toDouble().toString();
    String chest = widget.measurements.chest == null
        ? ''
        : widget.measurements.chest.toDouble().toString();
    String hip = widget.measurements.hip == null
        ? ''
        : widget.measurements.hip.toDouble().toString();
    String back = widget.measurements.back == null
        ? ''
        : widget.measurements.back.toDouble().toString();
    TextEditingController heighttController =
        TextEditingController(text: height);
    TextEditingController weighttController = TextEditingController();
    TextEditingController chesttController = TextEditingController(text: chest);
    TextEditingController backkController = TextEditingController(text: back);
    TextEditingController hippController = TextEditingController(text: hip);
    controllers.add(weighttController);
    controllers.add(heighttController);
    controllers.add(chesttController);
    controllers.add(hippController);
    controllers.add(backkController);
  }

  String status = '';
  String uniqueId = '';
  List<double> measurements = [];

  Future<void> _startProcessing(
      weight, height, chest, hip, back, userid) async {
    setState(() {
      status = 'Processing';
    });

    // Create JSON payload
    Map<String, dynamic> jsonPayload = {
      "measurement": {
        "weight": "${weight}",
        "height": "${height}",
        "chest": "${chest}",
        "hip": "${hip}",
        "back": "${back}"
      },
      'uniqueId': "${userid}",
    };

    // Send POST request to create-model endpoint
    final response = await http.post(
      Uri.parse('http://192.168.1.108:8000/create-model'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(jsonPayload),
    );

    if (response.statusCode == 200) {
      // Check response from server
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      String completed = jsonResponse['completed'];

      if (completed == 'True') {
        setState(() {
          status = 'Completed';
        });
      } else {
        setState(() {
          status = 'Not Completed';
        });
      }
    } else {
      setState(() {
        status = 'Failed';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: "Confirm Measurments",
      ),
      body: SingleChildScrollView(
        child: IntrinsicHeight(
          child: Container(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Form(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      " Height in CM",
                      style: TextStyle(
                          color: mintColors,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    ImageTextInp(
                        controller: controllers[1],
                        icon: 'assets/heightt.jpg',
                        hint: controllers[1].text,
                        torf: false,
                        errormssg: herrormessage,
                        regexp: mregexp,
                        enable: true),
                    Text(
                      "Please Enter Weight in Kg",
                      style: TextStyle(
                          color: mintColors,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    ImageTextInp(
                        controller: controllers[0],
                        icon: 'assets/weightt.jpg',
                        hint: "",
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
                        controller: controllers[2],
                        icon: 'assets/chest.jpg',
                        hint: controllers[2].text,
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
                        controller: controllers[4],
                        icon:
                            'assets/shoulders-circumference-black-glyph-icon-2256521.jpg',
                        hint: controllers[4].text,
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
                        controller: controllers[3],
                        icon: 'assets/hip.jpg',
                        hint: controllers[3].text,
                        torf: false,
                        errormssg: hiperrormessage,
                        regexp: mregexp,
                        enable: true),
                    SizedBox(
                      height: 20,
                    ),
                    ButtonWidget(
                      btnText: "Confirm Measurments",
                      onClick: () {
                        // setState(() {
                        //   measurements = [
                        //     double.parse(controllers[0].text),
                        //     double.parse(controllers[1].text),
                        //     double.parse(controllers[2].text),
                        //     double.parse(controllers[3].text),
                        //     double.parse(controllers[4].text),
                        //   ];
                        //   uniqueId = '1';
                        // });
                        _startProcessing(
                          double.parse(controllers[0].text),
                          double.parse(controllers[1].text),
                          double.parse(controllers[2].text),
                          double.parse(controllers[3].text),
                          double.parse(controllers[4].text),
                          FirebaseAuth.instance.currentUser!.uid,
                        );
                        DialogggBuilder(context)
                            .showAlert("Start", widget.gender);

                        final editMeas = FirebaseFirestore.instance
                            .collection('users')
                            .doc(userr.uid)
                            .update({
                          "height": double.parse(controllers[1].text),
                          "weight": double.parse(controllers[0].text),
                          "chest": double.parse(controllers[2].text),
                          "back": double.parse(controllers[4].text),
                          "hips": double.parse(controllers[3].text),
                        });
                        //Navigator.pop(context);
                      },
                    ),
                  ],
                ))
              ],
            ),
          )),
        ),
      ),
    );
  }
}