import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitmoi_mob_app/pages/components/componentsCategory.dart';
import 'package:fitmoi_mob_app/utils/color.dart';
import 'package:fitmoi_mob_app/widgets/app_bar.dart';
import 'package:fitmoi_mob_app/widgets/btn_widget.dart';
import 'package:fitmoi_mob_app/widgets/start.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'dart:ui' as ui;

import 'package:get/get_connect/http/src/utils/utils.dart';

class HumanModelPage extends StatefulWidget {
  final String humanModelPath;

  HumanModelPage({required this.humanModelPath});

  @override
  _HumanModelPageState createState() => _HumanModelPageState();
}

String userid = FirebaseAuth.instance.currentUser!.uid;
CollectionReference users = FirebaseFirestore.instance.collection('users');
DocumentReference userRef = users.doc(userid);

Future<Map<String, dynamic>> getUserData() async {
  DocumentSnapshot userSnapshot = await userRef.get();
  if (userSnapshot.exists) {
    Map<String, dynamic>? userData =
        userSnapshot.data() as Map<String, dynamic>?;
    return userData ?? {};
  } else {
    return {};
  }
}

Future<dynamic> loadAsset(String assetPath) async {
  print(chosenCateg);

  return await rootBundle.load(assetPath);
}

class _HumanModelPageState extends State<HumanModelPage> {
  bool remove = false;

