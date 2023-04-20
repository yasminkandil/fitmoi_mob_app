import 'package:flutter/material.dart';
import 'package:fitmoi_mob_app/utils/color.dart';

class HeaderContainer extends StatelessWidget {
  var text = "Login";

  HeaderContainer(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.20,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            GreyColors,
            GreyLightColors,
          ], end: Alignment.bottomCenter, begin: Alignment.topCenter),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80))),
      child: Stack(
        children: <Widget>[
          Center(
            child: Image.asset("assets/yasmin-011.png"),
          ),
        ],
      ),
    );
  }
}
