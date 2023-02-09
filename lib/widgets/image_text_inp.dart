import 'package:flutter/material.dart';
import 'package:fitmoi_mob_app/utils/color.dart';

class ImageTextInp extends StatelessWidget {
  String hint;
  String icon;
  TextEditingController controller;
  bool torf;
  String regexp;
  String errormssg;
  bool enable;
  ImageTextInp({
    Key? key,
    required this.controller,
    required this.icon,
    required this.hint,
    required this.torf,
    required this.errormssg,
    required this.regexp,
    required this.enable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: 10),
      child: TextFormField(
        obscureText: torf,
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          enabled: enable,
          prefixIcon: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(icon),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        validator: (value) {
          bool Valid = RegExp(regexp).hasMatch(value!);
          if (value.isEmpty || !Valid) {
            return errormssg;
          } else {
            return null;
          }
        },
      ),
    );
  }
}
