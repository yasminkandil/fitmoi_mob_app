import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitmoi_mob_app/pages/components/componentsCategory.dart';
import 'package:fitmoi_mob_app/utils/color.dart';
import 'package:fitmoi_mob_app/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';

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

  String userid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    human = Object(
        fileName: 'assets/body_$userid.obj'
        // 'E:/grad python/meshes/1/body_1.obj'
        // widget.humanModelPath
        ,
        scale: Vector3.all(0.3),
        position: Vector3(0, 0, 0),
        lighting: true);
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
        fileName: 'assets/pant_$userid.obj',
        scale: Vector3(0.09, 0.09, 0.09),
        position: Vector3(0, 0, 0),
        lighting: true);
    tshirt = Object(
        fileName: 'assets/t-shirt_$userid.obj',
        scale: Vector3(0.15, 0.15, 0.15),
        position: Vector3(0, 0, 0),
        lighting: true);
    skirt = Object(
        fileName: 'assets/skirt_$userid.obj',
        scale: Vector3(0.09, 0.09, 0.09),
        position: Vector3(0, 0, 0),
        lighting: true);
    human.updateTransform();
    super.initState();
  }

  @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: CustomAppBar(
  //       text: "View 3D Model",
  //     ),
  //     body: Center(child: Cube(
  //       onSceneCreated: (Scene scene) {
  //         //scene.light.ambient.rgb;
  //         scene.world.add(human);
  //         if (chosenCateg == 'shirt') {
  //           scene.world.add(shirt);
  //         } else if (chosenCateg == 'short-pant') {
  //           scene.world.add(garmentShortPant);
  //         } else if (chosenCateg == 'pant') {
  //           scene.world.add(pant);
  //         } else if (chosenCateg == 't-shirt') {
  //           scene.world.add(tshirt);
  //         } else if (chosenCateg == 'skirt') {
  //           scene.world.add(skirt);
  //         }
  //         scene.camera.zoom = 10;
  //         // scene.camera.position.setFrom(Vector3(0, 0, 0.1));
  //         scene.light.position.setFrom(Vector3(0, 0.2, 0.2));
  //         //scene.light.ambient.rgb = Vector3(0.5, 0.5, 0.5);
  //         // scene.light.position == scene.camera.position;
  //         scene.textureBlendMode = BlendMode.hardLight;
  //       },
  //     )),
  //   );
  // }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: "View 3D Model",
      ),
      body: Column(
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
                  scene.world.add(human);
                  if (chosenCateg == 'shirt') {
                    scene.world.add(shirt);
                  } else if (chosenCateg == 'short-pant') {
                    scene.world.add(garmentShortPant);
                  } else if (chosenCateg == 'pant') {
                    scene.world.add(pant);
                  } else if (chosenCateg == 't-shirt') {
                    scene.world.add(tshirt);
                  } else if (chosenCateg == 'skirt') {
                    scene.world.add(skirt);
                  }
                  scene.camera.zoom = 15;
                  // scene.camera.position.setFrom(Vector3(0, 0, 0.1));
                  scene.light.position.setFrom(Vector3(0, 0.2, 0.2));
                  //scene.light.ambient.rgb = Vector3(0.5, 0.5, 0.5);
                  // scene.light.position == scene.camera.position;
                  scene.textureBlendMode = BlendMode.hardLight;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
