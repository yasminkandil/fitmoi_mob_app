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
Future<String> getChestData() async {
  DocumentSnapshot userSnapshot = await userRef.get();
  if (userSnapshot.exists) {
    Map<String, dynamic>? userData =
        userSnapshot.data() as Map<String, dynamic>?;
    dynamic chestData = userData!['chest'];
    dynamic backData = userData['back'];

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
      fileName: 'assets/short-pant_$userid.obj',
      scale: Vector3(0.09, 0.09, 0.09),
      position: Vector3(0, 0, 0),
      lighting: true);
  Object shirt = Object(
      fileName: 'assets/shirt_$userid.obj',
      scale: Vector3(0.09, 0.09, 0.09),
      position: Vector3(0, 0, 0),
      lighting: true);

  Object pant = Object(
      fileName: 'assets/pant_$userid.obj',
      scale: Vector3(0.09, 0.09, 0.09),
      position: Vector3(0, 0, 0),
      lighting: true);
  Object tshirt = Object(
    fileName: 'assets/t-shirt_$userid.obj',
    scale: Vector3(0.16, 0.17, 0.18),
    position: Vector3(0, 0, 0),
    lighting: true,
    backfaceCulling: false,
    // isAsset: false
  );
  Object skirt = Object(
      fileName: 'assets/skirt_$userid.obj',
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
                  loadAsset('assets/body_$userid.obj');
                  scene.world.add(Object(
                      fileName: 'assets/body_$userid.obj',
                      scale: Vector3.all(0.3),
                      position: Vector3(0, 0, 0),
                      lighting: true,
                      backfaceCulling: false));
                  chosenCateg = 't-shirt';
                  if (remove == false) {
                    if (chosenCateg == 'shirt') {
                      loadAsset('assets/shirt_$userid.obj');
                      scene.world.add(shirt);
                    } else if (chosenCateg == 'short-pant') {
                      loadAsset('assets/short-pant_$userid.obj');
                      scene.world.add(garmentShortPant);
                      setState(() {
                        loadImageFromAsset('assets/short-pant_$userid.jpg')
                            .then((value) {
                          garmentShortPant.mesh.texture = value;
                          scene.updateTexture();
                        });
                      });
                    } else if (chosenCateg == 'pant') {
                      loadAsset('assets/pant_$userid.obj');
                      scene.world.add(pant);
                      loadImageFromAsset('assets/pant_$userid.jpg')
                          .then((value) {
                        pant.mesh.texture = value;
                        scene.updateTexture();
                      });
                    } else if (chosenCateg == 't-shirt') {
                      loadAsset('assets/t-shirt_$userid.obj');
                      loadAsset('assets/t-shirt_$userid.mtl');
                      loadAsset('assets/t-shirt_$userid.jpg');
                      scene.world.add(tshirt);
                      setState(() {
                        loadImageFromAsset('assets/t-shirt_$userid.jpg')
                            .then((value) {
                          tshirt.mesh.texture = value;
                          scene.updateTexture();
                        });
                      });
                    } else if (chosenCateg == 'skirt') {
                      loadAsset('assets/skirt_$userid.obj');
                      scene.world.add(skirt);
                    }
                  } else if (remove == true) {
                    print('yasso');
                    setState(() {
                      tshirt.position.setValues(1500, 1500, 1500);
                      tshirt.updateTransform();
                    });
                  }
                  scene.camera.zoom = 15;
                  scene.updateTexture();
                  // scene.world.add(Object(fileName: 'assets/turtle.obj'));
                  // scene.camera.position.setFrom(Vector3(0, 0, 0.1));
                  // scene.light.position.setFrom(Vector3(0, 0.2, 0.2));
                  //scene.light.ambient.rgb = Vector3(0.5, 0.5, 0.5);
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
                double height = userData['height'] ?? 0;
                double weight = userData['weight'] ?? 0;
                double hip = userData['hip'] ?? 0;
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
