import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitmoi_mob_app/admin/add_product.dart';
import 'package:fitmoi_mob_app/widgets/upload_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/product_model.dart';
import '../provider/product_provider.dart';
import '../services/product_service.dart';
import '../utils/color.dart';
import '../widgets/app_bar.dart';
import '../widgets/btn_widget.dart';
import '../widgets/reg_textinput.dart';

class EditProdd extends StatelessWidget {
  final String prodd;
  const EditProdd({required this.prodd});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "Edit Product"),
      body: Container(
        child: FutureBuilder<DocumentSnapshot>(
          future: products.doc(prodd).get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else {
              //  final document = snapshot.data;
              Map<String, dynamic> data = snapshot.data?.data() != null
                  ? snapshot.data!.data()! as Map<String, dynamic>
                  : <String, dynamic>{};
              TextEditingController nameeController =
                  TextEditingController(text: data['name']);
              TextEditingController descriptionnController =
                  TextEditingController(text: data['description']);
              TextEditingController priceeController =
                  TextEditingController(text: data['price']);
              TextEditingController quantityyController =
                  TextEditingController(text: data['quantity']);
              TextEditingController squantityyController =
                  TextEditingController(text: data['squantity']);
              TextEditingController mquantityyController =
                  TextEditingController(text: data['mquantity']);
              TextEditingController lquantityyController =
                  TextEditingController(text: data['lquantity']);
              TextEditingController xlquantityyController =
                  TextEditingController(text: data['xlquantity']);
              TextEditingController xxlquantityyController =
                  TextEditingController(text: data['xxlquantity']);
              TextEditingController qualityyController =
                  TextEditingController(text: data['quality']);
              TextEditingController categoryyController =
                  TextEditingController(text: data['category']);
              TextEditingController colorrController = TextEditingController();
              TextEditingController sizeeController = TextEditingController();

              return Container(
                padding: EdgeInsets.only(bottom: 5),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        UploadBodyImages(
                            textt: "Main image",
                            onPressed: () {},
                            imagepath: data['image']),
                        UploadBodyImages(
                            textt: "Second image",
                            onPressed: () {},
                            imagepath: data['image2']),
                        UploadBodyImages(
                            textt: "Third image",
                            onPressed: () {},
                            imagepath: data['image3']),
                      ],
                    ),
                    Expanded(
                      flex: 1,
                      child: SingleChildScrollView(
                        child: IntrinsicHeight(
                          child: Container(
                            margin:
                                EdgeInsets.only(left: 20, right: 20, top: 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Text(
                                  "Product Name:",
                                  style: TextStyle(
                                      color: mintColors,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                RegTextInput(
                                    controller: nameeController,
                                    hint: "Product Name",
                                    icon: Icons.edit_attributes_outlined,
                                    torf: false,
                                    errormssg: errormssg,
                                    regexp: aregexp,
                                    enable: true),
                                Text(
                                  "Description:",
                                  style: TextStyle(
                                      color: mintColors,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                RegTextInput(
                                    controller: descriptionnController,
                                    hint: "Description",
                                    icon: Icons.edit_attributes_outlined,
                                    torf: false,
                                    errormssg: errormssg,
                                    regexp: aregexp,
                                    enable: true),
                                Text(
                                  "Price:",
                                  style: TextStyle(
                                      color: mintColors,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                RegTextInput(
                                    controller: priceeController,
                                    hint: "Price",
                                    icon: Icons.money,
                                    torf: false,
                                    errormssg: errormssg,
                                    regexp: mregexp,
                                    enable: true),
                                Text(
                                  "Quantity:",
                                  style: TextStyle(
                                      color: mintColors,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                RegTextInput(
                                    controller: quantityyController,
                                    hint: "Quantity",
                                    icon: Icons.numbers,
                                    torf: false,
                                    errormssg: errormssg,
                                    regexp: mregexp,
                                    enable: true),
                                Text(
                                  "Quality:",
                                  style: TextStyle(
                                      color: mintColors,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                RegTextInput(
                                    controller: qualityyController,
                                    hint: "Quality",
                                    icon: Icons.numbers,
                                    torf: false,
                                    errormssg: errormssg,
                                    regexp: mregexp,
                                    enable: true),
                                Text(
                                  "Category:",
                                  style: TextStyle(
                                      color: mintColors,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                RegTextInput(
                                    controller: categoryyController,
                                    hint: "Category",
                                    icon: Icons.numbers,
                                    torf: false,
                                    errormssg: errormssg,
                                    regexp: mregexp,
                                    enable: true),
                                Text(
                                  "Colors:",
                                  style: TextStyle(
                                      color: mintColors,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    " ${data['color'].toString().replaceAll("[", "").replaceAll("]", "")}"),
                                Text(
                                  "Size:",
                                  style: TextStyle(
                                      color: mintColors,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    " ${data['size'].toString().replaceAll("[", "").replaceAll("]", "")}"),
                                RegTextInput(
                                    controller: colorrController,
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
                                      colorsList.add(colorController.text);
                                      Fluttertoast.showToast(
                                          msg: "Color Added",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor:
                                              Color.fromARGB(255, 10, 169, 159),
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                      // pp.colorController.clear();
                                    },
                                    btnText: 'Add Color',
                                  ),
                                ),
                                RegTextInput(
                                    controller: sizeeController,
                                    hint: "Size",
                                    icon: Icons.photo_size_select_small,
                                    torf: false,
                                    errormssg: errormssg,
                                    regexp: aregexp,
                                    enable: true),
                                Expanded(
                                  child: ButtonWidget(
                                    onClick: () {
                                      sizeList.add(sizeeController.text);
                                      Fluttertoast.showToast(
                                          msg: "Size Added",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor:
                                              Color.fromARGB(255, 10, 169, 159),
                                          textColor: Colors.white,
                                          fontSize: 16.0);

                                      //pp.sizeController.clear();
                                    },
                                    btnText: 'Add Size',
                                  ),
                                ),
                                sizeList.contains('small') ||
                                        sizeList.contains("Small")
                                    ? RegTextInput(
                                        controller: squantityyController,
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
                                        controller: mquantityyController,
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
                                        controller: lquantityyController,
                                        hint: "Large Quantity",
                                        icon: Icons.numbers,
                                        torf: false,
                                        errormssg: errormssg,
                                        regexp: mregexp,
                                        enable: true)
                                    : Container(),
                                sizeList.contains('xlarge') ||
                                        sizeList.contains("XLarge") ||
                                        sizeList.contains("Xlarge")
                                    ? RegTextInput(
                                        controller: xlquantityyController,
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
                                        controller: xxlquantityyController,
                                        hint: "XX-Large Quantity",
                                        icon: Icons.numbers,
                                        torf: false,
                                        errormssg: errormssg,
                                        regexp: mregexp,
                                        enable: true)
                                    : Container(),
                                ListTile(
                                  title: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: ButtonWidget2(
                                          btnText: "Edit Product",
                                          onClick: () {
                                            final updateprod = FirebaseFirestore
                                                .instance
                                                .collection('product')
                                                .doc(prodd)
                                                .update(
                                              {
                                                'name':
                                                    nameeController.text.trim(),
                                                'description':
                                                    descriptionnController.text
                                                        .trim(),
                                                'price': priceeController.text
                                                    .trim(),
                                                'quantity': quantityyController
                                                    .text
                                                    .trim(),
                                              },
                                            ).then((value) {
                                              Fluttertoast.showToast(
                                                msg: "Updated Successfully",
                                              );
                                              Navigator.pop(context);
                                            });
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: ButtonWidgetdelete(
                                          btnText: "Delete Product",
                                          onClick: () {
                                            final deleteprod = FirebaseFirestore
                                                .instance
                                                .collection('product')
                                                .doc(prodd)
                                                .delete()
                                                .then((value) {
                                              Fluttertoast.showToast(
                                                  msg: 'Product deleted..');

                                              Navigator.pop(context);
                                            });
                                          },
                                        ),
                                      ),
                                    ],
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
              );
            }
          },
        ),
      ),
    );
  }
}

CollectionReference products = FirebaseFirestore.instance.collection('product');
