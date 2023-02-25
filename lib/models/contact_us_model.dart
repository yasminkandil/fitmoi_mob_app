import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

TextEditingController emaillController = TextEditingController();
TextEditingController messageController = TextEditingController();
Future addMessages(String email, String message, String id) async {
  await FirebaseFirestore.instance.collection('contact_us').doc().set(
    {'email': email, 'message': message, 'id': id},
  );

  print('Message added');
}

class ContactUsModel {
  String email;
  String message;

  ContactUsModel({
    required this.email,
    required this.message,
  });
}

class ContactUsData {
  Future<Object> getmessages() async {
    final DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection('contact_us').doc().get();
    return documentSnapshot;
  }
}
