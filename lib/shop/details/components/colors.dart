import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitmoi_mob_app/utils/color.dart';
import 'package:flutter/material.dart';

import '../../../models/product_model2.dart';

const List<String> list = <String>[
  'Black',
];
String chosenColor = '';

class ColorsInfo extends StatefulWidget {
  ProductModel2 prodId;
  ColorsInfo({super.key, required this.prodId});

  @override
  State<ColorsInfo> createState() => _ColorsInfoState();
}

class _ColorsInfoState extends State<ColorsInfo> {
  //String dropdownValue = list.first;
  @override
  void initState() {
    super.initState();
    fetchColors();
  }

  Future<List<dynamic>> getColors() async {
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance
            .collection('product')
            .doc(widget.prodId.id)
            .get();
    final data = documentSnapshot.data();
    if (data == null) {
      return [];
    } // Return an empty list if the document doesn't exist
    return data['color'] ??
        []; // Return the subcategory array or an empty list if it doesn't exist
  }

  List<dynamic> _colors = [];
  dynamic _selectedValuee;
  void fetchColors() async {
    _colors = await getColors();
    if (_colors.isNotEmpty) {
      setState(() {
        _selectedValuee = _colors[0]; // Set the initial selected value
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 40,
        child: DropdownButton<dynamic>(
          value: _selectedValuee,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: TextStyle(color: GreyLightColors, fontWeight: FontWeight.bold),
          underline: Container(
            height: 2,
            // color: Colors.deepPurpleAccent,
          ),
          onChanged: (dynamic value) {
            // This is called when the user selects an item.
            setState(() {
              _selectedValuee = value;
              chosenColor = value;
            });
          },
          items: _colors.map<DropdownMenuItem<dynamic>>((dynamic value) {
            return DropdownMenuItem<dynamic>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
