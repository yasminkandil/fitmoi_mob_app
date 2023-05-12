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
import 'package:restart_app/restart_app.dart';
import 'dart:ui' as ui;

import 'package:get/get_connect/http/src/utils/utils.dart';

class HumanModelPage extends StatefulWidget {
  final String humanModelPath;

  HumanModelPage({required this.humanModelPath});

  @override
  _HumanModelPageState createState() => _HumanModelPageState();
}

String _userid = FirebaseAuth.instance.currentUser!.uid;
CollectionReference users = FirebaseFirestore.instance.collection('users');
DocumentReference userRef = users.doc(_userid);
Future<String> getChestData() async {
  DocumentSnapshot userSnapshot = await userRef.get();
  if (userSnapshot.exists) {
    Map<String, dynamic>? userData =
        userSnapshot.data() as Map<String, dynamic>?;
    dynamic chestData = userData!['chest'];
    dynamic backData = userData['back'];
    dynamic waistData = userData['waist'];
    dynamic hipData = userData['hip'];

    return userData.toString();
  } else {
    return 'User not found';
  }
}

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
  return await rootBundle.load(assetPath);
}

class _HumanModelPageState extends State<HumanModelPage> {
  // late Object human;

  // late Object shirt;
  // late Object pant;
  // late Object skirt;
  // late Object tshirt;

  bool remove = false;
  late Texture tshirtTexture;
  Object garmentShortPant = Object(
      fileName: 'assets/short-pant_$_userid.obj',
      scale: Vector3(0.09, 0.09, 0.09),
      position: Vector3(0, 0, 0),
      lighting: true);
  Object shirt = Object(
      fileName: 'assets/shirt_$_userid.obj',
      scale: Vector3(0.09, 0.09, 0.09),
      position: Vector3(0, 0, 0),
      lighting: true);

