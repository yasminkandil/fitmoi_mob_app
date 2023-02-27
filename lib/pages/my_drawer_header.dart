import 'package:flutter/material.dart';
import 'package:fitmoi_mob_app/utils/color.dart';

class MyHeaderDrawer extends StatefulWidget {
  @override
  MyHeaderDrawerState createState() => MyHeaderDrawerState();
  // TODO: implement createState
}

class MyHeaderDrawerState extends State<MyHeaderDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: mintColors,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            mintColors,
            mintLightColors,
          ], end: Alignment.bottomCenter, begin: Alignment.topCenter),
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(80))),
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(
              bottom: 10,
            ),
            height: 100,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    spreadRadius: 2,
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.3))
              ],
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/fit_moiiLogo.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
