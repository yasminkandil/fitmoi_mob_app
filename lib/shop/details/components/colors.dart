import 'package:fitmoi_mob_app/utils/color.dart';
import 'package:flutter/material.dart';

const List<String> list = <String>[
  'Black',
];

class ColorsInfo extends StatefulWidget {
  const ColorsInfo({super.key});

  @override
  State<ColorsInfo> createState() => _ColorsInfoState();
}

class _ColorsInfoState extends State<ColorsInfo> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 40,
        child: DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: TextStyle(color: GreyLightColors),
          underline: Container(
            height: 2,
            // color: Colors.deepPurpleAccent,
          ),
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              dropdownValue = value!;
            });
          },
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