  Object garmentShortPant = Object(
      fileName: 'assets/short-pant_$userid.obj',
      scale: Vector3(0.09, 0.09, 0.09),
      position: Vector3(0, 0, 0),
      lighting: true);
  Object pant = Object(
    fileName: 'assets/pant_$userid.obj',
    scale: Vector3(0.09, 0.08, 0.10),
    position: Vector3(0, 0, 0),
    lighting: true,
  );
  Object tshirt = Object(
    fileName: 'assets/t-shirt_$userid.obj',
    scale: Vector3(0.16, 0.17, 0.18),
    position: Vector3(0, 0, 0),
    lighting: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: "View 3D Model",
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "You can rotate your 3D model", // Add the text here
              style: TextStyle(fontSize: 16.0, color: mintColors),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ButtonWidget2(
                  btnText: "Add Another Item",
                  onClick: () {
                    Navigator.pushNamed(context, "homepage");
                  },
                  // ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: Cube(onSceneCreated: (Scene scene) async {
                // Load and add the body object
                loadAsset('assets/body_$userid.obj');
                scene.world.add(Object(
                  fileName: 'assets/body_$userid.obj',
                  scale: Vector3.all(0.3),
                  position: Vector3(0, 0, 0),
                  lighting: true,
                ));
                Map<String, dynamic>? userData = await getUserData();

                if (userData != null && userData.isNotEmpty) {
                  double height = userData['height'] ?? 0;
                  double weight = userData['weight'] ?? 0;
                  if (height >= 170 &&
                      height <= 185 &&
                      weight >= 70 &&
                      weight <= 85) {
                    tshirt.scale.setValues(0.16, 0.17, 0.18);
                    tshirt.updateTransform();
                    scene.world.add(tshirt);

                    pant.scale.setValues(0.09, 0.08, 0.11);
                    pant.updateTransform();
                    scene.world.add(pant);
                    garmentShortPant.scale.setValues(0.09, 0.08, 0.11);
                    garmentShortPant.updateTransform();
                    scene.world.add(garmentShortPant);
                  } else if (height >= 170 &&
                      height <= 190 &&
                      weight >= 86 &&
                      weight <= 100) {
                    tshirt.scale.setValues(0.16, 0.17, 0.18);
                    tshirt.updateTransform();
                    scene.world.add(tshirt);
                    pant.scale.setValues(0.09, 0.09, 0.11);
                    pant.updateTransform();
                    scene.world.add(pant);
                    garmentShortPant.scale.setValues(0.09, 0.09, 0.11);
                    garmentShortPant.updateTransform();
                    scene.world.add(garmentShortPant);
                  } else if (height >= 150 &&
                      height <= 169 &&
                      weight >= 50 &&
                      weight <= 69) {
                    tshirt.scale.setValues(0.15, 0.15, 0.17);
                    tshirt.updateTransform();
                    scene.world.add(tshirt);
                    pant.scale.setValues(0.07, 0.07, 0.09);
                    pant.updateTransform();
                    scene.world.add(pant);
                    garmentShortPant.scale.setValues(0.07, 0.07, 0.09);
                    garmentShortPant.updateTransform();
                    scene.world.add(garmentShortPant);
                  } else {
                    scene.world.add(pant);
                    scene.world.add(garmentShortPant);
                    scene.world.add(tshirt);
                  }
                } else {
                  Fluttertoast.showToast(
                    msg: "An error occured",
                  );
                }

                scene.camera.zoom = 15;
                scene.updateTexture();
              }),
            ),
          ),
          FutureBuilder<Map<String, dynamic>>(
            future: getUserData(),
            builder: (BuildContext context,
                AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                Map<String, dynamic> userData = snapshot.data!;
                double chestMeasurement = userData['chest'] ?? 0;
                double waistMeasurement = userData['waist'] ?? 0;
                double height = userData['height'] ?? 0;
                double hipMeasurement = userData['hip'] ?? 0;
                String gender = userData['gender'] ?? 0;
                String suggestedSize = 'Sorry, your size is not available ';
                if (chosenCateg == 't-shirt' && gender == 'male') {
                  if (chestMeasurement >= 81 && chestMeasurement <= 86) {
                    suggestedSize = "X-Small";
                  } else if (chestMeasurement >= 86 && chestMeasurement <= 96) {
                    suggestedSize = "Small";
                  } else if (chestMeasurement >= 96 &&
                      chestMeasurement <= 106) {
                    suggestedSize = "Medium";
                  } else if (chestMeasurement >= 106 &&
                      chestMeasurement <= 116) {
                    suggestedSize = "Large";
                  } else if (chestMeasurement >= 116 &&
                      chestMeasurement <= 126) {
                    suggestedSize = "X-Large";
                  } else if (chestMeasurement >= 126 &&
                      chestMeasurement <= 132) {
                    suggestedSize = "XX-Large";
                  } else {
                    suggestedSize = "Size not available";
                  }
                } else if (chosenCateg == 't-shirt' && gender == 'female') {
                  if (chestMeasurement >= 80 && chestMeasurement <= 86) {
                    suggestedSize = "X-Small";
                  } else if (chestMeasurement >= 86 && chestMeasurement <= 92) {
                    suggestedSize = "Small";
                  } else if (chestMeasurement >= 92 && chestMeasurement <= 96) {
                    suggestedSize = "Medium";
                  } else if (chestMeasurement >= 96 &&
                      chestMeasurement <= 102) {
                    suggestedSize = "Large";
                  } else if (chestMeasurement >= 102 &&
                      chestMeasurement <= 106) {
                    suggestedSize = "X-Large";
                  } else if (chestMeasurement >= 106 &&
                      chestMeasurement <= 112) {
                    suggestedSize = "XX-Large";
                  } else {
                    suggestedSize = "Size not available";
                  }
                } else if (chosenCateg == 'short-pant' ||
                    chosenCateg == 'pant' && gender == 'female') {
                  if (waistMeasurement >= 63 &&
                      waistMeasurement <= 66 &&
                      hipMeasurement >= 86.5 &&
                      hipMeasurement < 90) {
                    suggestedSize = 'XS - 34';
                  } else if (waistMeasurement > 66 &&
                      waistMeasurement <= 70 &&
                      hipMeasurement >= 90 &&
                      hipMeasurement < 95) {
                    suggestedSize = 'S - 36';
                  } else if (waistMeasurement > 70 &&
                      waistMeasurement < 76 &&
                      hipMeasurement >= 95 &&
                      hipMeasurement < 98.5) {
                    suggestedSize = 'M - 38';
                  } else if (waistMeasurement >= 76 &&
                      waistMeasurement < 81 &&
                      hipMeasurement >= 98.5 &&
                      hipMeasurement < 106) {
                    suggestedSize = 'L - 40';
                  } else if (waistMeasurement >= 83 &&
                      waistMeasurement < 90 &&
                      hipMeasurement >= 106 &&
                      hipMeasurement < 110) {
                    suggestedSize = 'XL - 42';
                  } else if (waistMeasurement >= 90 &&
                      waistMeasurement < 100 &&
                      hipMeasurement >= 110 &&
                      hipMeasurement < 118) {
                    suggestedSize = 'XXL - 44';
                  } else if (waistMeasurement >= 100 &&
                      waistMeasurement < 109 &&
                      hipMeasurement >= 118 &&
                      hipMeasurement < 130) {
                    suggestedSize = 'XXXL - 46';
                  }
                } else if (chosenCateg == 'short-pant' ||
                    chosenCateg == 'pant' && gender == 'male') {
                  if (waistMeasurement >= 65 &&
                      waistMeasurement <= 78 &&
                      hipMeasurement >= 88 &&
                      hipMeasurement < 91) {
                    suggestedSize = 'XS - 28';
                  } else if (waistMeasurement > 78 &&
                      waistMeasurement <= 85 &&
                      hipMeasurement >= 91 &&
                      hipMeasurement < 94) {
                    suggestedSize = 'S - 30';
                  } else if (waistMeasurement > 85 &&
                      waistMeasurement < 91 &&
                      hipMeasurement >= 94 &&
                      hipMeasurement < 98.5) {
                    suggestedSize = 'M - 32';
                  } else if (waistMeasurement >= 91 &&
                      waistMeasurement < 94 &&
                      hipMeasurement >= 98.5 &&
                      hipMeasurement < 104) {
                    suggestedSize = 'L - 34';
                  } else if (waistMeasurement >= 94 &&
                      waistMeasurement < 96 &&
                      hipMeasurement >= 104 &&
                      hipMeasurement < 109) {
                    suggestedSize = 'XL - 36';
                  } else if (waistMeasurement >= 96 &&
                      waistMeasurement < 100 &&
                      hipMeasurement >= 109 &&
                      hipMeasurement < 113) {
                    suggestedSize = 'XXL - 38';
                  } else if (waistMeasurement >= 100 &&
                      waistMeasurement < 108 &&
                      hipMeasurement >= 113 &&
                      hipMeasurement < 120) {
                    suggestedSize = 'XXXL - 40';
                  }
                }
                return ListTile(
                  title: Text('Your suggested size'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(suggestedSize),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Text('Loading...');
              }
            },
          ),
          ListTile(
              title: Row(
            children: [
              Expanded(
                child: ButtonWidgetdelete(
                  btnText: "Remove Pant",
                  onClick: () {
                    setState(() {
                      pant.position.setValues(1500, 1500, 1500);
                      pant.updateTransform();
                    });
                  },
                ),
              ),
              Expanded(
                child: ButtonWidgetdelete(
                  btnText: "Remove Short",
                  onClick: () {
                    setState(() {
                      garmentShortPant.position.setValues(1500, 1500, 1500);
                      garmentShortPant.updateTransform();

                      // print('object');
                    });
                  },
                ),
              ),
              Expanded(
                child: ButtonWidgetdelete(
                  btnText: "Remove T-shirt",
                  onClick: () {
                    setState(() {
                      tshirt.position.setValues(1500, 1500, 1500);
                      tshirt.updateTransform();

                      // print('object');
                    });
                  },
                ),
              )
            ],
          )),
        ],
      ),
    );
  }
}
