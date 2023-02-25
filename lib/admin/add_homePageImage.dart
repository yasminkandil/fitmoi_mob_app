import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as p;
import 'package:fitmoi_mob_app/admin/admin.dart';
import 'package:fitmoi_mob_app/utils/color.dart';
import 'package:fitmoi_mob_app/widgets/app_bar.dart';
import 'package:fitmoi_mob_app/widgets/header_container.dart';

class AddGalleryhome extends StatefulWidget {
  const AddGalleryhome({super.key});

  @override
  State<AddGalleryhome> createState() => _AddGalleryhomeState();
}

Future AddGalleryhomeDetails(
  String GImage,
) async {
  await FirebaseFirestore.instance.collection('homePage').doc().set(
    {
      'image': GImage,
    },
  );

  print('NEW IMAGE ADDED');
}

class _AddGalleryhomeState extends State<AddGalleryhome> {
  var imageUrl;
  var downloadUrl;
  var imagee;
  var greyimage =
      'https://www.google.com/search?q=profile+photo+&tbm=isch&ved=2ahUKEwis27rOz_76AhVFexoKHU2PBGoQ2-cCegQIABAA&oq=profile+photo+&gs_lcp=CgNpbWcQAzIECAAQQzIFCAAQgAQyBQgAEIAEMgUIABCABDIFCAAQgAQyBQgAEIAEMgUIABCABDIFCAAQgAQyBQgAEIAEMgUIABCABDoGCAAQBxAeULwEWLwEYKoIaABwAHgAgAGZAYgBkwKSAQMwLjKYAQCgAQGqAQtnd3Mtd2l6LWltZ8ABAQ&sclient=img&ei=d4lZY-zDCsX2ac2ektAG&bih=657&biw=1366#imgrc=nfkyptoYx2OzJM';
  setImage(String imagee) {
    imagee = imagee;
  }

  getImage() {
    return imagee;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "Add HomePage Image"),
      body: Container(
        padding: EdgeInsets.only(bottom: 20),
        child: Column(
          children: <Widget>[
            HeaderContainer("Add Images To HomePage"),
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 160,
                    height: 160,
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
                            fit: BoxFit.cover, image: NetworkImage(greyimage))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Colors.white,
                            ),
                            color: mintColors),
                        child: TextButton(
                          child: const Icon(
                            Icons.upload,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            uploadImage();
                            AddGalleryhomeDetails(greyimage).then((value) {
                              Fluttertoast.showToast(msg: 'Image added');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Admin()),
                              );
                            });
                          },
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
