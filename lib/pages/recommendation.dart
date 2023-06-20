import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitmoi_mob_app/pages/recc_results.dart';
import 'package:fitmoi_mob_app/pages/view_account.dart';
import 'package:fitmoi_mob_app/utils/color.dart';
import 'package:fitmoi_mob_app/widgets/app_bar.dart';
import 'package:fitmoi_mob_app/widgets/btn_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as p;

import '../models/recModel.dart';

class RecommPage extends StatefulWidget {
  RecommPage({Key? key}) : super(key: key);

  @override
  _RecommPageState createState() => _RecommPageState();
}

class _RecommPageState extends State<RecommPage> {
  String? _selectedShirtType;
  File? _selectedShirtImage;
  String? _selectedAccessoryType;
  File? _selectedAccessoryImage;
  String? _selectedPantsType;
  File? _selectedPantsImage;
  String? _selectedShoeType;
  File? _selectedShoeImage;
  String? _selectedBagType;
  File? _selectedBagImage;

  late String downloadUrl;

  late String imageUrl;

  String TopImage =
      'https://www.nicepng.com/png/detail/399-3992743_shirt-icon.png';
  String BottomImage =
      'https://cdn1.vectorstock.com/i/1000x1000/52/80/pants-icon-flat-vector-12005280.jpg';
  String ShoeImage =
      'https://i.pinimg.com/736x/dc/53/50/dc5350243970437d9fff2c8db3a9975b--running-shoes-sermon-series.jpg';
  String BagImage =
      'https://www.shutterstock.com/image-vector/ladies-bag-symbol-icon-vector-600w-1440520124.jpg';
  String AccessoryImage =
      'https://static.thenounproject.com/png/3059446-200.png';

  var Message;

  Future predictOutfit(
      File top, File bottom, File shoe, File bag, File accessory) async {
    List<int> topBytes = await File(top.path).readAsBytes();
    String topBase64Encode = base64.encode(topBytes);
    List<int> bottomimageBytes = await File(bottom.path).readAsBytes();
    String bottombase64Encode = base64.encode(bottomimageBytes);
    List<int> shoeimageBytes = await File(shoe.path).readAsBytes();
    String shoebase64Encode = base64.encode(shoeimageBytes);
    List<int> bagImageBytes = await File(bag.path).readAsBytes();
    String bagBase64Encode = base64.encode(bagImageBytes);
    List<int> accessoryimageBytes = await File(accessory.path).readAsBytes();
    String accessorybase64Encode = base64.encode(accessoryimageBytes);
    final url = Uri.parse('http://192.168.1.108:8050/predict');

    final headers = {'Content-Type': 'application/json'};

    final body = jsonEncode({
      'try_most': true,
      'top_img': "${topBase64Encode}",
      'bottom_img': "${bottombase64Encode}",
      'shoe_img': "${shoebase64Encode}",
      'bag_img': "${bagBase64Encode}",
      'accessory_img': "${accessorybase64Encode}",
    });

    final response = await http.post(url, headers: headers, body: body);
    var jsonResponse2 = jsonDecode(response.body);
    //print(jsonResponse2);
    var predic = RecPredict(
      imgOutputs: jsonResponse2['img_outputs'],
      revisedScore: jsonResponse2['revised_score'],
      origScore: jsonResponse2['original_score'],
      message: jsonResponse2['message'],
    );
    var imageOutputs = jsonResponse2['img_outputs'];
    var score = jsonResponse2['revised_score'];
    var original = jsonResponse2['original_score'];
    var mssg = jsonResponse2['message'];
    print(mssg);
    print(score);
    print(original);
    print(imageOutputs);
    if (response.statusCode == 200) {
      return predic;
    }
    return null;
  }

