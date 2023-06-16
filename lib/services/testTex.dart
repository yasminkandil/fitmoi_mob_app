import 'dart:convert';
import 'dart:io' as Io;
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitmoi_mob_app/models/measurments.dart';
import 'package:fitmoi_mob_app/pages/view_account.dart';
import 'package:fitmoi_mob_app/services/fileservices.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

Future<Map<String, String>> sendRequest({
  required String id,
  required File frontImage,
  required File backImage,
  required String clothType,
  required String prodId,
}) async {
  final url = Uri.parse('http://192.168.100.130:8050/tryy');

  final f_imgdata = await frontImage.readAsBytes();
  final b_imgdata = await backImage.readAsBytes();
  final frontPath = base64Encode(f_imgdata);
  final backPath = base64Encode(b_imgdata);
  // final prodId = base64Encode(b_imgdata);

  final body = jsonEncode({
    'id': id,
    'frontPath': frontPath,
    'backPath': backPath,
    'clothType': clothType,
    'prodId': prodId
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

  var image64 = data["base"];
  Uint8List bytes = base64.decode(image64);
  FileService fileService3 = FileService(path: 'up$prodId.jpg');
  File file = await fileService3.writeImage(bytes);

  final snapshot =
      await _storage.ref().child('textures/up$prodId.jpg').putFile(file);

  var downloadUrl = await snapshot.ref.getDownloadURL();

  // Update the 'texture' field in the 'products' table in Firebase Realtime Database
  await FirebaseFirestore.instance.collection('product').doc(prodId).update({
    'texture': downloadUrl,
  });

// Update the 'texture' field in the 'products' table in Firebase Realtime Database
  await FirebaseFirestore.instance.collection('product').doc(prodId).update({
    'texture': downloadUrl,
  });
  return {
    'base': jsonDecode(response.body)['base'],
    'Status': jsonDecode(response.body)['Status'],
  };
}

Future<void> renameAssetFile(String oldName, String newName) async {
  // Get the app's document directory
  Directory appDocDir = await getApplicationDocumentsDirectory();
  newName = userId;
  // Construct the paths to the old and new files in the assets directory
  String oldPath = 'assets/$oldName';
  String newPath = 'assets/$newName';

  // Load the old file contents into memory
  ByteData oldData = await rootBundle.load(oldPath);
  List<int> bytes = oldData.buffer.asUint8List();

  // Write the old file contents to the new location with the new name
  File newFile = File(newPath);
  await newFile.writeAsBytes(bytes);

  // Delete the old file
  await deleteAssetFile(oldName);
}

Future<void> deleteAssetFile(String name) async {
  // Get the app's document directory
  Directory appDocDir = await getApplicationDocumentsDirectory();

  // Construct the path to the file in the assets directory
  String path = '${appDocDir.path}/$name';

  // Delete the file
  File file = File(path);
  await file.delete();
}
