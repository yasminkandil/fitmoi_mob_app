import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitmoi_mob_app/admin/add_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/category_model.dart';
import '../utils/color.dart';
import '../widgets/app_bar.dart';
import '../widgets/btn_widget.dart';
import '../widgets/reg_textinput.dart';

class EditCateg extends StatefulWidget {
  List<String> subcategory;
  String id;
  String name;
  EditCateg({
    super.key,
    required this.id,
    required this.subcategory,
    required this.name,
  });
  @override
  State<EditCateg> createState() => _EditCategState();
}

class _EditCategState extends State<EditCateg> {
  final _nameController = TextEditingController();
  final TextEditingController _subcategController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: "Edit Category",
      ),
      body: Container(
        child: Column(
          children: [
            Column(
              children: [
                Text(
                  "Edit Category Name",
                  style: TextStyle(
                      color: mintColors,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                RegTextInput(
                    controller: _nameController,
                    hint: widget.name,
                    icon: Icons.category,
                    torf: false,
                    errormssg: errormssg,
                    regexp: mregexp,
                    enable: true),
              ],
            ),
            Column(
              children: [
                Container(
                  child: Text(
                    "Edit subcategory",
                    style: TextStyle(
                        color: mintColors,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                RegTextInput(
                    controller: _subcategController,
                    hint: "type subcategory to add or delete",
                    icon: Icons.category,
                    torf: false,
                    errormssg: errormssg,
                    regexp: mregexp,
                    enable: true),
                SizedBox(
                  height: 10.0,
                ),
                ListTile(
                  title: Row(
                    children: <Widget>[
                      Expanded(
                        child: ButtonWidget2(
                          btnText: "Add subcategory",
                          onClick: () {
                            widget.subcategory.add(_subcategController.text);
                            FirebaseFirestore.instance
                                .collection('categ')
                                .doc(widget.id)
                                .update({'subtitle': widget.subcategory}).then(
                              (value) {
                                print("updated..");
                                Fluttertoast.showToast(msg: ' Updated..');

                                Navigator.pushNamed(context, 'homepage');
                              },
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: ButtonWidgetdelete(
                          btnText: "Delete SubCategory",
                          onClick: () {
                            widget.subcategory.remove(_subcategController.text);
                            final deleteprod = FirebaseFirestore.instance
                                .collection('categ')
                                .doc(widget.id)
                                .update({'subtitle': widget.subcategory}).then(
                                    (value) => Navigator.pop(context));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Container(
                    height: 50,
                    child: Expanded(
                      child: ButtonWidget(
                        btnText: "Edit Category name",
                        onClick: () {
                          final deleteprod = FirebaseFirestore.instance
                              .collection('categ')
                              .doc(widget.id)
                              .update({
                            'name': _nameController.text.trim()
                          }).then((value) => Fluttertoast.showToast(
                                  msg: "Category name edited",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: mintColors,
                                  textColor: Colors.black,
                                  fontSize: 16.0));
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
