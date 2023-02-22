import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'package:fitmoi_mob_app/pages/components/componentsCategory.dart';

import 'package:fitmoi_mob_app/pages/components/item_card.dart';

import '../../shop/details/details_screen.dart';

class Body extends StatelessWidget {
  String cat;
  Body({super.key, required this.cat});

  List<String> products = [];

  Future getDocProd() async {
    await FirebaseFirestore.instance
        .collection('products')
        .where('category', isEqualTo: cat)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach((document) {
            print(document.reference);
            products.add(document.reference.id);
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Categorie(),
        Expanded(
          child: FutureBuilder(
              future: getDocProd(),
              builder: (context, snapshot) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: GridView.builder(
                    itemCount: products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 0.75),
                    itemBuilder: (context, index) => Itemcard(
                      prod: products[index],
                      press: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailScreen(prod: products[index]))),
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }
}
