import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fitmoi_mob_app/widgets/app_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import "package:path/path.dart" as p;
import '../utils/color.dart';
import '../widgets/btn_widget.dart';
import '../widgets/upload_images.dart';

class AddTexturePage extends StatefulWidget {
  const AddTexturePage({super.key, required this.prodid});
  final String prodid;

  @override
  _AddTexturePageState createState() => _AddTexturePageState();
}

var imageUrl;
var downloadUrl;
var imagee;
var greyimage =
    'https://media.tarkett-image.com/large/TH_24567080_24594080_24596080_24601080_24563080_24565080_24588080_001.jpg';

var greyimage2 =
    'https://media.tarkett-image.com/large/TH_24567080_24594080_24596080_24601080_24563080_24565080_24588080_001.jpg';
late String Cvalue;
var imageUrl2;
var downloadUrl2;
var imagee2;

setImage(String imagee) {
  imagee = imagee;
}

getImage() {
  return imagee;
}

setImage2(String imagee2) {
  imagee2 = imagee2;
}

getImage2() {
  return imagee2;
}

class _AddTexturePageState extends State<AddTexturePage> {
  final _newPController = TextEditingController();
  String mregexp = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]+$';

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

      var downloadUrl = await snapshot.ref.getDownloadURL();

      setState(() {
        imageUrl = downloadUrl;
        greyimage = imageUrl;
        setImage(imageUrl);
        getImage();
      });
    } else {
      Fluttertoast.showToast(msg: 'Grant Permissions and try again');
      return null;
    }
  }

  uploadImage2() async {
    final _storage2 = FirebaseStorage.instance;
    final _picker2 = ImagePicker();
    PickedFile? image2;

    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    //Select Image
    image2 = await _picker2.getImage(source: ImageSource.gallery);
    var file = File(image2!.path);

    if (image2 != null) {
      //Upload to Firebase
      var snapshot =
          await _storage2.ref().child(p.basename(image2.path)).putFile(file);

      var downloadUrl2 = await snapshot.ref.getDownloadURL();

      setState(() {
        imageUrl2 = downloadUrl2;
        greyimage2 = imageUrl2;
        setImage2(imageUrl2);
        getImage2();
      });
    } else {
      print('No Path Received');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "Add Texture"),
      body: Container(
        padding: EdgeInsets.only(bottom: 5),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  UploadBodyImages(
                      textt: "Front image",
                      onPressed: () async {
                        uploadImage();
                      },
                      imagepath: greyimage),
                  UploadBodyImages(
                      textt: "Back image",
                      onPressed: () async {
                        uploadImage2();
                      },
                      imagepath: greyimage2),
                ],
              ),
            ),
            ButtonWidget(
                btnText: "Add Textures",
                onClick: () {
                  final update = FirebaseFirestore.instance
                      .collection('product')
                      .doc(widget.prodid)
                      .update(
                    {
                      'front': greyimage,
                      'back': greyimage2,
                    },
                  ).then((value) {
                    Fluttertoast.showToast(
                      msg: "Textures addedd...",
                    );
                    Navigator.pop(context);
                  });
                }),
          ],
        ),
      ),
    );
  }
}
