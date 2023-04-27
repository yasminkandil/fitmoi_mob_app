import 'dart:convert';
import 'dart:io' as Io;
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitmoi_mob_app/models/measurments.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

Future<Map<String, String>> sendRequest(
    {required String id,
    required File frontImage,
    required File backImage,
    required String clothType,
    required String prodId}) async {
  final url = Uri.parse('http://192.168.1.3:8050/tryy');

  final f_imgdata = await frontImage.readAsBytes();
  final b_imgdata = await backImage.readAsBytes();
  final frontPath = base64Encode(f_imgdata);
  final backPath = base64Encode(b_imgdata);

  final body = jsonEncode({
    'id': id,
    'frontPath': frontPath,
    'backPath': backPath,
    'clothType': clothType,
  });

  final response = await http.post(
    url,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    },
    body: body,
  );

  if (response.statusCode != 200) {
    throw Exception('Request failed with status: ${response.statusCode}.');
  }

  if (!response.headers['content-type']!.startsWith('application/json')) {
    throw Exception('Response is not JSON.');
  }

  final data = jsonDecode(response.body);

  // Add the output image to Firebase Storage
  final _storage = FirebaseStorage.instance;

  final storageRef =
      FirebaseStorage.instance.ref().child('images/${data['base']}');
  final imageBytes = data['base'];
  //final uploadTask = storageRef.putData(imageBytes);
  //await uploadTask.whenComplete(() => null);
  var snapshot =
      await _storage.ref().child('images/${data['base']}').putFile(imageBytes);

  var downloadUrl = await snapshot.ref.getDownloadURL();

  // Update the 'texture' field in the 'products' table in Firebase Realtime Database
  await FirebaseFirestore.instance.collection('product').doc(prodId).update({
    'texture': downloadUrl,
  });

  return {
    'base': data['base'],
    'status': data['Status'],
  };
}
