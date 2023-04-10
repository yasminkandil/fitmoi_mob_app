import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitmoi_mob_app/shop/details/components/generate_model.dart';
import 'package:flutter/material.dart';

import '../../../models/product_model2.dart';

class description extends StatelessWidget {
  ProductModel2 productModel2;

  description(this.productModel2);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        textAlign: TextAlign.left,
        "${productModel2.description}",
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
