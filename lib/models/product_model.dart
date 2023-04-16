import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

String errormssg = "You can't leave this field empty";
String aregexp = r'^[a-z A-Z]+$';

String selectedValC = 'Black';
String selectedValQ = 'Original';
String selectedValCat = 'T-Shirt Female';
TextEditingController nameController = TextEditingController();
TextEditingController descriptionController = TextEditingController();
TextEditingController sizeController = TextEditingController();
TextEditingController priceController = TextEditingController();
TextEditingController qualityController = TextEditingController();
TextEditingController quantityController = TextEditingController();
TextEditingController colorController = TextEditingController();
TextEditingController categController = TextEditingController();
TextEditingController squantityController = TextEditingController();
TextEditingController mquantityController = TextEditingController();
TextEditingController lquantityController = TextEditingController();
TextEditingController xlquantityController = TextEditingController();
TextEditingController xxlquantityController = TextEditingController();

var imageUrl;
var downloadUrl;
var imagee;
var greyimage =
    'https://media.tarkett-image.com/large/TH_24567080_24594080_24596080_24601080_24563080_24565080_24588080_001.jpg';
var greyimage3 =
    'https://media.tarkett-image.com/large/TH_24567080_24594080_24596080_24601080_24563080_24565080_24588080_001.jpg';
var greyimage2 =
    'https://media.tarkett-image.com/large/TH_24567080_24594080_24596080_24601080_24563080_24565080_24588080_001.jpg';
late String Cvalue;
var imageUrl2;
var downloadUrl2;
var imagee2;
var imagee3;
var imageUrl3;
var downloadUrl3;
List<String> colorsList = [];
List<String> sizeList = [];
List<String> categList = [];
setCateg(List<String> categ) {
  categList = categ;
}

getCateg() {
  return categList;
}

setColors(List<String> colors) {
  colorsList = colors;
}

getColors() {
  return colorsList;
}

setSizes(List<String> sizes) {
  sizeList = sizes;
}

getSizes() {
  return sizeList;
}

String getCValue() {
  return Cvalue;
}

late String Categvalue;

String getCategValue() {
  return Categvalue;
}

late String Qvalue;

String getQValue() {
  return Qvalue;
}

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

setImage3(String imagee3) {
  imagee3 = imagee3;
}

getImage3() {
  return imagee3;
}

Future addProduct(
    String name,
    String description,
    //String brand,
    String quality,
    //String color,
    String category,
    String price,
    String quantity,
    String date,
    String prodimage,
    String img2,
    String img3,
    List<String> colors,
    List<String> size,
    String id,
    String squantity,
    String mquantity,
    String lquantity,
    String xlquantity,
    String xxlquantity,
    bool onSale,
    String price2,
    String subcategory) async {
  await FirebaseFirestore.instance.collection('product').doc(id).set({
    'name': name,
    'description': description,
    'quality': quality,
    'color': colors,
    'category': category,
    'price': price,
    'quantity': quantity,
    'image': prodimage,
    'Date': date,
    'image2': img2,
    'size': size,
    'image3': img3,
    'id': id,
    'squantity': squantity,
    'mquantity': mquantity,
    'lquantity': lquantity,
    'xlquantity': xlquantity,
    'xxlquantity': xxlquantity,
    'onSale': onSale,
    'price2': price2,
    'subcategory': subcategory,
  });
}

class ProductModel {
  String image;
  String image2;
  String image3;
  bool onSale;
  String name;
  String front;
  String back;
  String subcategory;
  String quantity;
  String price;
  String price2;
  String description;
  String id;
  String category;
  List<String> colors;
  List<String> size;
  // String? brand;
  String date;
  String squantity;
  String mquantity;
  String lquantity;
  String xlquantity;
  String xxlquantity;
  String quality;

  ProductModel({
    required this.image,
    required this.image2,
    required this.image3,
    required this.onSale,
    required this.front,
    required this.back,
    required this.subcategory,
    required this.quantity,
    required this.price,
    required this.price2,
    required this.description,
    required this.id,
    required this.name,
    required this.category,
    required this.colors,
    required this.size,
    required this.date,
    required this.squantity,
    required this.mquantity,
    required this.lquantity,
    required this.xlquantity,
    required this.xxlquantity,
    required this.quality,

    // required this.brand,
  });
}
