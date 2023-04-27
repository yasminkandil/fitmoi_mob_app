import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitmoi_mob_app/widgets/upload_images.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fitmoi_mob_app/utils/color.dart';
import 'package:fitmoi_mob_app/widgets/alert.dart';
import "package:path/path.dart" as p;
import '../models/product_model.dart' as pp;
import '../models/product_model.dart';
import '../widgets/app_bar.dart';
import '../widgets/btn_widget.dart';
import '../widgets/reg_textinput.dart';
import 'package:uuid/uuid.dart';

final formKey = GlobalKey<FormState>();
String mregexp = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]+$';

final _uuid = Uuid();

var random = Random();
int randomNumber = random.nextInt(1000);
String _selectedValue = '';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _firestore = FirebaseFirestore.instance;
  List<String> _dropdownValues = [];

  @override
  void initState() {
    super.initState();
    _getDropdownValues();
    fetchSubcategoriesF();
    fetchSubcategoriesM();
  }

  void _getDropdownValues() async {
    final snapshot = await _firestore.collection("category").get();
    setState(() {
      _dropdownValues =
          snapshot.docs.map((doc) => doc.data()['name'].toString()).toList();
      _selectedValue = _dropdownValues[0];
    });
  }

  Future<List<dynamic>> getSubcategoriesF() async {
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance
            .collection('category')
            .doc('iIDinMSxd9LMHvl1zlWy')
            .get();
    final data = documentSnapshot.data();
    if (data == null) {
      return [];
    } // Return an empty list if the document doesn't exist
    return data['subcategory'] ??
        []; // Return the subcategory array or an empty list if it doesn't exist
  }

  List<dynamic> _subcategoriesF = [];
  dynamic _selectedValuee;
  void fetchSubcategoriesF() async {
    _subcategoriesF = await getSubcategoriesF();
    if (_subcategoriesF.isNotEmpty) {
      setState(() {
        _selectedValuee = _subcategoriesF[0]; // Set the initial selected value
      });
    }
  }

  Future<List<dynamic>> getSubcategoriesM() async {
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance
            .collection('category')
            .doc('ypF4q51E7j7zVBlvFoYx')
            .get();
    final data = documentSnapshot.data();
    if (data == null) {
      return [];
    } // Return an empty list if the document doesn't exist
    return data['subcategory'] ??
        []; // Return the subcategory array or an empty list if it doesn't exist
  }

  List<dynamic> _subcategoriesM = [];
  dynamic _selectedValueeM;
  void fetchSubcategoriesM() async {
    _subcategoriesM = await getSubcategoriesM();
    if (_subcategoriesM.isNotEmpty) {
      setState(() {
        _selectedValueeM = _subcategoriesM[0]; // Set the initial selected value
      });
    }
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

      var downloadUrl = await snapshot.ref.getDownloadURL();

      setState(() {
        pp.imageUrl = downloadUrl;
        pp.greyimage = pp.imageUrl;
        pp.setImage(pp.imageUrl);
        pp.getImage();
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
        pp.imageUrl2 = downloadUrl2;
        pp.greyimage2 = pp.imageUrl2;
        pp.setImage2(pp.imageUrl2);
        pp.getImage2();
      });
    } else {
      print('No Path Received');
    }
  }

  uploadImage3() async {
    final _storage3 = FirebaseStorage.instance;
    final _picker3 = ImagePicker();
    PickedFile? image3;

    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    //Select Image
    image3 = await _picker3.getImage(source: ImageSource.gallery);
    var file = File(image3!.path);

    if (image3 != null) {
      //Upload to Firebase
      var snapshot =
          await _storage3.ref().child(p.basename(image3.path)).putFile(file);

      var downloadUrl3 = await snapshot.ref.getDownloadURL();

      setState(() {
        pp.imageUrl3 = downloadUrl3;
        pp.greyimage3 = pp.imageUrl3;
        pp.setImage3(pp.imageUrl3);
        pp.getImage3();
      });
    } else {
      print('No Path Received');
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget colorr;
    Widget qualityy;
    Widget categoryy;
    return Scaffold(
      appBar: CustomAppBar(text: "Add Product"),
      body: Container(
        padding: EdgeInsets.only(bottom: 5),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  UploadImages(
                      textt: "Main image",
                      onPressed: () async {
                        uploadImage();
                      },
                      imagepath: greyimage),
                  UploadImages(
                      textt: "Second image",
                      onPressed: () async {
                        uploadImage2();
                      },
                      imagepath: greyimage2),
                  UploadImages(
                      textt: "Third image",
                      onPressed: () async {
                        uploadImage3();
                      },
                      imagepath: greyimage3),
                ],
              ),
            ),
            Form(
              key: formKey,
              child: Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: IntrinsicHeight(
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          RegTextInput(
                              controller: pp.nameController,
                              hint: "Product Name",
                              icon: Icons.edit_attributes_outlined,
                              torf: false,
                              errormssg: errormssg,
                              regexp: aregexp,
                              enable: true),
                          RegTextInput(
                              controller: pp.descriptionController,
                              hint: "Description",
                              icon: Icons.edit_attributes_outlined,
                              torf: false,
                              errormssg: errormssg,
                              regexp: aregexp,
                              enable: true),
                          RegTextInput(
                              controller: pp.priceController,
                              hint: "Price",
                              icon: Icons.money,
                              torf: false,
                              errormssg: errormssg,
                              regexp: mregexp,
                              enable: true),
                          RegTextInput(
                              controller: pp.quantityController,
                              hint: "Quantity",
                              icon: Icons.numbers,
                              torf: false,
                              errormssg: errormssg,
                              regexp: mregexp,
                              enable: true),
                          RegTextInput(
                              controller: pp.colorController,
                              hint: "Colors",
                              icon: Icons.color_lens,
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
                                  colorsList.add(pp.colorController.text);
                                  Fluttertoast.showToast(
                                    msg: "Color Added",
                                    // toastLength: Toast.LENGTH_SHORT,
                                    // gravity: ToastGravity.BOTTOM,
                                    // timeInSecForIosWeb: 1,
                                    // backgroundColor:
                                    //     Color.fromARGB(255, 10, 169, 159),
                                    // textColor: Colors.white,
                                    // fontSize: 16.0
                                  );
                                  setColors(colorsList);
                                  // pp.colorController.clear();
                                });
                              },
                              btnText: 'Add Color',
                            ),
                          ),
                          RegTextInput(
                              controller: pp.sizeController,
                              hint: "Size",
                              icon: Icons.photo_size_select_small,
                              torf: false,
                              errormssg: errormssg,
                              regexp: aregexp,
                              enable: true),
                          Expanded(
                            child: ButtonWidget(
                              onClick: () {
                                setState(() {
                                  sizeList.add(pp.sizeController.text);
                                  Fluttertoast.showToast(
                                    msg: "Size Added",
                                    // toastLength: Toast.LENGTH_SHORT,
                                    // gravity: ToastGravity.BOTTOM,
                                    // timeInSecForIosWeb: 1,
                                    // backgroundColor:
                                    //     Color.fromARGB(255, 10, 169, 159),
                                    // textColor: Colors.white,
                                    // fontSize: 16.0
                                  );
                                  setSizes(sizeList);
                                  //pp.sizeController.clear();
                                });
                              },
                              btnText: 'Add Size',
                            ),
                          ),
                          sizeList.contains('small') ||
                                  sizeList.contains("Small")
                              ? RegTextInput(
                                  controller: pp.squantityController,
                                  hint: "Small Quantity",
                                  icon: Icons.numbers,
                                  torf: false,
                                  errormssg: errormssg,
                                  regexp: mregexp,
                                  enable: true)
                              : Container(),
                          sizeList.contains('Medium') ||
                                  sizeList.contains("medium")
                              ? RegTextInput(
                                  controller: pp.mquantityController,
                                  hint: "Medium Quantity",
                                  icon: Icons.numbers,
                                  torf: false,
                                  errormssg: errormssg,
                                  regexp: mregexp,
                                  enable: true)
                              : Container(),
                          sizeList.contains('large') ||
                                  sizeList.contains("Large")
                              ? RegTextInput(
                                  controller: pp.lquantityController,
                                  hint: "Large Quantity",
                                  icon: Icons.numbers,
                                  torf: false,
                                  errormssg: errormssg,
                                  regexp: mregexp,
                                  enable: true)
                              : Container(),
                          sizeList.contains('x-large') ||
                                  sizeList.contains("X-Large") ||
                                  sizeList.contains("X-large")
                              ? RegTextInput(
                                  controller: pp.xlquantityController,
                                  hint: "X-Large Quantity",
                                  icon: Icons.numbers,
                                  torf: false,
                                  errormssg: errormssg,
                                  regexp: mregexp,
                                  enable: true)
                              : Container(),
                          sizeList.contains('xx-large') ||
                                  sizeList.contains("XX-Large") ||
                                  sizeList.contains("XX-large")
                              ? RegTextInput(
                                  controller: pp.xxlquantityController,
                                  hint: "XX-Large Quantity",
                                  icon: Icons.numbers,
                                  torf: false,
                                  errormssg: errormssg,
                                  regexp: mregexp,
                                  enable: true)
                              : Container(),
                          RegTextInput(
                              controller: pp.qualityController,
                              hint: "Quality",
                              icon: Icons.category,
                              torf: false,
                              errormssg: errormssg,
                              regexp: aregexp,
                              enable: true),
                          DropdownButtonFormField(
                            value: _selectedValue,
                            items: _dropdownValues
                                .map((e) => DropdownMenuItem(
                                      child: Text(e),
                                      value: e,
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedValue = value!;
                              });
                            },
                            icon: const Icon(
                              Icons.arrow_drop_down_circle,
                              color: Color.fromARGB(255, 10, 169, 159),
                            ),
                            dropdownColor: Color.fromARGB(255, 10, 169, 159),
                            decoration: const InputDecoration(
                                labelText: "Categories",
                                prefixIcon: Icon(
                                  Icons.category,
                                  color: Color.fromARGB(255, 10, 169, 159),
                                ),
                                border: UnderlineInputBorder()),
                          ),
                          _selectedValue == 'female'
                              ? DropdownButtonFormField(
                                  value: _selectedValuee,
                                  onChanged: (dynamic newValue) {
                                    setState(() {
                                      _selectedValuee = newValue;
                                    });
                                  },
                                  items: _subcategoriesF
                                      .map<DropdownMenuItem<dynamic>>(
                                          (dynamic value) {
                                    return DropdownMenuItem<dynamic>(
                                      value: value,
                                      child: Text(value.toString()),
                                    );
                                  }).toList(),
                                  icon: const Icon(
                                    Icons.arrow_drop_down_circle,
                                    color: Color.fromARGB(255, 10, 169, 159),
                                  ),
                                  dropdownColor:
                                      Color.fromARGB(255, 10, 169, 159),
                                  decoration: const InputDecoration(
                                      labelText: "SubCategory",
                                      prefixIcon: Icon(
                                        Icons.category,
                                        color:
                                            Color.fromARGB(255, 10, 169, 159),
                                      ),
                                      border: UnderlineInputBorder()),
                                )
                              : DropdownButtonFormField(
                                  value: _selectedValueeM,
                                  onChanged: (dynamic newValue) {
                                    setState(() {
                                      _selectedValueeM = newValue;
                                    });
                                  },
                                  items: _subcategoriesM
                                      .map<DropdownMenuItem<dynamic>>(
                                          (dynamic value) {
                                    return DropdownMenuItem<dynamic>(
                                      value: value,
                                      child: Text(value.toString()),
                                    );
                                  }).toList(),
                                  icon: const Icon(
                                    Icons.arrow_drop_down_circle,
                                    color: Color.fromARGB(255, 10, 169, 159),
                                  ),
                                  dropdownColor:
                                      Color.fromARGB(255, 10, 169, 159),
                                  decoration: const InputDecoration(
                                      labelText: "SubCategory",
                                      prefixIcon: Icon(
                                        Icons.category,
                                        color:
                                            Color.fromARGB(255, 10, 169, 159),
                                      ),
                                      border: UnderlineInputBorder()),
                                ),
                          Expanded(
                            child: Center(
                              child: ButtonWidget(
                                btnText: "Add Product",
                                onClick: () async {
                                  if (formKey.currentState!.validate()) {
                                    pp
                                        .addProduct(
                                      pp.nameController.text,
                                      pp.descriptionController.text,
                                      pp.qualityController.text,
                                      _selectedValue,
                                      pp.priceController.text,
                                      pp.quantityController.text,
                                      DateTime.now().toString(),
                                      pp.greyimage,
                                      pp.greyimage2,
                                      pp.greyimage3,
                                      colorsList,
                                      sizeList,
                                      _uuid.v1(),
                                      pp.squantityController.text == ""
                                          ? "0"
                                          : pp.squantityController.text,
                                      pp.mquantityController.text == ""
                                          ? "0"
                                          : pp.squantityController.text,
                                      pp.lquantityController.text == ""
                                          ? "0"
                                          : pp.squantityController.text,
                                      pp.xlquantityController.text == ""
                                          ? "0"
                                          : pp.squantityController.text,
                                      pp.xxlquantityController.text == ""
                                          ? "0"
                                          : pp.squantityController.text,
                                      false,
                                      "0",
                                      _selectedValue == "male"
                                          ? _selectedValueeM
                                          : _selectedValuee,
                                    )
                                        .then((value) {
                                      sizeList.clear();
                                      colorsList.clear();
                                      Fluttertoast.showToast(
                                        msg: "Product addedd...",
                                      );
                                      Navigator.pop(context);
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
