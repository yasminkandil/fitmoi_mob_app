import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import "package:path/path.dart" as p;
import 'package:uuid/uuid.dart';
import '../models/user_model.dart';
import '../utils/color.dart';
import '../widgets/app_bar.dart';
import '../widgets/btn_widget.dart';
import '../widgets/header_container.dart';
import '../widgets/reg_textinput.dart';
import '../widgets/textInput.dart';
import '../widgets/upload_images.dart';

TextEditingController _emailController =
    TextEditingController(text: FirebaseAuth.instance.currentUser!.email);
TextEditingController _reason = TextEditingController();
var _imageUrl;
var _imageUrl2;
var imagee;
var imagee2;
var _greyimage =
    'https://media.tarkett-image.com/large/TH_24567080_24594080_24596080_24601080_24563080_24565080_24588080_001.jpg';
var _greyimage2 =
    'https://media.tarkett-image.com/large/TH_24567080_24594080_24596080_24601080_24563080_24565080_24588080_001.jpg';
var _imagepath;
var _imagepath2;
var random = Random();
int randomNumber = random.nextInt(1000);
final _uuid = Uuid();
Future addRefund(String useremail, String reason, String image1, String image2,
    String prodid, String id) async {
  await FirebaseFirestore.instance.collection('refunds').doc(id).set({
    'useremail': useremail,
    'reason': reason,
    'image1': image1,
    'image2': image2,
    'prodId': prodid,
    'id': id,
  });
}

_setImage(String imagee) {
  imagee = imagee;
}

_getImage() {
  return imagee;
}

_setImage2(String imagee2) {
  imagee2 = imagee2;
}

_getImage2() {
  return imagee2;
}

class Refund extends StatefulWidget {
  String prodid;
  Refund({super.key, required this.prodid});

  @override
  State<Refund> createState() => _RefundState();
}

class _RefundState extends State<Refund> {
  uploadImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile? _image;

    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    //Select Image
    _image = await _picker.getImage(source: ImageSource.gallery);
    var file = File(_image!.path);

    if (_image != null) {
      //Upload to Firebase
      var snapshot =
          await _storage.ref().child(p.basename(_image.path)).putFile(file);

      var _downloadUrl = await snapshot.ref.getDownloadURL();

      setState(() {
        _imageUrl = _downloadUrl;
        _greyimage = _imageUrl;
        _setImage(_imageUrl);
        _getImage();
      });
    } else {
      Fluttertoast.showToast(msg: 'Grant Permissions and try again');
      return null;
    }
  }

  uploadImage2() async {
    final _storage2 = FirebaseStorage.instance;
    final _picker2 = ImagePicker();
    PickedFile? _image2;

    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    //Select Image
    _image2 = await _picker2.getImage(source: ImageSource.gallery);
    var file = File(_image2!.path);

    if (_image2 != null) {
      //Upload to Firebase
      var snapshot =
          await _storage2.ref().child(p.basename(_image2.path)).putFile(file);

      var _downloadUrl2 = await snapshot.ref.getDownloadURL();

      setState(() {
        _imageUrl2 = _downloadUrl2;
        _greyimage2 = _imageUrl2;
        _setImage2(_imageUrl2);
        _getImage2();
      });
    } else {
      print('No Path Received');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: ""),
      body: SingleChildScrollView(
        child: IntrinsicHeight(
          child: Container(
            padding: const EdgeInsets.only(bottom: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                HeaderContainer("Refund Form"),
                SizedBox(
                  height: 20,
                ),
                Text(
                  textAlign: TextAlign.center,
                  "  Please upload a front and back picture for your product",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: mintColors,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    UploadBodyImages(
                        textt: "Front image",
                        onPressed: () async {
                          uploadImage();
                        },
                        imagepath: _greyimage),
                    UploadBodyImages(
                        textt: "Back image",
                        onPressed: () async {
                          uploadImage2();
                        },
                        imagepath: _greyimage2),
                  ],
                ),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: IntrinsicHeight(
                      child: Container(
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 30),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            RegTextInput(
                              controller: _emailController,
                              hint: "Email",
                              icon: Icons.email,
                              torf: false,
                              errormssg: emailerrormssg,
                              regexp: eregexp,
                              enable: true,
                            ),
                            TextInput(
                              controller: _reason,
                              hint: "Provide Reason",
                              icon: Icons.edit,
                            ),
                            Expanded(
                              child: Center(
                                child: ButtonWidget(
                                  onClick: () {
                                    addRefund(
                                            _emailController.text,
                                            _reason.text,
                                            _greyimage,
                                            _greyimage2,
                                            widget.prodid,
                                            _uuid.v4())
                                        .then(
                                      (value) {
                                        Fluttertoast.showToast(
                                          msg: "Refund Request Sent...",
                                          //backgroundColor: mintColors
                                        );
                                        Navigator.of(context).pop();
                                      },
                                    );
                                  },
                                  btnText: "Send Request",
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
      ),
    );
  }
}
