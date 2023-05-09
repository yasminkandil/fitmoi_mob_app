import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitmoi_mob_app/models/measurments.dart';
import 'package:fitmoi_mob_app/pages/bodyMeasurments.dart';
import 'package:fitmoi_mob_app/services/api_getM.dart';
import 'package:fitmoi_mob_app/widgets/alert.dart';
import 'package:fitmoi_mob_app/widgets/loading_indecator.dart';
import 'package:fitmoi_mob_app/widgets/message_dialog.dart';
import 'package:fitmoi_mob_app/widgets/uploadFunc.dart';
import 'package:fitmoi_mob_app/widgets/upload_images.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import '../../../models/user_model.dart';
import '../../../utils/color.dart';
import '../../../widgets/btn_widget.dart';
import '../../../widgets/image_text_inp.dart';
import 'dart:io';

import '../../../widgets/start.dart';
import '../../../widgets/uploadbody.dart';

TextEditingController _heightController = TextEditingController();
TextEditingController _weightController = TextEditingController();
File? frontimagee = null;
File? sideimagee = null;
File? backimagee = null;

class TryyOn extends StatefulWidget {
  String prodId;

  TryyOn({super.key, required this.prodId});

  @override
  State<TryyOn> createState() => _TryyOnState();
}

class _TryyOnState extends State<TryyOn> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late VoidCallback _showPersBottomSheetCallBack;

  get imagePicker => null;
  void initState() {
    super.initState();
    _showPersBottomSheetCallBack = _showModalSheet;
  }

  final formKey = GlobalKey<FormState>();
  Gender _g = Gender.female;

  _imgFromGallery(BuildContext context, bool isFront, bool isSide) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (isFront && isSide == false) {
        setState(() {
          frontimagee = File(pickedFile.path);
          Fluttertoast.showToast(
            msg: "Front Image Uploaded",
          );
        });
      } else if (isFront == false && isSide == true) {
        setState(() {
          sideimagee = File(pickedFile.path);
          Fluttertoast.showToast(
            msg: "Side Image Uploaded",
          );
        });
      } else {
        setState(() {
          backimagee = File(pickedFile.path);
          Fluttertoast.showToast(
            msg: "Back Image Uploaded",
          );
        });
      }
    }
  }

  _takePictureFromCamera(bool isFront, bool isSide) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
      source: ImageSource.camera,
      preferredCameraDevice: isFront ? CameraDevice.front : CameraDevice.rear,
    );
    // if (pickedFile != null) {
    //   CroppedFile? croppedFile = await ImageCropper().cropImage(
    //     sourcePath: pickedFile.path,
    //     aspectRatioPresets: [
    //       CropAspectRatioPreset.square,
    //       CropAspectRatioPreset.ratio3x2,
    //       CropAspectRatioPreset.original,
    //       CropAspectRatioPreset.ratio4x3,
    //       CropAspectRatioPreset.ratio16x9
    //     ],
    //     uiSettings: [
    //       AndroidUiSettings(
    //           toolbarTitle: 'Cropper',
    //           toolbarColor: Colors.deepOrange,
    //           toolbarWidgetColor: Colors.white,
    //           initAspectRatio: CropAspectRatioPreset.original,
    //           lockAspectRatio: false),
    //     ],
    //   );
    if (pickedFile != null) {
      if (isFront && isSide == false) {
        setState(() {
          frontimagee = File(pickedFile.path);
          Fluttertoast.showToast(
            msg: "Front Image Uploaded",
          );
        });
      } else if (isFront == false && isSide == true) {
        setState(() {
          sideimagee = File(pickedFile.path);
          Fluttertoast.showToast(
            msg: "Side Image Uploaded",
          );
        });
      } else {
        setState(() {
          backimagee = File(pickedFile.path);
          Fluttertoast.showToast(
            msg: "Back Image Uploaded",
          );
        });
      }
    }
    //}
  }

  void _showModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            color: Colors.tealAccent,
            child: Center(
              child: Column(
                children: [
                  Text(
                    "Height",
                    style: TextStyle(
                        color: mintColors,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  ImageTextInp(
                      controller: _heightController,
                      icon: 'heightt.jpg',
                      hint: "height in cm",
                      torf: false,
                      errormssg: herrormessage,
                      regexp: mregexp,
                      enable: true),
                  ButtonWidget(
                    btnText: "Generate Model",
                    onClick: () {
                      final addHandW = FirebaseFirestore.instance
                          .collection('users')
                          .doc()
                          .update({
                        'height': _heightController.text,
                        'weight': _weightController.text,
                      }).then((value) => null);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  bool doesImageExist = false;
  String userid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () async {
          if (FirebaseAuth.instance.currentUser != null) {
            try {
              await rootBundle.load('assets/body_$userid.obj');
              doesImageExist = true;
            } catch (_) {}

            if (doesImageExist) {
              Fluttertoast.showToast(
                msg: "Model Already Exists",
              );
              DialogggBuilder(context)
                  .showAlert("Start", _g.name, widget.prodId);
            } else {
              setState(() {
                showModalBottomSheet(
                    context: context,
                    builder: (builder) {
                      return Container(
                        color: GreyLightColors,
                        child: ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          UploadBodyImages(
                                              textt: "Upload Front Image",
                                              onPressedG: () async {
                                                // setState(() async {
                                                //   frontimage =
                                                //       await uploadImagee('frontName');
                                                //   print(frontimage);
                                                // });
                                                await _imgFromGallery(
                                                    context, true, false);
                                              },
                                              onPressedC: () {
                                                _takePictureFromCamera(
                                                    true, false);
                                              },
                                              imagepath: frontimage),
                                          UploadBodyImages(
                                              textt: "Upload Side Image",
                                              onPressedG: () async {
                                                // setState(() async {
                                                //   sideimage =
                                                //       await uploadImagee('sideName');
                                                //   print(sideimage);
                                                // });
                                                await _imgFromGallery(
                                                    context, false, true);
                                              },
                                              onPressedC: () {
                                                _takePictureFromCamera(
                                                    false, true);
                                              },
                                              imagepath: sideimage),
                                          UploadBodyImages(
                                              textt: "Upload Back Image",
                                              onPressedG: () async {
                                                // setState(() async {
                                                //   backimage =
                                                //       await uploadImagee('backName');
                                                //   print(backimage);
                                                // });
                                                await _imgFromGallery(
                                                    context, false, false);
                                              },
                                              onPressedC: () {
                                                _takePictureFromCamera(
                                                    false, false);
                                              },
                                              imagepath: backimage),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Column(
                                        children: <Widget>[
                                          ListTile(
                                            title: const Text('Female'),
                                            leading: Radio(
                                              value: Gender.female,
                                              groupValue: _g,
                                              onChanged: (value) {
                                                setState(() {
                                                  _g = value!;
                                                });
                                              },
                                            ),
                                          ),
                                          ListTile(
                                            title: const Text('Male'),
                                            leading: Radio(
                                              value: Gender.male,
                                              groupValue: _g,
                                              onChanged: (value) {
                                                setState(() {
                                                  _g = value!;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "Height",
                                        style: TextStyle(
                                            color: mintColors,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      ImageTextInp(
                                          controller: _heightController,
                                          icon: 'assets/heightt.jpg',
                                          hint: "height in cm",
                                          torf: false,
                                          errormssg: herrormessage,
                                          regexp: mregexp,
                                          enable: true),
                                      const SizedBox(
                                        height: 20,
                                        width: 20,
                                      ),
                                      ButtonWidget(
                                        btnText: "Generate Model",
                                        onClick: () async {
                                          if (frontimagee != null &&
                                              sideimagee != null &&
                                              backimagee != null &&
                                              formKey.currentState!
                                                  .validate()) {
                                            DialogBuilder(context)
                                                .showLoadingIndicator(
                                                    'Loading');
                                            Api_3DService measurementService =
                                                Api_3DService();
                                            Measurements measurements;
                                            measurements =
                                                await measurementService
                                                    .getmeasurements(
                                              FirebaseAuth
                                                  .instance.currentUser!.uid,
                                              double.parse(
                                                  _heightController.text),
                                              frontimagee!,
                                              sideimagee!,
                                              backimagee!,
                                            );
                                            measurements.height = double.parse(
                                                _heightController.text);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        bodyMeasurments(
                                                          measurements:
                                                              measurements,
                                                          height:
                                                              _heightController
                                                                  .text,
                                                          gender: _g.name,
                                                          prodId: widget.prodId,
                                                        )));
                                            final addHandW = FirebaseFirestore
                                                .instance
                                                .collection('users')
                                                .doc(userid)
                                                .update({
                                              'height': double.parse(
                                                  _heightController.text),
                                              'gender': _g.name,
                                            }).then((value) => null);
                                            print(measurements);
                                          } else if (frontimagee == null) {
                                            DialoggBuilder(context).showAlert(
                                                'Please Upload front image ');
                                          } else if (sideimagee == null) {
                                            DialoggBuilder(context).showAlert(
                                                'Please Upload side image ');
                                          } else if (backimagee == null) {
                                            DialoggBuilder(context).showAlert(
                                                'Please Upload bcak image ');
                                          } else {
                                            DialoggBuilder(context)
                                                .showAlert('An Error Occured');
                                          }
                                        },
                                      ),
                                      Text(
                                        "Don't worry your images will not be saved",
                                        style: TextStyle(
                                            color: mintColors,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              });
            }
          } else {
            DialoggBuilder(context).showAlert('Please Login First');
          }
        }, // Image tapped
        splashColor: Colors.white10, // Splash color over image
        child: Ink.image(
          fit: BoxFit.cover, // Fixes border issues
          width: 50,
          height: 50,
          image: const AssetImage(
            'assets/hangerr.png',
          ),
        ),
      ),
    );
  }
}
