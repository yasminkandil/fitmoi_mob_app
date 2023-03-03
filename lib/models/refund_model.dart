import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RefundModel {
  String useremail;
  String reason;
  String image1;
  String image2;
  String prodid;
  String id;

  RefundModel({
    required this.useremail,
    required this.reason,
    required this.image1,
    required this.image2,
    required this.prodid,
    required this.id,
  });
}
