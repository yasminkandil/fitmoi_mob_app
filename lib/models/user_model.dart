import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String fnameerrormssg = "Enter First Name";
String lnameerrormssg = "Enter Last Name";
String emailerrormssg = "Enter Email Correctly";
String addrerrormssg = "Enter Address";
String mobileerrormssg = "Enter Mobile Number Correctly";
String heighterrormssg = "Enter Height Correctly";
String weighterrormssg = "Enter Weight Correctly";
String eregexp =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
String aregexp = r'^[a-z A-Z]+$';
String mregexp = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]+$';
var imagee;
setImage(String imagee) {
  imagee = imagee;
}

getImage() {
  return imagee;
}

Future addUserDetails(
    String firstname,
    String lastname,
    String userEmail,
    String useraddress,
    String userPhoneNumber,
    String userImageSide,
    String userImageFront,
    String userImageBack,
    String userImage,
    String height,
    String weight,
    String gender,
    String id) async {
  await FirebaseFirestore.instance.collection('users').doc(id).set(
    {
      'firstname': firstname,
      'lastname': lastname,
      'email': userEmail,
      'mobile': userPhoneNumber,
      'address': useraddress,
      'image': userImage,
      'imageS': userImageSide,
      'imageF': userImageFront,
      'imageB': userImageBack,
      'height': height,
      'weight': weight,
      'gender': gender,
      'id': id,
    },
  );

  print('NEW USER REGISTERED WITH ID:');
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController fisrtController = TextEditingController();
TextEditingController lastController = TextEditingController();
TextEditingController confirmPassController = TextEditingController();
TextEditingController mobileController = TextEditingController();
TextEditingController addrController = TextEditingController();
TextEditingController heightController = TextEditingController();
TextEditingController weightController = TextEditingController();

enum Gender { male, female }

var imageUrl;
var downloadUrl;
var greyimage =
    'https://www.google.com/search?q=profile+photo+&tbm=isch&ved=2ahUKEwis27rOz_76AhVFexoKHU2PBGoQ2-cCegQIABAA&oq=profile+photo+&gs_lcp=CgNpbWcQAzIECAAQQzIFCAAQgAQyBQgAEIAEMgUIABCABDIFCAAQgAQyBQgAEIAEMgUIABCABDIFCAAQgAQyBQgAEIAEMgUIABCABDoGCAAQBxAeULwEWLwEYKoIaABwAHgAgAGZAYgBkwKSAQMwLjKYAQCgAQGqAQtnd3Mtd2l6LWltZ8ABAQ&sclient=img&ei=d4lZY-zDCsX2ac2ektAG&bih=657&biw=1366#imgrc=nfkyptoYx2OzJM';
var sideimage = 'assets/side.jpeg';
var frontimage = 'assets/front.jpeg';
var backimage = 'assets/back.jpeg';

class UserModel {
  String firstname;
  String lastname;
  String email;
  String address;
  String mobile;
  String userImage;
  String userImageSide;
  String userImageFront;
  String userImageBack;

  UserModel({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.address,
    required this.mobile,
    required this.userImage,
    required this.userImageSide,
    required this.userImageFront,
    required this.userImageBack,
  });
}

class UsersData {
  Future<Object> getUsers() async {
    final DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection('users').doc().get();
    return documentSnapshot;
  }
}
