import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitmoi_mob_app/models/user_model.dart';
import 'package:fitmoi_mob_app/services/testTex.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fitmoi_mob_app/widgets/app_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import "package:path/path.dart" as p;
import '../utils/color.dart';
import '../widgets/btn_widget.dart';
import '../widgets/upload_images.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

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
var imageUrlT;
var downloadUrlT;
var imageeT;
var greyimageT =
    'https://media.tarkett-image.com/large/TH_24567080_24594080_24596080_24601080_24563080_24565080_24588080_001.jpg';

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

setImageT(String imageeT) {
  imageeT = imageeT;
}

getImageT() {
  return imageeT;
}

class _AddTexturePageState extends State<AddTexturePage> {
  final _newPController = TextEditingController();
  String mregexp = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]+$';
  var texture;

  File? _frontimage = null;
  File? _backimage = null;
  _uploadTexToStorage(texture) async {
    final _storage = FirebaseStorage.instance;
    var snapshot =
        await _storage.ref().child(p.basename(texture.path)).putFile(texture);

    var downloadUrlT = await snapshot.ref.getDownloadURL();

    setState(() {
      imageUrlT = downloadUrlT;
      greyimageT = imageUrlT;
      setImageT(imageUrlT);
      getImageT();
    });
  }

  _imgFromGallery(BuildContext context, bool isFront) async {
    final _storage = FirebaseStorage.instance;
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (isFront) {
        setState(() {
          _frontimage = File(pickedFile.path);
          Fluttertoast.showToast(
            msg: "Front Image Uploaded",
          );
        });

        //Upload to Firebase

        var snapshot = await _storage
            .ref()
            .child(p.basename(_frontimage!.path))
            .putFile(_frontimage!);

        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          imageUrl = downloadUrl;
          greyimage = imageUrl;
          setImage(imageUrl);
          getImage();
        });
      }
    } else {
      setState(() {
        _backimage = File(pickedFile!.path);
        Fluttertoast.showToast(
          msg: "Back Image Uploaded",
        );
      });
      var snapshot = await _storage
          .ref()
          .child(p.basename(_backimage!.path))
          .putFile(_backimage!);

      var downloadUrl2 = await snapshot.ref.getDownloadURL();
      setState(() {
        imageUrl2 = downloadUrl2;
        greyimage2 = imageUrl2;
        setImage2(imageUrl2);
        getImage2();
      });
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
                        await _imgFromGallery(context, true);
                        //uploadImage();
                      },
                      imagepath: greyimage),
                  UploadBodyImages(
                      textt: "Back image",
                      onPressed: () async {
                        await _imgFromGallery(context, false);
                      },
                      imagepath: greyimage2),
                ],
              ),
            ),
            ButtonWidget(
                btnText: "Add Textures",
                onClick: () async {
                  //sendImageToAPI(greyimage);
                  texture = await sendRequest(
                      id: '0',
                      frontImage: _frontimage!,
                      backImage: _backimage!,
                      clothType: "shirt");
                  final update = FirebaseFirestore.instance
                      .collection('product')
                      .doc(widget.prodid)
                      .update(
                    {
                      'front': greyimage,
                      'back': greyimage2,
                      'texture': greyimageT,
                    },
                  ).then((value) {
                    Fluttertoast.showToast(
                      msg: "Textures addedd...",
                    );
                    Navigator.pop(context);
                  });
                  // uploadImagesToDirectory();
                }),
            SizedBox(
              height: 200,
              width: 200,
              child: Image.network(greyimageT),
            )
          ],
        ),
      ),
    );
  }
}
