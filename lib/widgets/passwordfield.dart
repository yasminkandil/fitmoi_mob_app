import 'package:flutter/material.dart';
import 'package:fitmoi_mob_app/utils/color.dart';

class PasswordField extends StatefulWidget {
  String hintText;
  bool obscureText;
  TextEditingController Controller;
  String perrormssg;

  PasswordField(
      {Key? key,
      required this.hintText,
      required this.obscureText,
      required this.Controller,
      required this.perrormssg})
      : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.only(left: 10),
      child: TextFormField(
        controller: widget.Controller,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hintText,
            prefixIcon: const Icon(
              Icons.vpn_key,
              color: Color.fromARGB(255, 10, 169, 159),
            ),
            suffixIcon: InkWell(
              onTap: () {
                setState(() {
                  widget.obscureText = !widget.obscureText;
                });
              },
              child: Icon(
                  widget.obscureText ? Icons.visibility : Icons.visibility_off),
            )),
        validator: (value) {
          if (value!.isEmpty || widget.Controller.text.length < 6) {
            return widget.perrormssg;
          } else {
            return null;
          }
        },
      ),
    );
  }
}
