import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitmoi_mob_app/shop/details/details_screen.dart';
import 'package:fitmoi_mob_app/utils/color.dart';
import 'package:fitmoi_mob_app/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../shop/details/components/body.dart';

class FavScreen extends StatelessWidget {
  FavScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "Favourites"),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('fav')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          var favData = snapshot.data;
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!favData!.exists) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(Icons.playlist_remove, size: 100, color: Colors.grey),
                    Text(" You don't have any favourit products",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 40)),
                  ],
                ),
              ),
            );
          }
          var favProductIds = List<String>.from(favData['products']);
          return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('product')
                .where(FieldPath.documentId, whereIn: favProductIds)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              var productDocs = snapshot.data!.docs;

              return ListView.builder(
                itemCount: productDocs.length,
                itemBuilder: (context, index) {
                  var product = productDocs[index].data();
                  return Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 110,
                                height: 120,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2, color: Colors.white),
                                    boxShadow: [
                                      BoxShadow(
                                          spreadRadius: 2,
                                          blurRadius: 10,
                                          color: Colors.black.withOpacity(0.1))
                                    ],
                                    shape: BoxShape.rectangle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(product['image']))),
                              ),
                              Column(
                                children: [
                                  Text(
                                    product['name'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: mintColors),
                                  ),
                                  Container(
                                    width: 100.0,
                                    height: 20.0,
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text("${product['description']}"),
                                    ),
                                  ),
                                  product['onSale']
                                      ? Text(
                                          "Price: ${product['price2']} EGP",
                                        )
                                      : Text("Price: ${product['price']} EGP"),
                                  const SizedBox(
                                    height: 10,
                                    width: 10,
                                  ),
                                ],
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    favprod.remove(product['id']);
                                    if (favprod.isEmpty) {
                                      FirebaseFirestore.instance
                                          .collection('fav')
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .delete();
                                    } else {
                                      FirebaseFirestore.instance
                                          .collection('fav')
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .update({
                                        'products': favprod,
                                      });
                                    }
                                    Fluttertoast.showToast(
                                      msg: "Removed from Favourites",
                                      // toastLength: Toast.LENGTH_SHORT,
                                      // gravity: ToastGravity.BOTTOM,
                                      // timeInSecForIosWeb: 1,
                                      // backgroundColor: Colors.grey,
                                      // textColor: Colors.white,
                                      // fontSize: 16.0
                                    );
                                  }),
                              IconButton(
                                  icon: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: mintColors,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                          prod: product['id'],
                                        ),
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
