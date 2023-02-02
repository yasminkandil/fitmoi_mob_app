import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DropdownPage extends StatefulWidget {
  @override
  _DropdownPageState createState() => _DropdownPageState();
}

class _DropdownPageState extends State<DropdownPage> {
  final _firestore = FirebaseFirestore.instance;
  List<String> _dropdownValues = [];
  late String _selectedValue;

  @override
  void initState() {
    super.initState();
    _getDropdownValues();
  }

  void _getDropdownValues() async {
    final snapshot = await _firestore.collection("collection_name").get();
    setState(() {
      _dropdownValues =
          snapshot.docs.map((doc) => doc.data()['field_name']).toList().cast();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dropdown Example"),
      ),
      body: Column(
        children: [
          DropdownButtonFormField(
            value: _selectedValue,
            items: _dropdownValues.map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedValue = value!;
              });
            },
          ),
          ElevatedButton(
            onPressed: () {
              print("Selected value: $_selectedValue");
            },
            child: Text("Get Selected Value"),
          ),
        ],
      ),
    );
  }
}
