import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitmoi_mob_app/pages/components/componentsCategory.dart';
import 'package:fitmoi_mob_app/utils/color.dart';
import 'package:fitmoi_mob_app/widgets/app_bar.dart';
import 'package:fitmoi_mob_app/widgets/btn_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/material.dart';

import 'dart:ui' as ui;

class HumanModelPage extends StatefulWidget {
  final String humanModelPath;

  HumanModelPage({required this.humanModelPath});

  @override
  _HumanModelPageState createState() => _HumanModelPageState();
}

class _HumanModelPageState extends State<HumanModelPage> {
  late Object human;
  late Object garmentShortPant;
  late Object shirt;
  late Object pant;
  late Object skirt;
  late Object tshirt;
  bool remove = false;
  late Texture tshirtTexture;

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
<<<<<<< HEAD
        fileName: 'assets/lol/t-shirt_$userid.obj',
        scale: Vector3(0.15, 0.15, 0.15),
        position: Vector3(0, 0, 0),
        lighting: true);
=======
      fileName: 'assets/t-shirt_31.obj',
      // scale: Vector3(0.15, 0.15, 0.15),
      // position: Vector3(0, 0, 0),
      lighting: true,
      // backfaceCulling: false
    );
>>>>>>> 49d85e7ba3bb1a351fd98307ea646d3cbe02e235
    skirt = Object(
        fileName: 'assets/skirt_$userid.obj',
        scale: Vector3(0.09, 0.09, 0.09),
        position: Vector3(0, 0, 0),
        lighting: true);
    // loadTexture();

    human.updateTransform();
  }

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
                  // scene.world.add(human);
                  //chosenCateg = 't-shirt';
                  if (remove == false) {
                    if (chosenCateg == 'shirt') {
                      //scene.world.add(shirt);
                    } else if (chosenCateg == 'short-pant') {
                      // scene.world.add(garmentShortPant);
                    } else if (chosenCateg == 'pant') {
                      // scene.world.add(pant);
                    } else if (chosenCateg == 't-shirt') {
                      // scene.world.add(tshirt);
                      // loadImageFromAsset('assets/t-shirt_31.png').then((value) {
                      //   tshirt.mesh.texture = value;
                      //   scene.updateTexture();
                      // }
                      //);
                    } else if (chosenCateg == 'skirt') {
                      // scene.world.add(skirt);
                    }
                  } else {
                    scene.world.remove(tshirt);
                  }
                  scene.camera.zoom = 15;
                  scene.updateTexture();
                  scene.world.add(Object(fileName: 'assets/turtle.obj'));
                  // scene.camera.position.setFrom(Vector3(0, 0, 0.1));
                  // scene.light.position.setFrom(Vector3(0, 0.2, 0.2));
                  //scene.light.ambient.rgb = Vector3(0.5, 0.5, 0.5);
                  // scene.light.position == scene.camera.position;
                  // scene.textureBlendMode = BlendMode.hardLight;
                },
              ),
            ),
          ),
          ListTile(
            title: Container(
              child: ButtonWidgetdelete(
                btnText: "Remove Garment",
                onClick: () {
                  setState(() {
                    remove = true;
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
