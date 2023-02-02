import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/product_model.dart';

class ProductsService {
  final CollectionReference _productsCollectionReference =
      FirebaseFirestore.instance.collection('product');

  Future<List<ProductModel>> getproducts() async {
    List<ProductModel> products = [];
    QuerySnapshot snapshot = await _productsCollectionReference.get();
    snapshot.docs.forEach((document) {
      ProductModel product = ProductModel(
        name: document.data().toString().contains('name')
            ? document.get('name')
            : '',
        price: document.data().toString().contains('price')
            ? document.get('price')
            : '',
        description: document.data().toString().contains('description')
            ? document.get('description')
            : '',
        image: document.data().toString().contains('image')
            ? document.get('image')
            : '',
        image2: document.data().toString().contains('image2')
            ? document.get('image2')
            : '',
        image3: document.data().toString().contains('image3')
            ? document.get('image3')
            : '',
        price2: document.data().toString().contains('price2')
            ? document.get('price2')
            : '',
        date: document.data().toString().contains('Date')
            ? document.get('Date')
            : '',
        quantity: document.data().toString().contains('quantity')
            ? document.get('quantity')
            : '',
        category: document.data().toString().contains('category')
            ? document.get('category')
            : '',
        id: document.data().toString().contains('id') ? document.get('id') : '',
        onSale: document.data().toString().contains('onSale')
            ? document.get('onSale')
            : false,
        colors: document.data().toString().contains('color')
            ? List<String>.from(document.get('color'))
            : [],
        size: document.data().toString().contains('size')
            ? List<String>.from(document.get('size'))
            : [],
        squantity: document.data().toString().contains('squantity')
            ? document.get('squantity')
            : '',
        mquantity: document.data().toString().contains('mquantity')
            ? document.get('mquantity')
            : '',
        lquantity: document.data().toString().contains('lquantity')
            ? document.get('lquantity')
            : '',
        xlquantity: document.data().toString().contains('xlquantity')
            ? document.get('xlquantity')
            : '',
        xxlquantity: document.data().toString().contains('xxlquantity')
            ? document.get('xxlquantity')
            : '',
      );

      products.add(product);
    });

    return products;
  }

  Future<ProductModel> getSpecificproduct(String id) async {
    List<ProductModel> products = [];
    DocumentSnapshot snapshot =
        await _productsCollectionReference.doc(id).get();
    ProductModel product = ProductModel(
      name: snapshot.data().toString().contains('name')
          ? snapshot.get('name')
          : '',
      price: snapshot.data().toString().contains('price')
          ? snapshot.get('price')
          : '',
      description: snapshot.data().toString().contains('description')
          ? snapshot.get('description')
          : '',
      image: snapshot.data().toString().contains('image')
          ? snapshot.get('image')
          : '',
      image2: snapshot.data().toString().contains('image2')
          ? snapshot.get('image2')
          : '',
      image3: snapshot.data().toString().contains('image3')
          ? snapshot.get('image3')
          : '',
      price2: snapshot.data().toString().contains('price2')
          ? snapshot.get('price2')
          : '',
      date: snapshot.data().toString().contains('Date')
          ? snapshot.get('Date')
          : '',
      quantity: snapshot.data().toString().contains('quantity')
          ? snapshot.get('quantity')
          : '',
      category: snapshot.data().toString().contains('category')
          ? snapshot.get('category')
          : '',
      id: snapshot.data().toString().contains('id') ? snapshot.get('id') : '',
      onSale: snapshot.data().toString().contains('onSale')
          ? snapshot.get('onSale')
          : false,
      colors: snapshot.data().toString().contains('color')
          ? List<String>.from(snapshot.get('color'))
          : [],
      size: snapshot.data().toString().contains('size')
          ? List<String>.from(snapshot.get('size'))
          : [],
      squantity: snapshot.data().toString().contains('squantity')
          ? snapshot.get('squantity')
          : '',
      mquantity: snapshot.data().toString().contains('mquantity')
          ? snapshot.get('mquantity')
          : '',
      lquantity: snapshot.data().toString().contains('lquantity')
          ? snapshot.get('lquantity')
          : '',
      xlquantity: snapshot.data().toString().contains('xlquantity')
          ? snapshot.get('xlquantity')
          : '',
      xxlquantity: snapshot.data().toString().contains('xxlquantity')
          ? snapshot.get('xxlquantity')
          : '',
    );

    return product;
  }
}
