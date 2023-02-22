import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitmoi_mob_app/models/user_model.dart';

class UserService {
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection('users');

  Future<List<UserModel>> getUsers() async {
    List<UserModel> users = [];
    QuerySnapshot snapshot = await _usersCollectionReference.get();
    snapshot.docs.forEach((document) {
      UserModel user = UserModel(
        firstname: document.data().toString().contains('firstname')
            ? document.get('firstname')
            : '',
        lastname: document.data().toString().contains('lastname')
            ? document.get('lastname')
            : '',
        email: document.data().toString().contains('email')
            ? document.get('email')
            : '',
        address: document.data().toString().contains('address')
            ? document.get('address')
            : '',
        mobile: document.data().toString().contains('mobile')
            ? document.get('mobile')
            : '',
        userImage: document.data().toString().contains('image')
            ? document.get('image')
            : '',
        userImageSide: document.data().toString().contains('imageS')
            ? document.get('imageS')
            : '',
        userImageFront: document.data().toString().contains('imageF')
            ? document.get('imageF')
            : '',
        userImageBack: document.data().toString().contains('imageB')
            ? document.get('imageB')
            : '',
        height: document.data().toString().contains('height')
            ? document.get('height')
            : '',
        weight: document.data().toString().contains('weight')
            ? document.get('weight')
            : '',
        gender: document.data().toString().contains('gender')
            ? document.get('gender')
            : '',
        hip: document.data().toString().contains('hip')
            ? document.get('hip')
            : '',
        back: document.data().toString().contains('back')
            ? document.get('back')
            : '',
        chest: document.data().toString().contains('chest')
            ? document.get('chest')
            : '',
      );
      users.add(user);
    });

    return users;
  }
}
