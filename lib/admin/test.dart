import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

// Retrieve subcategories from a specific document in Firestore
Future<List<dynamic>> getSubcategories() async {
  final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
      await FirebaseFirestore.instance
          .collection('category')
          .doc('ypF4q51E7j7zVBlvFoYx')
          .get();
  final data = documentSnapshot.data();
  if (data == null) {
    return [];
  } // Return an empty list if the document doesn't exist
  return data['subcategory'] ??
      []; // Return the subcategory array or an empty list if it doesn't exist
}

// Usage example
class MyDropDownButton extends StatefulWidget {
  @override
  _MyDropDownButtonState createState() => _MyDropDownButtonState();
}

class _MyDropDownButtonState extends State<MyDropDownButton> {
  List<dynamic> _subcategories = [];
  dynamic _selectedValue;

  @override
  void initState() {
    super.initState();
    fetchSubcategories();
  }

  void fetchSubcategories() async {
    _subcategories = await getSubcategories();
    if (_subcategories.isNotEmpty) {
      setState(() {
        _selectedValue = _subcategories[0]; // Set the initial selected value
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<dynamic>(
      value: _selectedValue,
      onChanged: (dynamic newValue) {
        setState(() {
          _selectedValue = newValue;
        });
      },
      items: _subcategories.map<DropdownMenuItem<dynamic>>((dynamic value) {
        return DropdownMenuItem<dynamic>(
          value: value,
          child: Text(value.toString()),
        );
      }).toList(),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('My App'),
        ),
        body: Center(
          child: MyDropDownButton(),
        ),
      ),
    );
  }
}
