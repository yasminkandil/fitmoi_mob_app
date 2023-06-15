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
<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:flutter/src/material/material.dart';

=======
import 'package:restart_app/restart_app.dart';
>>>>>>> 1470e588bd82a1f6be968bf7152d628f63dbc28e
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
      fileName: 'assets/short-pant_29.obj',
      scale: Vector3(0.09, 0.09, 0.09),
      position: Vector3(0, 0, 0),
      lighting: true);
  Object shirt = Object(
      fileName: 'assets/shirt_$userid.obj',
      scale: Vector3(0.09, 0.09, 0.09),
      position: Vector3(0, 0, 0),
      lighting: true);

<<<<<<< HEAD
  String userid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    human = Object(
        fileName: 'assets/body_$userid.obj'
        // 'E:/grad python/meshes/1/body_1.obj'
        // widget.humanModelPath
        ,
        scale: Vector3.all(0.3),
        position: Vector3(0, 0, 0),
        lighting: true,
        backfaceCulling: false);
    shirt = Object(
      fileName: 'assets/shirt_$userid.obj',
      scale: Vector3(0.09, 0.09, 0.09),
      position: Vector3(0, 0, 0),
      lighting: true,
    );
    garmentShortPant = Object(
        fileName: 'assets/short-pant_$userid.obj',
        scale: Vector3(0.09, 0.09, 0.09),
        position: Vector3(0, 0, 0),
        lighting: true);
    pant = Object(
        fileName: 'assets/pant_$userid.obj',
        scale: Vector3(0.09, 0.09, 0.09),
        position: Vector3(0, 0, 0),
        lighting: true);
    tshirt = Object(
      fileName: 'assets/t-shirt_31.obj',
      // scale: Vector3(0.15, 0.15, 0.15),
      // position: Vector3(0, 0, 0),
      lighting: true,
      // backfaceCulling: false
    );
    skirt = Object(
        fileName: 'assets/skirt_$userid.obj',
        scale: Vector3(0.09, 0.09, 0.09),
        position: Vector3(0, 0, 0),
        lighting: true);
    // loadTexture();

    human.updateTransform();
  }