  Object pant = Object(
      fileName: 'assets/pant_1.obj',
      scale: Vector3(0.08, 0.09, 0.09),
      position: Vector3(0, 0, 0),
      lighting: true);
  Object tshirt = Object(
    fileName: 'assets/t-shirt_$_userid.obj',
    scale: Vector3(0.16, 0.17, 0.18),
    position: Vector3(0, 0, 0),
    lighting: true,
    backfaceCulling: false,
    // isAsset: false
  );
  Object skirt = Object(
      fileName: 'assets/skirt_$_userid.obj',
      scale: Vector3(0.09, 0.09, 0.09),
      position: Vector3(0, 0, 0),
      lighting: true);

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
          Expanded(
            child: Center(
              child: Cube(
                onSceneCreated: (Scene scene) {
                  loadAsset('assets/body_$_userid.obj');
                  scene.world.add(Object(
                    fileName: 'assets/body_$_userid.obj',
                    scale: Vector3.all(0.3),
                    position: Vector3(0, 0, 0),
                    lighting: true,
                  ));
                  // chosenCateg = 'pant';
                  if (chosenCateg == 'shirt') {
                    loadAsset('assets/shirt_$_userid.obj');
                    scene.world.add(shirt);
                  } else if (chosenCateg == 'short-pant') {
                    loadAsset('assets/short-pant_$_userid.obj');
                    scene.world.add(garmentShortPant);
                    setState(() {
                      loadImageFromAsset('assets/short-pant_$_userid.jpg')
                          .then((value) {
                        garmentShortPant.mesh.texture = value;
                        scene.updateTexture();
                      });
                    });
                  } else if (chosenCateg == 'pant') {
                    loadAsset('assets/pant_1.obj');
                    scene.world.add(pant);
                    loadImageFromAsset('assets/pant_1.jpg').then((value) {
                      pant.mesh.texture = value;
                      scene.updateTexture();
                    });
                  } else if (chosenCateg == 't-shirt') {
                    scene.world.add(tshirt);
                    setState(() {
                      loadImageFromAsset('assets/t-shirt_$_userid.jpg')
                          .then((value) {
                        tshirt.mesh.texture = value;
                        //scene.updateTexture();
                      });
                    });
                  } else if (chosenCateg == 'skirt') {
                    loadAsset('assets/skirt_$_userid.obj');
                    scene.world.add(skirt);
                  }

                  scene.camera.zoom = 15;
                  scene.updateTexture();
                  // scene.world.add(Object(fileName: 'assets/turtle.obj'));
                  // scene.camera.position.setFrom(Vector3(0, 0, 0.1));
                  // scene.light.position.setFrom(Vector3(0, 0.2, 0.2));
                  // scene.light.ambient.rgb = Vector3(0.5, 0.5, 0.5);
                  // scene.light.position == scene.camera.position;
                  // scene.textureBlendMode = BlendMode.hardLight;
                },
              ),
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
                double weight = userData['weight'] ?? 0;
                double hipMeasurement = userData['hip'] ?? 0;
                String gender = userData['gender'] ?? 0;
                String suggestedSize = 'Sorry, your size is not available';
                if (chosenCateg == 't-shirt' && gender == 'male') {
                  if (chestMeasurement >= 89 && chestMeasurement < 92) {
                    suggestedSize = 'XS';
                  } else if (chestMeasurement >= 92 && chestMeasurement < 98) {
                    suggestedSize = 'S';
                  } else if (chestMeasurement >= 98 && chestMeasurement < 107) {
                    suggestedSize = 'M';
                  } else if (chestMeasurement >= 107 &&
                      chestMeasurement < 114) {
                    suggestedSize = 'L';
                  } else if (chestMeasurement >= 114 &&
                      chestMeasurement < 121) {
                    suggestedSize = 'XL';
                  } else if (chestMeasurement >= 121 &&
                      chestMeasurement < 128) {
                    suggestedSize = 'XXL';
                  } else if (chestMeasurement >= 128 &&
                      chestMeasurement < 134) {
                    suggestedSize = 'XXXL';
                  }
                }
                if (chosenCateg == 't-shirt' && gender == 'female') {
                  if (chestMeasurement >= 81 && chestMeasurement < 85) {
                    suggestedSize = 'XS';
                  } else if (chestMeasurement >= 85 && chestMeasurement < 90) {
                    suggestedSize = 'S';
                  } else if (chestMeasurement >= 90 && chestMeasurement < 95) {
                    suggestedSize = 'M';
                  } else if (chestMeasurement >= 95 && chestMeasurement < 102) {
                    suggestedSize = 'L';
                  } else if (chestMeasurement >= 102 &&
                      chestMeasurement < 111) {
                    suggestedSize = 'XL';
                  } else if (chestMeasurement >= 111 &&
                      chestMeasurement < 116) {
                    suggestedSize = 'XXL';
                  } else if (chestMeasurement >= 116 &&
                      chestMeasurement < 123) {
                    suggestedSize = 'XXXL';
                  }
                }
                if (chosenCateg == 'pant' && gender == 'female') {
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
                }
                if (chosenCateg == 'pant' && gender == 'male') {
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
            title: Container(
              child: ButtonWidgetdelete(
                btnText: "Remove Garment",
                onClick: () {
                  setState(() {
                    if (chosenCateg == 't-shirt') {
                      tshirt.position.setValues(1500, 1500, 1500);
                      tshirt.updateTransform();
                    } else if (chosenCateg == 'shirt') {
                      shirt.position.setValues(1500, 1500, 1500);
                      shirt.updateTransform();
                    } else if (chosenCateg == 'pant') {
                      pant.position.setValues(1500, 1500, 1500);
                      pant.updateTransform();
                    } else if (chosenCateg == 'skirt') {
                      skirt.position.setValues(1500, 1500, 1500);
                      skirt.updateTransform();
                    } else if (chosenCateg == 'short-pant') {
                      garmentShortPant.position.setValues(1500, 1500, 1500);
                      garmentShortPant.updateTransform();
                    }

                    print('object');
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
