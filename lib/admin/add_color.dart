import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fitmoi_mob_app/admin/add_product.dart';
import 'package:fitmoi_mob_app/utils/color.dart';
import 'package:fitmoi_mob_app/widgets/btn_widget.dart';
import '../models/product_model.dart';
import '../widgets/app_bar.dart';
import '../widgets/reg_textinput.dart';
//import 'package:fitmoi_mob_app/widgets/header_container.dart';

class AddColorPage extends StatefulWidget {
  @override
  _AddColorPageState createState() => _AddColorPageState();
}

TextEditingController _colorController = TextEditingController();

class _AddColorPageState extends State<AddColorPage> {
  final _colorController = TextEditingController();
  Future addColor(String color) async {
    await FirebaseFirestore.instance.collection('colors').doc().set({
      'color': color,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "Add Color"),
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      RegTextInput(
                          controller: _colorController,
                          hint: "Colors",
                          icon: Icons.color_lens,
                          torf: false,
                          errormssg: errormssg,
                          regexp: aregexp,
                          enable: true),
                      Center(
                        child: ListTile(
                          title: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Expanded(
                                child: ButtonWidget2(
                                  btnText: "Add Color",
                                  onClick: () {
                                    if (formKey.currentState!.validate()) {
                                      addColor(_colorController.text)
                                          .then((value) {
                                        Fluttertoast.showToast(
                                            msg: "Color addedd...",
                                            backgroundColor: mintColors);
                                        Navigator.pop(context);
                                      });
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
