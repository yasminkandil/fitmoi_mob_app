import 'package:flutter/material.dart';

const List<String> list = <String>[
  'Small',
  'Medium',
  'Large',
  'XLarge',
  'XXLarge'
];

class QuantityDropDown extends StatefulWidget {
  const QuantityDropDown({super.key});

  @override
  State<QuantityDropDown> createState() => _QuantityDropDownState();
}

class _QuantityDropDownState extends State<QuantityDropDown> {
  var size;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Container(
          height: 50,
          width: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      size = "S";
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: size == "S" ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "S",
                      style: TextStyle(
                        color: size == "S" ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      size = "M";
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: size == "M" ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "M",
                      style: TextStyle(
                        color: size == "M" ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      size = "L";
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: size == "L" ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "L",
                      style: TextStyle(
                        color: size == "L" ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Quantity extends StatefulWidget {
  const Quantity({super.key});

  @override
  State<Quantity> createState() => _QuantityState();
}

class _QuantityState extends State<Quantity> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 80,
        child: DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: const TextStyle(color: Colors.black),
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
