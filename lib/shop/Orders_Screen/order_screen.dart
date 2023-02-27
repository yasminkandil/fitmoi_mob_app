import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitmoi_mob_app/shop/Orders_Screen/order_details.dart';
import 'package:fitmoi_mob_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../widgets/app_bar.dart';

class OrderScreen extends StatelessWidget {
  OrderScreen({super.key, required this.ord});
  final String ord;

  List<String> orders = [];

  Future getDocord() async {
    await FirebaseFirestore.instance
        .collection('orders')
        .where('orderBy', isEqualTo: FirebaseAuth.instance.currentUser?.email)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach((document) {
            print(document.reference);
            orders.add(document.reference.id);
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: "My Orders",
      ),
      //backgroundColor: Colors.orange,
      body: FutureBuilder(
        future: getDocord(),
        builder: (context, snapshot) {
          //var orders = snapshot.data;
          if (orders.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(Icons.playlist_remove, size: 100, color: Colors.grey),
                    Center(
                      child: Text(" You don't have any orders yet",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                              wordSpacing: 10)),
                    ),
                  ],
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) =>
                buildOrders(ord: orders[index], index: index),
          );
        },
      ),
    );
  }
}

class buildOrders extends StatelessWidget {
  buildOrders({super.key, required this.ord, required this.index});
  final String ord;
  final int index;
  var indexx = 0;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('orders').doc(ord).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data?.data() != null
              ? snapshot.data!.data()! as Map<String, dynamic>
              : <String, dynamic>{};

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
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "  ${index + 1} ",
                        style: TextStyle(
                            color: mintColors,
                            fontSize: 18.2,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Products:",
                              style: TextStyle(
                                  color: mintColors,
                                  fontSize: 16.2,
                                  fontWeight: FontWeight.bold)),
                          Text(
                              "${data['products'].toString().replaceAll("[", "").replaceAll("]", "")}"),
                          Row(
                            children: [
                              Text("Order Price:",
                                  style: TextStyle(
                                      color: mintColors,
                                      fontSize: 16.2,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                "${data['totalPrice']}  " + "EGP",
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("On:",
                                  style: TextStyle(
                                      color: mintColors,
                                      fontSize: 16.2,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                "  ${data["orderDate"]}",
                              ),
                            ],
                          ),
                          data['orderStatus'] == 'Delivered'
                              ? const Text(
                                  " DELIVERED ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    backgroundColor: Colors.green,
                                  ),
                                )
                              : const Text(
                                  textAlign: TextAlign.center,
                                  " PENDING ",
                                  style: TextStyle(
                                      color: Colors.white,
                                      backgroundColor: Colors.orange),
                                ),
                        ],
                      ),
                      const SizedBox(
                        width: 60,
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: mintColors,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrdersDetails(
                                  ord: ord,
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                ],
              ));
        }
        return const Text("Loading..");
      }),
    );
  }
}
