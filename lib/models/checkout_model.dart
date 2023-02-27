import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

TextEditingController nameController = TextEditingController();
TextEditingController addressController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController paymentMController = TextEditingController();
TextEditingController ccnController = TextEditingController();
TextEditingController ccvController = TextEditingController();
TextEditingController expdateController = TextEditingController();

Future orders(
  String name,
  String add,
  String phone,
  String paymentM,
  String ccn,
  String ccv,
  String expdate,
) async {
  await FirebaseFirestore.instance.collection('orders').doc().set(
    {
      'name': name,
      'address': add,
      'phone': phone,
      'payment': paymentM,
      'creditcardnumber': ccn,
      'ccv': ccv,
      'expirydate': expdate,
    },
  );

  print('order placed');
}

class Ordermodel {
  String name;
  String address;
  String phone;
  String paymentM;
  String creditcardnumber;
  String ccv;

  Ordermodel({
    required this.name,
    required this.address,
    // required this.images,
    required this.phone,
    required this.paymentM,
    required this.creditcardnumber,
    required this.ccv,
    // required this.type,
  });

  toJson() {
    return {
      name: ["name"],
      address: ["address"],
      phone: ["phone"],
      paymentM: ["paymentM"],
      creditcardnumber: ["creditcardnumber"],
      ccv: ["ccv"],
    };
  }

  Future getcart() async {
    String userName;
    final DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection('orders').doc().get();
    userName = documentSnapshot.get('orders');
    return userName;
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "address": address,
      "phone": phone,
      "ccn": creditcardnumber,
      "ccv": ccv,
    };
  }
}

class Data {
  Future<Object> getUsers() async {
    final DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection('cart').doc().get();
    return documentSnapshot;
  }
}
