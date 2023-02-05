import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetOrders extends StatelessWidget {
  final String orderss;

  const GetOrders({required this.orderss});

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
          return ListTile(
              title: Text(data['orderBy']),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(data['orderStatus']),
                  // IconButton(onPressed: onPressed, icon: Icon(Icons.remove_red_eye))
                ],
              ));
        }
        return Text('loading..');
      }),
    );
  }
}
