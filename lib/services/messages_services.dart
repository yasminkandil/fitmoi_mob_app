import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitmoi_mob_app/models/contact_us_model.dart';
import 'package:fitmoi_mob_app/models/user_model.dart';

class MessagesService {
  final CollectionReference _messagesCollectionReference =
      FirebaseFirestore.instance.collection('contact_us');

  Future<List<ContactUsModel>> getmessages() async {
    List<ContactUsModel> messages = [];
    QuerySnapshot snapshot = await _messagesCollectionReference.get();
    snapshot.docs.forEach((document) {
      ContactUsModel message = ContactUsModel(
        email: document.data().toString().contains('email')
            ? document.get('email')
            : '',
        message: document.data().toString().contains('message')
            ? document.get('message')
            : '',
      );
      messages.add(message);
    });

    return messages;
  }
}
