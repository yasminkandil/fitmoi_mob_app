import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitmoi_mob_app/pages/view_account.dart';
import 'package:fitmoi_mob_app/widgets/passwordfield.dart';
import 'package:fitmoi_mob_app/widgets/uploadFunc.dart';
import 'package:fitmoi_mob_app/widgets/upload_images.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fitmoi_mob_app/models/user_model.dart';
import 'package:fitmoi_mob_app/utils/color.dart';
import 'package:fitmoi_mob_app/widgets/btn_widget.dart';
import 'package:fitmoi_mob_app/widgets/header_container.dart';
import 'package:path/path.dart' as p;
import 'package:fitmoi_mob_app/widgets/reg_textinput.dart';

import '../widgets/alert.dart';
import '../widgets/app_bar.dart';
import '../widgets/upload_profilepic.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

Gender _g = Gender.female;

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child("users");
  }

  uploadImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile? image;

    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    //Select Image
    image = await _picker.getImage(source: ImageSource.gallery);
    var file = File(image!.path);

    if (image != null) {
      //Upload to Firebase
      var snapshot =
          await _storage.ref().child(p.basename(image.path)).putFile(file);

      downloadUrl = await snapshot.ref.getDownloadURL();

      setState(() {
        imageUrl = downloadUrl;
        greyimage = imageUrl;
        setImage(imageUrl);
      });
    } else {
      print('No Path Received');
    }
  }

  var sideee;

  /*@override
  void dispose() {
    // * TextEditingControllers should be always disposed
    emailController.dispose();
    passwordController.dispose();
    fisrtController.dispose();
    mobileController.dispose();
    addrController.dispose();
    lastController.dispose();
    confirmPassController.dispose();

    super.dispose();
  }*/
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: ""),
      body: Container(
        padding: EdgeInsets.only(bottom: 20),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              HeaderContainer("Register"),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: IntrinsicHeight(
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Column(
                            children: [
                              Text(
                                "Upload Profile Image:",
                                style: TextStyle(
                                    color: mintColors,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              UploadImages(
                                  textt: "Upload Profile Image",
                                  function: () async {
                                    //sideee =
                                    //print(sideee);
                                    setState(() async {
                                      greyimage =
                                          await uploadImagee('imageName');
                                      print(greyimage);
                                    });
                                  },
                                  imagepath: greyimage),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              UploadBodyImages(
                                  textt: "Upload Back Image",
                                  onPressed: () async {
                                    setState(() async {
                                      backimage =
                                          await uploadImagee('backName');
                                      print(backimage);
                                    });
                                  },
                                  imagepath: backimage),
                              UploadBodyImages(
                                  textt: "Upload Side Image",
                                  onPressed: () async {
                                    setState(() async {
                                      sideimage =
                                          await uploadImagee('sideName');
                                      print(sideimage);
                                    });
                                  },
                                  imagepath: sideimage),
                              UploadBodyImages(
                                  textt: "Upload Front Image",
                                  onPressed: () async {
                                    setState(() async {
                                      frontimage =
                                          await uploadImagee('frontName');
                                      print(frontimage);
                                    });
                                  },
                                  imagepath: frontimage),
                            ],
                          ),
                          RegTextInput(
                            controller: fisrtController,
                            hint: "First Name",
                            icon: Icons.person,
                            torf: false,
                            errormssg: fnameerrormssg,
                            regexp: aregexp,
                            enable: true,
                          ),
                          RegTextInput(
                            controller: lastController,
                            hint: "Last Name",
                            icon: Icons.person,
                            torf: false,
                            errormssg: lnameerrormssg,
                            regexp: aregexp,
                            enable: true,
                          ),
                          RegTextInput(
                            controller: emailController,
                            hint: "Email",
                            icon: Icons.email,
                            torf: false,
                            errormssg: emailerrormssg,
                            regexp: eregexp,
                            enable: true,
                          ),
                          RegTextInput(
                            controller: mobileController,
                            hint: "Phone Number",
                            icon: Icons.call,
                            torf: false,
                            errormssg: mobileerrormssg,
                            regexp: mregexp,
                            enable: true,
                          ),
                          RegTextInput(
                            controller: addrController,
                            hint: "Address",
                            icon: Icons.location_city,
                            torf: false,
                            errormssg: addrerrormssg,
                            regexp: aregexp,
                            enable: true,
                          ),
                          PasswordField(
                              hintText: "Password",
                              obscureText: _obscureText,
                              Controller: passwordController,
                              perrormssg:
                                  "Password must not be less than 6 characters"),
                          PasswordField(
                              hintText: "Confirm Password",
                              obscureText: _obscureText,
                              Controller: confirmPassController,
                              perrormssg:
                                  "Password and Confirm password don't match"),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Gender:",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: mintColors,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
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
                          Expanded(
                            child: Center(
                              child: ButtonWidget(
                                btnText: "REGISTER",
                                onClick: () async {
                                  try {
                                    if (formKey.currentState!.validate()) {
                                      await FirebaseAuth.instance
                                          .createUserWithEmailAndPassword(
                                              email: emailController.text,
                                              password:
                                                  passwordController.text);

                                      String email =
                                          emailController.text.trim();
                                      final userr = await FirebaseAuth.instance
                                          .fetchSignInMethodsForEmail(email);
                                      addUserDetails(
                                        fisrtController.text,
                                        lastController.text,
                                        emailController.text,
                                        addrController.text,
                                        mobileController.text,
                                        sideimage,
                                        frontimage,
                                        backimage,
                                        greyimage,
                                        _g.name,
                                        userId,
                                      ).then((value) {
                                        print("Created new account");
                                        Fluttertoast.showToast(
                                            msg: "Account created...",
                                            backgroundColor: mintColors);
                                        Navigator.pushNamed(
                                            context, 'homepage');
                                      });
                                      //}
                                    }
                                  } catch (e) {
                                    if (e is FirebaseAuthException) {
                                      if (e.code == 'weak-password') {
                                        showAlertDialog(context,
                                            "The password provided is too weak.");
                                      } else if (e.code ==
                                          'email-already-in-use') {
                                        showAlertDialog(context,
                                            "Account already exists for that email.");
                                      }
                                    } else {
                                      print(e);
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                          InkWell(
                            child: RichText(
                              text: TextSpan(children: [
                                const TextSpan(
                                    text: "Already a member ? ",
                                    style: TextStyle(color: Colors.black)),
                                TextSpan(
                                    text: "Login",
                                    style: TextStyle(
                                      color: mintColors,
                                    )),
                              ]),
                            ),
                            onTap: () => Navigator.pushNamed(context, 'login'),
                          )
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
