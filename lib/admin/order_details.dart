import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fitmoi_mob_app/admin/edit_orderStatus.dart';
import 'package:fitmoi_mob_app/models/product_model.dart';
import 'package:fitmoi_mob_app/utils/color.dart';
import 'package:fitmoi_mob_app/widgets/btn_widget.dart';

import '../widgets/app_bar.dart';

class OrderDetailsPage extends StatelessWidget {
  final String orderss;
  OrderDetailsPage({required this.orderss});

  final CollectionReference _products =
      FirebaseFirestore.instance.collection('orders');

  @override
  Widget build(BuildContext context) {
    CollectionReference products =
        FirebaseFirestore.instance.collection('orders');

    return FutureBuilder<DocumentSnapshot>(
      future: products.doc(orderss).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data?.data() != null
              ? snapshot.data!.data()! as Map<String, dynamic>
              : <String, dynamic>{};
          return Scaffold(
            appBar: CustomAppBar(text: "Order Details"),
            //backgroundColor: Color.fromARGB(255, 103, 101, 101),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(
                  8.0,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 150,
                      width: 150,
                    ),
                    Center(
                      child: RichText(
                        textScaleFactor: 2.0,
                        text: TextSpan(
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold), //apply style to all
                          children: [
                            // <-- Text
                            TextSpan(
                                text: 'Order By : ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: '${data['orderBy']}\n',
                                style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.normal)),

                            TextSpan(
                                text: 'Order Status  : ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: '${data['orderStatus']}\n',
                                style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.normal)),

                            TextSpan(
                                text: 'Payment Method  : ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: '${data['paymentMethod']}\n',
                                style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.normal)),
                            TextSpan(
                                text: 'Products  : ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: '${data['products']}\n',
                                style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.normal)),
                            TextSpan(
                                text: 'Shipping Method  : ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: '${data['shippingMethod']}\n',
                                style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.normal)),
                            TextSpan(
                                text: 'Order Date  : ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: '${data['orderDate']}\n',
                                style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.normal)),
                            TextSpan(
                                text: 'Order Total  : ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: '${data['totalPrice']}\n',
                                style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.normal)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      width: 100,
                    ),
                    Center(
                        child: ButtonWidget(
                            btnText: "Edit Status",
                            onClick: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EditStatus(ord: data['orderNo'])));
                            })),
                  ],
                ),
              ),
            ),
          );
        }
        return Text('loading..');
      }),
    );
  }
}
