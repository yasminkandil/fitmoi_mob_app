import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fitmoi_mob_app/models/product_model.dart';
import 'package:fitmoi_mob_app/utils/color.dart';

import '../shop/details/details_screen.dart';

class OffersData extends StatelessWidget {
  final String offersitemss;
  OffersData({required this.offersitemss});
  @override
  Widget build(BuildContext context) {
    CollectionReference products =
        FirebaseFirestore.instance.collection('product');

    return FutureBuilder<DocumentSnapshot>(
      future: products.doc(offersitemss).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data?.data() != null
              ? snapshot.data!.data()! as Map<String, dynamic>
              : <String, dynamic>{};
          return Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailScreen(prod: offersitemss)));
                    },
                    child: Container(
                      height: 200,
                      width: 160,
                      child: Image.network(data['image'],
                          fit: BoxFit.scaleDown, width: 10, height: 100),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailScreen(prod: offersitemss)));
                    },
                    child: RichText(
                      textScaleFactor: 1.5,
                      text: TextSpan(
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold), //apply style to all
                          children: [
                            // <-- Text
                            TextSpan(
                                text: 'Name : ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: '${data['name']}\n',
                                style: TextStyle(
                                    color: GreyColors,
                                    fontWeight: FontWeight.normal)),
                            TextSpan(
                                text: 'Before : ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: "${data['price']} LE \n ",
                                style: TextStyle(
                                    color: Colors.red,
                                    decoration: TextDecoration.lineThrough)),
                            TextSpan(
                                text: 'After : ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: "${data['price2']} LE \n",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    ?.copyWith(
                                      color: Color.fromARGB(255, 5, 5, 5),
                                      fontSize: 14,
                                    )),
                          ]),
                    ),
                  ),
                ],
              ),
            ],
          );
        }
        return Text('loading..');
      }),
    );
  }
}
