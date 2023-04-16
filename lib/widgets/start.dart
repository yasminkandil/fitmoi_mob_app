import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitmoi_mob_app/pages/components/componentsCategory.dart' as c;
import 'package:fitmoi_mob_app/utils/color.dart';
import 'package:fitmoi_mob_app/widgets/messagetimer.dart';
import 'package:flutter/material.dart';

import '../pages/humanModelPage.dart';
import 'package:http/http.dart' as http;

class DialogggBuilder {
  DialogggBuilder(this.context);

  final BuildContext context;

  void showAlert([String? text, String? gender]) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              backgroundColor: Colors.white,
              content: show3D(text: text.toString(), gender: gender.toString()),
            ));
      },
    );
  }

  void hideOpenDialog() {
    Navigator.of(context).pop();
  }
}

String _status = '';
String _humanModel = '';
String _garmentModel = '';
String _humanMtl = '';
String _garmentMtl = '';
String _humanImage = '';
String _garmentImage = '';

class show3D extends StatefulWidget {
  show3D({this.text = '', required this.gender});

  final String text;
  final String gender;
  @override
  State<show3D> createState() => _show3DState();
}

String userid = FirebaseAuth.instance.currentUser!.uid;

class _show3DState extends State<show3D> {
  //final String humanModel;
  Future<void> _fitModel(
      String gender, String uniqueId, String garmentClass) async {
    setState(() {
      _status = 'Processing...';
    });

    final Map<String, dynamic> requestData = {
      'uniqueId': uniqueId, // Set your uniqueId here
      'garmentClass': garmentClass,
      'gender': gender // Set your garmentClass here
    };

    final response = await http.post(
      Uri.parse(
          'http://192.168.1.108:8000/fit-model'), // Replace with your backend URL
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);

      setState(() {
        _status = responseBody['completed'];
        _humanModel = responseBody['humanModel'];
        _garmentModel = responseBody['garmentModel'];
        _humanMtl = responseBody['human-mtl'];
        _garmentMtl = responseBody['garment-mtl'];
        //_humanImage = responseBody['human-image'];
        //_garmentImage = responseBody['garment-image'];
      });
    } else {
      setState(() {
        _status = 'Error: ${response.statusCode}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var displayedText = widget.text;

    return Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // _getLoadingIndicator(),
              _getHeading(context),
              //_getIcon(),
              // _getText(displayedText),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [_getButton(context), _getOKButton(context)],
              ),
            ]));
  }

  Padding _getLoadingIndicator() {
    return Padding(
        child: Container(
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: new AlwaysStoppedAnimation<Color>(mintLightColors),
            ),
            width: 32,
            height: 32),
        padding: const EdgeInsets.only(bottom: 16));
  }

  Widget _getHeading(context) {
    return const Padding(
        child: Text(
          'Your 3D model is ready click view to see it …',
          style: TextStyle(color: Colors.black, fontSize: 16),
          textAlign: TextAlign.center,
        ),
        padding: EdgeInsets.only(bottom: 4));
  }

  Text _getText(String displayedText) {
    return Text(
      displayedText,
      style: const TextStyle(color: Colors.black, fontSize: 14),
      textAlign: TextAlign.center,
    );
  }

  Widget _getButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _fitModel(widget.gender, userid, c.chosenCateg).then((value) {
          sleep(
            const Duration(seconds: 15),
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HumanModelPage(humanModelPath: ""),
            ),
          );
        });
      },
      style: ElevatedButton.styleFrom(
        primary: mintLightColors,
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
      child: const Text(
        "View",
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      ),
    );
  }
}

Widget _getOKButton(BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      Navigator.of(context).pop();
    },
    style: ElevatedButton.styleFrom(
      primary: mintLightColors,
      onPrimary: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
      ),
    ),
    child: const Text(
      "OK",
      style: TextStyle(
        color: Colors.white,
        fontSize: 15,
      ),
    ),
  );
}
