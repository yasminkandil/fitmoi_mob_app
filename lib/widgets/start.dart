import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitmoi_mob_app/pages/components/componentsCategory.dart' as c;

import 'package:fitmoi_mob_app/utils/color.dart';
import 'package:fitmoi_mob_app/widgets/messagetimer.dart';
import 'package:flutter/material.dart';

import '../pages/humanModelPage.dart';
import 'package:http/http.dart' as http;

class DialogggBuilder {
  DialogggBuilder(this.context);

  final BuildContext context;

  void showAlert([String? text, String? gender, String? productId]) {
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
              content: show3D(
                text: text.toString(),
                gender: gender.toString(),
                productId: productId.toString(),
              ),
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
  show3D({this.text = '', required this.gender, required this.productId});

  final String text;
  final String gender;
  final String productId;
  @override
  State<show3D> createState() => _show3DState();
}

String userid = FirebaseAuth.instance.currentUser!.uid;

class _show3DState extends State<show3D> {
  //final String humanModel;
  Future<void> _fitModel(String gender, String uniqueId, String garmentClass,
      String productId) async {
    setState(() {
      _status = 'Processing...';
    });
    String productId = widget.productId;

    // FirebaseFirestore.instance
    //     .collection('product')
    //     .doc(productId)
    //     .get()
    //     .then((DocumentSnapshot? documentSnapshot) {
    //   if (documentSnapshot != null && documentSnapshot.exists) {
    //     Map<String, dynamic>? data =
    //         documentSnapshot.data() as Map<String, dynamic>?;
    //     String? texture = data?['texture'] as String?;
    //final storageReference = FirebaseStorage.instance.ref();
    // String texturebase64Encode;
    // List<int> textureBytes;
// Assuming the ID of the user is stored in a variable called 'userId'
    String userId = FirebaseAuth.instance.currentUser!.uid;
    // File data = (await storageReference
    //     .child('textures/up0fa301d0-b522-11ed-b6b2-c952595972f0.jpg').getData()) as File;

    // textureBytes = data.readAsBytes() as List<int>;
    // texturebase64Encode = base64.encode(textureBytes);
    final storageReference = FirebaseStorage.instance
        .ref()
        .child('textures/up0fa301d0-b522-11ed-b6b2-c952595972f0.jpg');
    final imageFile = await storageReference.getData();
    final imageBytes = imageFile!.buffer.asUint8List();
    final base64Image = base64.encode(imageBytes);
    //   File file = File(
    //       'E:/grad python/meshes/pqmW98wYWMelFQa7OXSmzj3ZgJJ2/${garmentClass}_$userId.jpg'); // or any other file format you want to use
    //   file.writeAsBytes(data!).then((value) {
    //     print('Texture saved to assets folder');
    //   });
    // }).catchError((error) {
    //   print('Error: $error');
    // or do whatever you want with the texture value here
    // } else {
    //   print('Texture field is null');
    // }
    //   } else {
    //     print('Document does not exist');
    //   }
    // }).catchError((error) {
    //   print('Error: $error');
    // });

    final Map<String, dynamic> requestData = {
      'uniqueId': uniqueId, // Set your uniqueId here
      'garmentClass': garmentClass,
      'gender': gender,
      'texture': base64Image // Set your garmentClass here
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
        // _humanMtl = responseBody['human-mtl'];
        // _garmentMtl = responseBody['garment-mtl'];
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
        _fitModel(widget.gender, userid, c.chosenCateg, widget.productId)
            .then((value) {
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
