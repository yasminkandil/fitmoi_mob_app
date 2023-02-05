import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fitmoi_mob_app/models/product_model.dart';
import 'package:fitmoi_mob_app/utils/color.dart';
import 'package:fitmoi_mob_app/widgets/btn_widget.dart';

import '../widgets/app_bar.dart';

class EditStatus extends StatelessWidget {
  final String ord;
  EditStatus({required this.ord});
  final CollectionReference _products =
      FirebaseFirestore.instance.collection('orders');

  @override
  Widget build(BuildContext context) {
    CollectionReference products =
        FirebaseFirestore.instance.collection('orders');

    return FutureBuilder<DocumentSnapshot>(
      future: products.doc(ord).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data?.data() != null
              ? snapshot.data!.data()! as Map<String, dynamic>
              : <String, dynamic>{};
          TextEditingController orderstatus =
              TextEditingController(text: data['orderStatus']);

          return Scaffold(
            appBar: CustomAppBar(text: "Edit order Status"),
            //backgroundColor: Color.fromARGB(255, 103, 101, 101),
            body: Container(
              padding: EdgeInsets.only(top: 200),
              child: Column(
                children: <Widget>[
                  // HeaderContainer("Register"),

                  Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                      child: IntrinsicHeight(
                        child: Container(
                          margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              _textInput(
                                  controller: orderstatus,
                                  hint: "${data['orderStatus']}",
                                  icon: Icons.edit,
                                  label: "OrderStatus"),
                              SizedBox(
                                height: 70,
                                width: 70,
                              ),
                              ListTile(
                                title: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: ButtonWidget2(
                                        btnText: "Edit Status",
                                        onClick: () {
                                          final updateprod = FirebaseFirestore
                                              .instance
                                              .collection('orders')
                                              .doc(ord)
                                              .update(
                                            {
                                              'orderStatus': orderstatus.text,
                                            },
                                          ).then((value) {
                                            Fluttertoast.showToast(
                                                msg: 'Order Status Changed');

                                            Navigator.pop(context);
                                          });
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: ButtonWidgetdelete(
                                        btnText: "Delete Order",
                                        onClick: () {
                                          final deleteprod = FirebaseFirestore
                                              .instance
                                              .collection('orders')
                                              .doc(ord)
                                              .delete()
                                              .then((value) {
                                            Fluttertoast.showToast(
                                                msg: 'Order Deleted..');

                                            Navigator.pop(context);
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return Text('loading..');
      }),
    );
  }

  Widget _textInput({controller, hint, icon, label}) {
    return Container(
      margin: EdgeInsets.only(top: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          prefixIcon: Icon(
            icon,
            color: Color.fromARGB(255, 249, 118, 3),
          ),
        ),
      ),
    );
  }
}
