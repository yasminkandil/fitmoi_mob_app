import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fitmoi_mob_app/models/user_model.dart';
import 'package:fitmoi_mob_app/utils/color.dart';
import 'package:fitmoi_mob_app/widgets/reg_textinput.dart';
import 'package:path/path.dart' as p;
import '../widgets/alert.dart';
import '../widgets/app_bar.dart';
import '../widgets/btn_widget.dart';

class ViewAccountPage extends StatefulWidget {
  const ViewAccountPage({super.key});

  @override
  State<ViewAccountPage> createState() => _ViewAccountPageState();
}

final formKey = GlobalKey<FormState>();
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
TextEditingController _emailController = TextEditingController();

final user = FirebaseAuth.instance.currentUser!;
String userId = user.uid;
Future updateUserDetails(String firstname, String lastname, String useraddress,
    String userPhoneNumber) async {
  try {
    final updateUser =
        FirebaseFirestore.instance.collection('users').doc(userId);
    updateUser.update(
      {
        'firstname': firstname.trim(),
        'lastname': lastname.trim(),
        'mobile': userPhoneNumber.trim(),
        'address': useraddress.trim(),
      },
    );

    print('USER UPDATED');
  } catch (e) {
    return e.toString();
  }
}

class _ViewAccountPageState extends State<ViewAccountPage> {
  @override
  Widget build(BuildContext context) {
    final userr = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(text: "View Account"),
      body: Form(
        key: formKey,
        child: Container(
          child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .where('email', isEqualTo: userr.email)
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var data = snapshot.data!.docs[index];
                            TextEditingController _fisrtController =
                                TextEditingController(text: data['firstname']);
                            TextEditingController _lastController =
                                TextEditingController(text: data['lastname']);
                            TextEditingController _mobileController =
                                TextEditingController(text: data['mobile']);
                            TextEditingController _addrController =
                                TextEditingController(text: data['address']);
                            greyimage = data['image'];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Center(
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: 110,
                                        height: 110,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 4, color: Colors.white),
                                            boxShadow: [
                                              BoxShadow(
                                                  spreadRadius: 2,
                                                  blurRadius: 10,
                                                  color: Colors.black
                                                      .withOpacity(0.1))
                                            ],
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image:
                                                    NetworkImage(greyimage))),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Container(
                                            height: 40,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  width: 4,
                                                  color: Colors.white,
                                                ),
                                                color: mintColors),
                                            child: TextButton(
                                              child: const Icon(
                                                Icons.edit,
                                                color: Colors.white,
                                              ),
                                              onPressed: () async {
                                                final _storage =
                                                    FirebaseStorage.instance;
                                                final _picker = ImagePicker();
                                                PickedFile? image;

                                                //Check Permissions
                                                await Permission.photos
                                                    .request();

                                                var permissionStatus =
                                                    await Permission
                                                        .photos.status;

                                                //Select Image
                                                image = await _picker.getImage(
                                                    source:
                                                        ImageSource.gallery);
                                                var file = File(image!.path);

                                                if (image != null) {
                                                  //Upload to Firebase
                                                  var snapshot = await _storage
                                                      .ref()
                                                      .child(p
                                                          .basename(image.path))
                                                      .putFile(file);

                                                  downloadUrl = await snapshot
                                                      .ref
                                                      .getDownloadURL();

                                                  setState(
                                                    () {
                                                      imageUrl = downloadUrl;
                                                      greyimage = imageUrl;
                                                      setImage(imageUrl);
                                                      FirebaseFirestore.instance
                                                          .collection('users')
                                                          .doc(userId)
                                                          .update(
                                                        {
                                                          'image': greyimage,
                                                        },
                                                      );
                                                    },
                                                  );
                                                } else {
                                                  print('No Path Received');
                                                }
                                              },
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                // -- IMAGE with ICON
                                const SizedBox(height: 50),
                                Form(
                                  child: Column(children: [
                                    Text(
                                      "First Name:",
                                      style: TextStyle(
                                          color: mintColors,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    RegTextInput(
                                      controller: _fisrtController,
                                      hint: '${data['firstname']}',
                                      icon: Icons.person,
                                      torf: false,
                                      errormssg: fnameerrormssg,
                                      regexp: aregexp,
                                      enable: true,
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      "Last Name:",
                                      style: TextStyle(
                                          color: mintColors,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    RegTextInput(
                                      controller: _lastController,
                                      hint: '${data['lastname']}',
                                      icon: Icons.person,
                                      torf: false,
                                      errormssg: lnameerrormssg,
                                      regexp: aregexp,
                                      enable: true,
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      "Email:",
                                      style: TextStyle(
                                          color: mintColors,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    RegTextInput(
                                      controller: _emailController,
                                      hint: '${data['email']}',
                                      icon: Icons.email,
                                      torf: false,
                                      errormssg: emailerrormssg,
                                      regexp: eregexp,
                                      enable: false,
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      "Address:",
                                      style: TextStyle(
                                          color: mintColors,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    RegTextInput(
                                      controller: _addrController,
                                      hint: '${data['address']}',
                                      icon: Icons.location_city,
                                      torf: false,
                                      errormssg: addrerrormssg,
                                      regexp: aregexp,
                                      enable: true,
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      "Mobile:",
                                      style: TextStyle(
                                          color: mintColors,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    RegTextInput(
                                      controller: _mobileController,
                                      hint: '${data['mobile']}',
                                      icon: Icons.call,
                                      torf: false,
                                      errormssg: mobileerrormssg,
                                      regexp: mregexp,
                                      enable: true,
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    ListTile(
                                      title: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: ButtonWidget2(
                                              btnText: "Edit Account",
                                              onClick: () {
                                                updateUserDetails(
                                                  _fisrtController.text,
                                                  _lastController.text,
                                                  _addrController.text,
                                                  _mobileController.text,
                                                ).then(
                                                  (value) {
                                                    print("updated account");
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            'Account updated..');

                                                    Navigator.pushNamed(
                                                        context, 'homepage');
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                          Expanded(
                                            child: ButtonWidgetdelete(
                                              btnText: "Delete Account",
                                              onClick: () {
                                                final deleteprod =
                                                    FirebaseFirestore
                                                        .instance
                                                        .collection('users')
                                                        .doc(userId)
                                                        .delete()
                                                        .then((value) =>
                                                            Navigator.pop(
                                                                context));
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                                ),
                              ],
                            );
                          });
                    } else if (snapshot.hasError) {
                      return showAlertDialog(context, "Sorry an error occured");
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  })),
        ),
      ),
    );
  }
}
