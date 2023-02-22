import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../models/product_model2.dart';

class description extends StatelessWidget {
  ProductModel2 productModel2;

  description(this.productModel2);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        "${productModel2.description}",
        style: TextStyle(height: 1.5),
      ),
    );
  }
}
