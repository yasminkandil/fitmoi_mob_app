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
    'https://media.tarkett-image.com/large/TH_24567080_24594080_24596080_24601080_24563080_24565080_24588080_001.jpg';
var sideimage = 'https://en.pimg.jp/062/964/876/1/62964876.jpg';
var frontimage =
    'https://thumbs.dreamstime.com/b/front-view-woman-body-silhouette-front-view-human-body-silhouette-adult-female-174553835.jpg';
var backimage =
    'https://thumbs.dreamstime.com/b/front-view-woman-body-silhouette-front-view-human-body-silhouette-adult-female-174553835.jpg';

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
  double height;
  double weight;
  String gender;
  double hip;
  double chest;
  double back;

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
    required this.height,
    required this.weight,
    required this.gender,
    required this.hip,
    required this.chest,
    required this.back,
  });
}

class UsersData {
  Future<Object> getUsers() async {
    final DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection('users').doc().get();
    return documentSnapshot;
  }
}
