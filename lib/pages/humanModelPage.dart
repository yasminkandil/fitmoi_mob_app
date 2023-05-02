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
    //super.initState();
    // human =
    shirt = Object(
        fileName: 'assets/shirt_$userid.obj',
        scale: Vector3(0.09, 0.09, 0.09),
        position: Vector3(0, 0, 0),
        lighting: true);
    garmentShortPant = Object(
        fileName: 'assets/short-pant_$userid.obj',
        scale: Vector3(0.09, 0.09, 0.09),
        position: Vector3(0, 0, 0),
        lighting: true);
    pant = Object(
        fileName: 'assets/short-pant_$userid.obj',
        scale: Vector3(0.09, 0.10, 0.09),
        position: Vector3(0, 0, 0),
        lighting: true);
    tshirt = Object(
      fileName: 'assets/t-shirt_$userid.obj',
      scale: Vector3(0.15, 0.15, 0.15),
      position: Vector3(0, 0, 0),
      lighting: true,
      backfaceCulling: false,
      // isAsset: false
    );
    skirt = Object(
        fileName: 'assets/skirt_$userid.obj',
        scale: Vector3(0.09, 0.09, 0.09),
        position: Vector3(0, 0, 0),
        lighting: true);
    // loadTexture();

    //human.updateTransform();
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
                  scene.world.add(Object(
                      fileName:
                          // 'E:/grad python/meshes/pqmW98wYWMelFQa7OXSmzj3ZgJJ2/body_$userid.obj'
                          // 'E:/grad python/meshes/1/body_1.obj'
                          // widget.humanModelPath
                          'assets/body_$userid.obj',
                      scale: Vector3.all(0.3),
                      position: Vector3(0, 0, 0),
                      lighting: true,
                      // isAsset: false,
                      backfaceCulling: false));
                  chosenCateg = 'short-pant';
                  if (remove == false) {
                    if (chosenCateg == 'shirt') {
                      scene.world.add(shirt);
                    } else if (chosenCateg == 'short-pant') {
                      scene.world.add(garmentShortPant);
                      loadImageFromAsset('assets/short-pant_$userid.jpg')
                          .then((value) {
                        garmentShortPant.mesh.texture = value;
                        scene.updateTexture();
                      });
                    } else if (chosenCateg == 'pant') {
                      scene.world.add(pant);
                      loadImageFromAsset('assets/short-pant_$userid.jpg')
                          .then((value) {
                        pant.mesh.texture = value;
                        scene.updateTexture();
                      });
                    } else if (chosenCateg == 't-shirt') {
//                       String filePath = '/storage/emulated/0/Download/my_texture.png';

// // Create a CubeAssetBundle with the FileAssetProvider
// CubeAssetBundle assetBundle = CubeAssetBundle(FileAssetProvider(filePath));
                      scene.world.add(tshirt);
                      loadImageFromAsset('assets/short-pant_$userid.jpg')
                          .then((value) {
                        tshirt.mesh.texture = value;
                        scene.updateTexture();
                      });
                    } else if (chosenCateg == 'skirt') {
                      scene.world.add(skirt);
                    }
                  } else {
                    scene.world.remove(tshirt);
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
