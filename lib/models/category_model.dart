import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

String errormssg = "You can't leave this field empty";
String aregexp = r'^[a-z A-Z]+$';
var imageUrl;
var downloadUrl;
var imagee;
var greyimage =
    'https://media.tarkett-image.com/large/TH_24567080_24594080_24596080_24601080_24563080_24565080_24588080_001.jpg';

List<String> categList = [];
setCateg(List<String> categ) {
  categList = categ;
}

getCateg() {
  return categList;
}

Future addCategory(
  String name,
  String prodimage,
  String id,
  List<String> subcategory,
) async {
  await FirebaseFirestore.instance.collection('categ').doc(id).set(
      {'name': name, 'image': prodimage, 'id': id, 'subcategory': subcategory});
}

class CategoryModel {
  String image;
  String name;
  String id;
  List<String> subcategory;
  CategoryModel({
    required this.image,
    required this.id,
    required this.name,
    required this.subcategory,
  });
}
