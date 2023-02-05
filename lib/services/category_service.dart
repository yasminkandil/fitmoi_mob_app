import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitmoi_mob_app/models/category_model.dart';
import 'package:flutter/material.dart';
import '../models/category_model.dart';

class CategoriesService {
  final CollectionReference _categoriesCollectionReference =
      FirebaseFirestore.instance.collection('categ');

  Future<List<CategoryModel>> getcategories() async {
    List<CategoryModel> categories = [];
    QuerySnapshot snapshot = await _categoriesCollectionReference.get();
    snapshot.docs.forEach((document) {
      CategoryModel categ = CategoryModel(
        name: document.data().toString().contains('name')
            ? document.get('name')
            : '',
        image: document.data().toString().contains('image')
            ? document.get('image')
            : '',
        subcategory: document.data().toString().contains('subtitle')
            ? List<String>.from(document.get('subtitle'))
            : [],
        id: document.data().toString().contains('id') ? document.get('id') : '',
      );
      categories.add(categ);
    });

    return categories;
  }
}
