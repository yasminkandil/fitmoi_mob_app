import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

uploadImagee(String imageName) async {
  final picker = ImagePicker();
  final pickedFile = await picker.getImage(source: ImageSource.gallery);

  final File imageFile = File(pickedFile!.path);
  final Reference storageReference =
      FirebaseStorage.instance.ref().child(imageName);
  final UploadTask uploadTask = storageReference.putFile(
    imageFile,
    SettableMetadata(
      contentType: 'image/jpeg',
    ),
  );
  final TaskSnapshot taskSnapshot = await uploadTask;
  final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
  return downloadUrl;
}