  PickedFile? toppimage;
  PickedFile? bottommimage;
  PickedFile? shoeeimage;
  PickedFile? baggimage;
  PickedFile? accessoryyimage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "Recommendation"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Dropdown list for T-shirts
            Row(
              children: [
                Text(
                  'Upload Top',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: mintColors),
                ),
                IconButton(
                  onPressed: () async {
                    //  uploadImage(true, false, false, false, false),
                    // setState(() async {
                    //   TopImage = await _uploadImagee('top$userId');
                    // });
                    final _storage = FirebaseStorage.instance;
                    final _picker = ImagePicker();

                    //Check Permissions
                    await Permission.photos.request();

                    var permissionStatus = await Permission.photos.status;

                    //Select Image
                    toppimage =
                        await _picker.getImage(source: ImageSource.gallery);
                    _selectedShirtImage = File(toppimage!.path);

                    if (toppimage != null) {
                      //Upload to Firebase
                      var snapshot = await _storage
                          .ref()
                          .child('top$userId')
                          .putFile(_selectedShirtImage!);

                      downloadUrl = await snapshot.ref.getDownloadURL();

                      setState(
                        () {
                          imageUrl = downloadUrl;
                          TopImage = imageUrl;
                        },
                      );
                    } else {
                      print('No Path Received');
                    }
                  },
                  icon: const Icon(Icons.upload_file),
                ),
              ],
            ),

            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Upload Bottom',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: mintColors),
                ),
                IconButton(
                  onPressed: () async {
                    //  uploadImage(true, false, false, false, false),
                    // setState(() async {
                    //   BottomImage = await _uploadImagee('bottom$userId');
                    // });
                    final _storage = FirebaseStorage.instance;
                    final _picker = ImagePicker();

                    //Check Permissions
                    await Permission.photos.request();

                    var permissionStatus = await Permission.photos.status;

                    //Select Image
                    bottommimage =
                        await _picker.getImage(source: ImageSource.gallery);
                    _selectedPantsImage = File(bottommimage!.path);

                    if (bottommimage != null) {
                      //Upload to Firebase
                      var snapshot = await _storage
                          .ref()
                          .child('bottom$userId')
                          .putFile(_selectedPantsImage!);

                      downloadUrl = await snapshot.ref.getDownloadURL();

                      setState(
                        () {
                          imageUrl = downloadUrl;
                          BottomImage = imageUrl;
                        },
                      );
                    } else {
                      print('No Path Received');
                    }
                  },
                  icon: const Icon(Icons.upload_file),
                ),
              ],
            ),

            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Upload Shoe',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: mintColors),
                ),
                IconButton(
                  onPressed: () async {
                    //  uploadImage(true, false, false, false, false),
                    // setState(() async {
                    //   ShoeImage = await _uploadImagee('shoe$userId');
                    // });
                    final _storage = FirebaseStorage.instance;
                    final _picker = ImagePicker();

                    //Check Permissions
                    await Permission.photos.request();

                    var permissionStatus = await Permission.photos.status;

                    //Select Image
                    shoeeimage =
                        await _picker.getImage(source: ImageSource.gallery);
                    _selectedShoeImage = File(shoeeimage!.path);

                    if (shoeeimage != null) {
                      //Upload to Firebase
                      var snapshot = await _storage
                          .ref()
                          .child('shoe$userId')
                          .putFile(_selectedShoeImage!);

                      downloadUrl = await snapshot.ref.getDownloadURL();

                      setState(
                        () {
                          imageUrl = downloadUrl;
                          ShoeImage = imageUrl;
                        },
                      );
                    } else {
                      print('No Path Received');
                    }
                  },
                  icon: const Icon(Icons.upload_file),
                ),
              ],
            ),

            // Image upload button for Accessories

            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Upload Bag',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: mintColors),
                ),
                IconButton(
                  onPressed: () async {
                    // setState(() async {
                    //   BagImage = await _uploadImagee('bag$userId');
                    // });
                    final _storage = FirebaseStorage.instance;
                    final _picker = ImagePicker();

                    //Check Permissions
                    await Permission.photos.request();

                    var permissionStatus = await Permission.photos.status;

                    //Select Image
                    baggimage =
                        await _picker.getImage(source: ImageSource.gallery);
                    _selectedBagImage = File(baggimage!.path);

                    if (baggimage != null) {
                      //Upload to Firebase
                      var snapshot = await _storage
                          .ref()
                          .child('bag$userId')
                          .putFile(_selectedBagImage!);

                      downloadUrl = await snapshot.ref.getDownloadURL();

                      setState(
                        () {
                          imageUrl = downloadUrl;
                          BagImage = imageUrl;
                        },
                      );
                    } else {
                      print('No Path Received');
                    }
                  },
                  icon: Icon(Icons.upload_file),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Upload Accessories',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: mintColors),
                ),
                IconButton(
                  onPressed: () async {
                    //  uploadImage(true, false, false, false, false),

                    // setState(() async {
                    //   AccessoryImage = await _uploadImagee('accessory$userId');
                    // });
                    final _storage = FirebaseStorage.instance;
                    final _picker = ImagePicker();

                    //Check Permissions
                    await Permission.photos.request();

                    var permissionStatus = await Permission.photos.status;

                    //Select Image
                    accessoryyimage =
                        await _picker.getImage(source: ImageSource.gallery);
                    _selectedAccessoryImage = File(accessoryyimage!.path);

                    if (toppimage != null) {
                      //Upload to Firebase
                      var snapshot = await _storage
                          .ref()
                          .child('accessory$userId')
                          .putFile(_selectedAccessoryImage!);

                      downloadUrl = await snapshot.ref.getDownloadURL();

                      setState(
                        () {
                          imageUrl = downloadUrl;
                          AccessoryImage = imageUrl;
                        },
                      );
                    } else {
                      print('No Path Received');
                    }
                  },
                  icon: const Icon(Icons.upload_file),
                ),
              ],
            ),
            Text(
              'Picked Outfit',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: mintColors),
            ),

            SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Image(
                        image: NetworkImage(TopImage),
                        width: 100,
                        height: 100,
                      ),
                    ),
                    Expanded(
                      child: Image.network(
                        BottomImage,
                        width: 100,
                        height: 100,
                      ),
                    ),
                    Expanded(
                      child: Image.network(
                        ShoeImage,
                        width: 100,
                        height: 100,
                      ),
                    ),
                    Expanded(
                      child: Image.network(
                        BagImage,
                        width: 100,
                        height: 100,
                      ),
                    ),
                    Expanded(
                      child: Image.network(
                        AccessoryImage,
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ButtonWidget(
              btnText: "Submit",
              onClick: () async {
                Fluttertoast.showToast(msg: "Please wait...");
                RecPredict predd = await predictOutfit(
                    _selectedShirtImage!,
                    _selectedPantsImage!,
                    _selectedShoeImage!,
                    _selectedBagImage!,
                    _selectedAccessoryImage!);
                //Message = predd.message ?? '';
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RecResult(resultss: predd)));
              },
            ),
            SizedBox(
              height: 20,
            ),
          ]),
        ),
      ),
    );
  }
}