=======
  Object pant = Object(
      fileName: 'assets/pant_19Al4C30oiUxOK6PLqffKBwj2qE2.obj',
      scale: Vector3(0.08, 0.09, 0.09),
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
>>>>>>> 1470e588bd82a1f6be968bf7152d628f63dbc28e

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
                  ));
                  //chosenCateg = 'short-pant';
                  if (chosenCateg == 'shirt') {
                    loadAsset('assets/shirt_$userid.obj');
                    scene.world.add(shirt);
                  } else if (chosenCateg == 'short-pant') {
                    loadAsset('assets/short-pant_29.obj');
                    scene.world.add(garmentShortPant);
                    setState(() {
                      loadImageFromAsset('assets/short-pant_29.jpg')
                          .then((value) {
                        garmentShortPant.mesh.texture = value;
                        scene.updateTexture();
                      });
                    });
                  } else if (chosenCateg == 'pant') {
                    loadAsset('assets/pant_19Al4C30oiUxOK6PLqffKBwj2qE2.obj');
                    scene.world.add(pant);
                    loadImageFromAsset(
                            'assets/pant_19Al4C30oiUxOK6PLqffKBwj2qE2.jpg')
                        .then((value) {
                      pant.mesh.texture = value;
                      scene.updateTexture();
                    });
                  } else if (chosenCateg == 't-shirt') {
                    scene.world.add(tshirt);
                    setState(() {
                      loadImageFromAsset('assets/t-shirt_$userid.jpg')
                          .then((value) {
                        tshirt.mesh.texture = value;
                        //scene.updateTexture();
                      });
                    });
                  } else if (chosenCateg == 'skirt') {
                    loadAsset('assets/skirt_$userid.obj');
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
                double hipMeasurement = userData['hip'] ?? 0;
                String gender = userData['gender'] ?? 0;
                String suggestedSize = 'Sorry, your size is not available';
                if (chosenCateg == 't-shirt' && gender == 'male') {
                  if (chestMeasurement >= 81 &&
                      chestMeasurement <= 86 &&
                      height >= 155 &&
                      height <= 160) {
                    suggestedSize = "X-Small";
                  } else if (chestMeasurement >= 86 &&
                      chestMeasurement <= 96 &&
                      height >= 160 &&
                      height <= 170) {
                    suggestedSize = "Small";
                  } else if (chestMeasurement >= 96 &&
                      chestMeasurement <= 106 &&
                      height >= 170 &&
                      height <= 175) {
                    suggestedSize = "Medium";
                  } else if (chestMeasurement >= 106 &&
                      chestMeasurement <= 116 &&
                      height >= 175 &&
                      height <= 180) {
                    suggestedSize = "Large";
                  } else if (chestMeasurement >= 116 &&
                      chestMeasurement <= 126 &&
                      height >= 180 &&
                      height <= 185) {
                    suggestedSize = "X-Large";
                  } else if (chestMeasurement >= 126 &&
                      chestMeasurement <= 132 &&
                      height >= 185 &&
                      height <= 190) {
                    suggestedSize = "XX-Large";
                  } else if (chestMeasurement >= 81 &&
                      chestMeasurement <= 86 &&
                      height >= 160 &&
                      height <= 170) {
                    suggestedSize = "Small/X-Small";
                  } else if (chestMeasurement >= 86 &&
                      chestMeasurement <= 96 &&
                      height >= 170 &&
                      height <= 175) {
                    suggestedSize = "Medium/Small";
                  } else if (chestMeasurement >= 96 &&
                      chestMeasurement <= 106 &&
                      height >= 175 &&
                      height <= 180) {
                    suggestedSize = "Large/Medium";
                  } else if (chestMeasurement >= 106 &&
                      chestMeasurement <= 116 &&
                      height >= 180 &&
                      height <= 185) {
                    suggestedSize = "X-Large/Large";
                  } else if (chestMeasurement >= 116 &&
                      chestMeasurement <= 126 &&
                      height >= 185 &&
                      height <= 190) {
                    suggestedSize = "XX-Large/X-Large";
                  } else {
                    suggestedSize = "Size not available";
                  }
                } else if (chosenCateg == 't-shirt' && gender == 'female') {
                  if (chestMeasurement >= 80 &&
                      chestMeasurement <= 86 &&
                      height >= 150 &&
                      height <= 155) {
                    suggestedSize = "X-Small";
                  } else if (chestMeasurement >= 86 &&
                      chestMeasurement <= 92 &&
                      height >= 155 &&
                      height <= 165) {
                    suggestedSize = "Small";
                  } else if (chestMeasurement >= 92 &&
                      chestMeasurement <= 96 &&
                      height >= 165 &&
                      height <= 170) {
                    suggestedSize = "Medium";
                  } else if (chestMeasurement >= 96 &&
                      chestMeasurement <= 102 &&
                      height >= 170 &&
                      height <= 175) {
                    suggestedSize = "Large";
                  } else if (chestMeasurement >= 102 &&
                      chestMeasurement <= 106 &&
                      height >= 175 &&
                      height <= 180) {
                    suggestedSize = "X-Large";
                  } else if (chestMeasurement >= 106 &&
                      chestMeasurement <= 112 &&
                      height >= 180 &&
                      height <= 185) {
                    suggestedSize = "XX-Large";
                  } else if (chestMeasurement >= 80 &&
                      chestMeasurement <= 86 &&
                      height >= 155 &&
                      height <= 165) {
                    suggestedSize = "Small/X-Small";
                  } else if (chestMeasurement >= 86 &&
                      chestMeasurement <= 92 &&
                      height >= 155 &&
                      height <= 165) {
                    suggestedSize = "Small/Medium";
                  } else if (chestMeasurement >= 92 &&
                      chestMeasurement <= 96 &&
                      height >= 165 &&
                      height <= 170) {
                    suggestedSize = "Medium/Small";
                  } else if (chestMeasurement >= 96 &&
                      chestMeasurement <= 102 &&
                      height >= 170 &&
                      height <= 175) {
                    suggestedSize = "Large/Medium";
                  } else if (chestMeasurement >= 102 &&
                      chestMeasurement <= 106 &&
                      height >= 175 &&
                      height <= 180) {
                    suggestedSize = "X-Large/Large";
                  } else if (chestMeasurement >= 106 &&
                      chestMeasurement <= 112 &&
                      height >= 180 &&
                      height <= 185) {
                    suggestedSize = "XX-Large/X-Large";
                  } else {
                    suggestedSize = "Size not available";
                  }
                } else if (chosenCateg == 'short-pant' && gender == 'female') {
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
                } else if (chosenCateg == 'short-pant' && gender == 'male') {
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
