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

import 'dart:ui' as ui;

import 'package:get/get_connect/http/src/utils/utils.dart';

class HumanModelPage extends StatefulWidget {
  final String humanModelPath;

  HumanModelPage({required this.humanModelPath});

  @override
  _HumanModelPageState createState() => _HumanModelPageState();
}

String userid = FirebaseAuth.instance.currentUser!.uid;

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
                  scene.world.add(Object(
                      fileName: 'assets/body_$userid.obj',
                      scale: Vector3.all(0.3),
                      position: Vector3(0, 0, 0),
                      lighting: true,
                      backfaceCulling: false));
                  //chosenCateg = 'short-pant';
                  if (remove == false) {
                    if (chosenCateg == 'shirt') {
                      scene.world.add(shirt);
                    } else if (chosenCateg == 'short-pant') {
                      scene.world.add(garmentShortPant);
                      setState(() {
                        loadImageFromAsset('assets/short-pant_$userid.jpg')
                            .then((value) {
                          garmentShortPant.mesh.texture = value;
                          scene.updateTexture();
                        });
                      });
                    } else if (chosenCateg == 'pant') {
                      scene.world.add(pant);
                      loadImageFromAsset('assets/pant_$userid.jpg')
                          .then((value) {
                        pant.mesh.texture = value;
                        scene.updateTexture();
                      });
                    } else if (chosenCateg == 't-shirt') {
                      scene.world.add(tshirt);
                      loadImageFromAsset('assets/t-shirt_$userid.jpg')
                          .then((value) {
                        tshirt.mesh.texture = value;
                        scene.updateTexture();
                      });
                    } else if (chosenCateg == 'skirt') {
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
