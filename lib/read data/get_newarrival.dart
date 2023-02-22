import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../utils/color.dart';

class GetOffersPage extends StatelessWidget {
  final String offer;

  const GetOffersPage({required this.offer});

  // const GetUserName({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference products =
        FirebaseFirestore.instance.collection('offers');

    return FutureBuilder<DocumentSnapshot>(
      future: products.doc(offer).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data?.data() != null
              ? snapshot.data!.data()! as Map<String, dynamic>
              : <String, dynamic>{};
          return RichText(
            textScaleFactor: 2,
            text: TextSpan(
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold), //apply style to all

              children: [
                // <-- Text
                TextSpan(
                    text: 'Name : ',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                TextSpan(
                    text: '${data['name']}\n',
                    style: TextStyle(
                        color: mintColors, fontWeight: FontWeight.normal)),
                TextSpan(
                    text: 'Description  : ',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                TextSpan(
                    text: '${data['description']}\n',
                    style: TextStyle(
                        color: mintColors, fontWeight: FontWeight.normal)),
                TextSpan(
                    text: 'Percentage : ',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                TextSpan(
                    text: '${data['percentage']} %\n',
                    style: TextStyle(
                        color: mintColors, fontWeight: FontWeight.normal)),
                TextSpan(
                    text: 'Start Date  : ',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                TextSpan(
                    text: '${data['datein']}\n',
                    style: TextStyle(
                        color: mintColors, fontWeight: FontWeight.normal)),
                TextSpan(
                    text: 'End Date  : ',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                TextSpan(
                    text: '${data['dateout']}\n',
                    style: TextStyle(
                        color: mintColors, fontWeight: FontWeight.normal)),
              ],
            ),
          );
        }
        return Text('loading..');
      }),
    );
  }
}
