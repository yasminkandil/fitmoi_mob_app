import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
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
    garmentShortPant = Object(
        fileName: 'assets/short-pant_$userid.obj'
        //'E:/grad%20python/meshes/1/body_1.obj'
        // widget.humanModelPath
        ,
        scale: Vector3(0.09, 0.09, 0.09),
        position: Vector3(0, 0, 0),
        lighting: true);
    human.updateTransform();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Human Model Viewer'),
        ),
        body: Center(
            // child: ModelViewer(
            //   src: 'assets/body_1.obj',
            //   //alt: 'A 3D model of a human body',
            //   ar: true,
            //   autoRotate: true,
            //   cameraControls: true,
            //   //poster: 'assets/body_1.png',
            // ),
            child: Cube(
          onSceneCreated: (Scene scene) {
            //scene.light.ambient.rgb;
            scene.world.add(human);
            scene.world.add(garmentShortPant);
            scene.camera.zoom = 10;
            // scene.camera.position.setFrom(Vector3(0, 0, 0.1));
            scene.light.position.setFrom(Vector3(0, 0.2, 0.2));
            //scene.light.ambient.rgb = Vector3(0.5, 0.5, 0.5);
            // scene.light.position == scene.camera.position;
            scene.textureBlendMode = BlendMode.hardLight;
          },
        )));
  }
}
