import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitmoi_mob_app/utils/color.dart';
import 'package:flutter/material.dart';

import '../../widgets/app_bar.dart';

class OrdersDetails extends StatelessWidget {
  const OrdersDetails({super.key, required this.ord});
  final String ord;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          text: "Order Details",
        ),
        //backgroundColor: Colors.orange,
        body: FutureBuilder(
            future:
                FirebaseFirestore.instance.collection('orders').doc(ord).get(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data = snapshot.data?.data() != null
                    ? snapshot.data!.data()! as Map<String, dynamic>
                    : <String, dynamic>{};
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    child: Center(
                      child: ListView(
                        children: [
                          Text("Email: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: mintColors,
                                  fontSize: 18,
                                  height: 2)),
                          Text("${data['orderBy']} ",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  height: 2)),
                          Text("Date:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: mintColors,
                                  fontSize: 18,
                                  height: 2)),
                          Text("${data['orderDate']}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  height: 2)),
                          Text("Order Status:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                height: 2,
                                color: mintColors,
                              )),
                          Text(" ${data['orderStatus']}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  height: 2)),
                          Text(
                            "Product Name:",
                            style: TextStyle(
                                color: mintColors,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                height: 2),
                          ),
                          Text(
                            "${data['products']}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                height: 2),
                          ),
                          Text("Total Paid:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                height: 2,
                                color: mintColors,
                              )),
                          Text("${data['totalPrice']}" + "EGP",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  height: 2)),
                          Text("Payment Method:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                height: 2,
                                color: mintColors,
                              )),
                          Text("${data['paymentMethod']}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  height: 2)),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return const Text("Loading...");
            })));
  }
}
