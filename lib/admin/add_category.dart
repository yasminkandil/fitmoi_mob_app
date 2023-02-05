import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fitmoi_mob_app/admin/add_product.dart';
import 'package:fitmoi_mob_app/utils/color.dart';
import 'package:fitmoi_mob_app/widgets/app_bar.dart';
import 'package:fitmoi_mob_app/widgets/btn_widget.dart';
import '../models/product_model.dart';
import '../widgets/reg_textinput.dart';
//import 'package:fitmoi_mob_app/widgets/header_container.dart';

class AddCategPage extends StatefulWidget {
  @override
  _AddCategPageState createState() => _AddCategPageState();
}

class _AddCategPageState extends State<AddCategPage> {
  uploadImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile? image;
    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;
    image = await _picker.getImage(source: ImageSource.gallery);
    var file = File(image!.path);
    if (permissionStatus.isGranted) {
      var snapshot = await _storage
          .ref()
          .child('categories/${_nameController.text}')
          .putFile(file);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        imageUrl = downloadUrl;
        greyimage = imageUrl;
        setImage(imageUrl);
        getImage();
      });
      return downloadUrl;
    } else {
      Fluttertoast.showToast(msg: 'Grant Permissions and try again');
      return null;
    }
  }

  final _nameController = TextEditingController();
  final _subtitleController = TextEditingController();
  Future addCategory(String name, List<String> subtitle) async {
    await FirebaseFirestore.instance.collection('categ').doc().set({
      'name': name,
      'subtitle': subtitle,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "Add Category"),
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: Column(
            children: <Widget>[
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 140,
                      height: 110,
                      decoration: BoxDecoration(
                          border: Border.all(width: 4, color: Colors.white),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(greyimage))),
                    ),
                    Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 2,
                                  color: Colors.white,
                                ),
                                color: Colors.orange),
                            child: TextButton(
                              child: Center(
                                child: Icon(
                                  Icons.upload,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                uploadImage();
                              },
                            )))
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: IntrinsicHeight(
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          RegTextInput(
                              controller: _nameController,
                              hint: "Category Name",
                              icon: Icons.category,
                              torf: false,
                              errormssg: errormssg,
                              regexp: aregexp,
                              enable: true),
                          RegTextInput(
                              controller: _subtitleController,
                              hint: "Category Subtitle",
                              icon: Icons.category,
                              torf: false,
                              errormssg: errormssg,
                              regexp: aregexp,
                              enable: true),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: ButtonWidget(
                              onClick: () {
                                setState(() {
                                  categList.add(_subtitleController.text);
                                  Fluttertoast.showToast(
                                      msg: "Subcategory Added",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor:
                                          Color.fromARGB(255, 10, 169, 159),
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  setCateg(categList);
                                  // pp.colorController.clear();
                                });
                              },
                              btnText: 'Add Subcategory',
                            ),
                          ),
                          Center(
                            child: ListTile(
                              title: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Expanded(
                                    child: ButtonWidget2(
                                      btnText: "Add Category",
                                      onClick: () {
                                        if (formKey.currentState!.validate()) {
                                          addCategory(_nameController.text,
                                                  getCateg())
                                              .then((value) {
                                            categList.clear();
                                            Fluttertoast.showToast(
                                                msg: "Category addedd...",
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
