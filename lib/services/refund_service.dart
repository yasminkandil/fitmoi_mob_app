import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitmoi_mob_app/models/contact_us_model.dart';
import 'package:fitmoi_mob_app/models/user_model.dart';

import '../models/refund_model.dart';

class RefundsService {
  final CollectionReference _RefundsCollectionReference =
      FirebaseFirestore.instance.collection('refunds');

  Future<List<RefundModel>> getRefunds() async {
    List<RefundModel> Refunds = [];
    QuerySnapshot snapshot = await _RefundsCollectionReference.get();
    snapshot.docs.forEach((document) {
      RefundModel message = RefundModel(
        useremail: document.data().toString().contains('useremail')
            ? document.get('useremail')
            : '',
        reason: document.data().toString().contains('reason')
            ? document.get('reason')
            : '',
        image1: document.data().toString().contains('image1')
            ? document.get('image1')
            : '',
        image2: document.data().toString().contains('image2')
            ? document.get('image2')
            : '',
        prodid: document.data().toString().contains('prodId')
            ? document.get('prodId')
            : '',
        id: document.data().toString().contains('id') ? document.get('id') : '',
      );
      Refunds.add(message);
    });

    return Refunds;
  }
}
