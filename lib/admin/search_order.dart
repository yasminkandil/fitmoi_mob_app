import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fitmoi_mob_app/utils/color.dart';

import 'order_details.dart';

class OrderSearch extends SearchDelegate {
  CollectionReference products =
      FirebaseFirestore.instance.collection('orders');
  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: products.snapshots().asBroadcastStream(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        } else {
          if (snapshot.data!.docs
              .where((QueryDocumentSnapshot<Object?> element) =>
                  element['orderBy']
                      .toString()
                      .toLowerCase()
                      .contains(query.toLowerCase()))
              .isEmpty) {
            return Center(
                child: Text(
              "No Results Found",
              style: TextStyle(
                color: mintColors,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ));
          }
          return ListView(children: [
            ...snapshot.data!.docs
                .where((QueryDocumentSnapshot<Object?> element) =>
                    element['orderBy']
                        .toString()
                        .toLowerCase()
                        .contains(query.toLowerCase()))
                .map((QueryDocumentSnapshot<Object?> data) {
              final String name = data.get('name');
              final String brand = data.get('orderBy');
              return ListTile(
                  onTap: (() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrderDetailsPage(
                                  orderss: data.id,
                                )));
                  }),
                  title: Text(
                    (name),
                    style: TextStyle(
                      color: mintColors,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    brand,
                    style: TextStyle(
                      color: GreyColors,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ));
            })
          ]);
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
        child: Text(
      "No Suggestions",
      style: TextStyle(
        color: mintColors,
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
      ),
    ));
  }
}
