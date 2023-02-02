import 'package:flutter/material.dart';
import 'package:fitmoi_mob_app/utils/color.dart';

class ButtonWithImage extends StatelessWidget {
  var btnText = "";
  var onClick;

  ButtonWithImage({required this.btnText, this.onClick});

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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              btnText,
              style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 64, 64, 64),
                  fontWeight: FontWeight.bold),
            ),
            const Image(
              image: AssetImage(
                "assets/googleLogo.png",
              ),
              width: 60,
              height: 70,
            ),
          ],
        ),
      ),
    );
  }
}
