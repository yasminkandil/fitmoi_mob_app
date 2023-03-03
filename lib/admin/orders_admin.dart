import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fitmoi_mob_app/admin/order_details.dart';
import 'package:fitmoi_mob_app/read%20data/get_orders.dart';
import 'package:fitmoi_mob_app/utils/color.dart';
//import 'package:fitmoi_mob_app/widgets/adminappbar.dart';
import '../widgets/app_bar.dart';

class ViewOrdersPage extends StatelessWidget {
  final pro = FirebaseFirestore.instance.collection('orders');

  List<String> order = [];

  Future getDocorder() async {
    await FirebaseFirestore.instance.collection('orders').get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            print(document.reference);
            order.add(document.reference.id);
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBar(text: "Orders List"),
      body: FutureBuilder(
        future: getDocorder(),
        builder: (context, snapshot) {
          Map<String, dynamic> data = snapshot.data?.data() != null
              ? snapshot.data!.data()! as Map<String, dynamic>
              : <String, dynamic>{};
          return ListView.builder(
            itemCount: order.length,
            itemBuilder: (context, index) {
              return Container(
                child: Column(
                  children: <Widget>[
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: mintColors,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderDetailsPage(
                              orderss: order[index],
                            ),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Icon(
                            // <-- Icon
                            Icons.remove_red_eye,
                            size: 20.0,
                          ),
                          Text('View Order ${order[index]}'), // <-- Text
                          const SizedBox(
                            width: 2,
                          ),
                        ],
                      ),
                    ),
                    ListTile(title: GetOrders(orderss: order[index])),
                    Divider(
                      color: mintColors,
                      height: 10,
                      thickness: 3,
                      indent: 25,
                      endIndent: 25,
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
