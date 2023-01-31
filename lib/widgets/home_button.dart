import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fitmoi_mob_app/utils/color.dart';
import 'package:velocity_x/velocity_x.dart';

Widget homeButton({width, height, icon, String? title, onPress}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          size: 30,
          color: mintColors,
        ),
        HeightBox(6),
        Text(title!,
            style: TextStyle(
              fontSize: 24,
              color: Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.bold,
            ))
      ],
    )
        .box
        .rounded
        .white
        .size(width, height)
        .color(Colors.white30)
        .shadowSm
        .make(),
  );
}
