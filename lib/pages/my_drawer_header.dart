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
      color: mintColors,
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
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/logoGrey.jpeg'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
