import 'package:flutter/material.dart';
import 'package:fitmoi_mob_app/utils/color.dart';

class TextInput extends StatelessWidget {
  String hint;
  IconData icon;
  TextEditingController controller;
  TextInput(
      {Key? key,
      required this.controller,
      required this.icon,
      required this.hint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(
            icon,
            color: mintColors,
          ),
        ),
      ),
    );
  }
}
