import 'package:flutter/material.dart';
import 'package:fitmoi_mob_app/utils/color.dart';

class ButtonWidget extends StatelessWidget {
  var btnText = "";
  var onClick;

  ButtonWidget({required this.btnText, this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [mintColors, mintLightColors],
              end: Alignment.centerLeft,
              begin: Alignment.centerRight),
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          btnText,
          style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 64, 64, 64),
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class ButtonWidget2 extends StatelessWidget {
  var btnText = "";
  var onClick;

  ButtonWidget2({required this.btnText, this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: 20,
        height: 30,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [mintColors, mintLightColors],
              end: Alignment.centerLeft,
              begin: Alignment.centerRight),
          borderRadius: BorderRadius.all(
            Radius.circular(80),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          btnText,
          style: TextStyle(
              fontSize: 15,
              color: Color.fromARGB(255, 64, 64, 64),
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class ButtonWidgetdelete extends StatelessWidget {
  var btnText = "";
  var onClick;

  ButtonWidgetdelete({required this.btnText, this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: 20,
        height: 30,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 169, 25, 25),
            Color.fromARGB(255, 235, 37, 37)
          ], end: Alignment.centerLeft, begin: Alignment.centerRight),
          borderRadius: BorderRadius.all(
            Radius.circular(80),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          btnText,
          style: TextStyle(
              fontSize: 15,
              color: Color.fromARGB(255, 249, 248, 248),
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
