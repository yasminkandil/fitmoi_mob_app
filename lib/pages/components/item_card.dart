import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../shop/details/details_screen.dart';

class Itemcard extends StatelessWidget {
  final Function press;
  final String prod;
  const Itemcard({
    required this.prod,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    CollectionReference products =
        FirebaseFirestore.instance.collection('product');
    final pro = FirebaseFirestore.instance.collection('product');

    return FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('product').doc(prod).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data?.data() != null
                ? snapshot.data!.data()! as Map<String, dynamic>
                : <String, dynamic>{};
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DetailScreen(
                    prod: prod,
                  );
                }));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(35),
                      height: 180,
                      width: 160,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 103, 103, 103),
                          borderRadius: BorderRadius.circular(16)),
                      child: Image(
                          fit: BoxFit.fitWidth,
                          image: NetworkImage("${data["image"]}")),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10 / 4),
                      child: Text("${data['name']}")),
                  data['onSale'] == true
                      ? RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "${data['price']} LE ",
                                style: TextStyle(
                                    color: Colors.red,
                                    decoration: TextDecoration.lineThrough)),
                            TextSpan(
                                text: "${data['price2']} LE ",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    ?.copyWith(
                                        color: Color.fromARGB(255, 5, 5, 5),
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold)),
                          ]),
                        )
                      : RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "${data['price']} LE",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    ?.copyWith(
                                        color: Color.fromARGB(255, 8, 8, 8),
                                        fontSize: 14)),
                          ]),
                        ),
                ],
              ),
            );
          }
          return Text('loading..');
        }));
  }
}
