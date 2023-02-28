import 'package:flutter/material.dart';

import '../../models/product_model2.dart';

const List<String> list = <String>[
  'Small',
  'Medium',
  'Large',
  'XLarge',
  'XXLarge'
];

class QuantityDropDown extends StatefulWidget {
  ProductModel2 productModel2;
  QuantityDropDown({super.key, required this.productModel2});

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
          width: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              widget.productModel2.squantity != '0'
                  ? Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            size = "S";
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: size == "S" ? Colors.black : Colors.white,
                            borderRadius: const BorderRadius.only(
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
                    )
                  : Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "S",
                          style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ),
                    ),
              widget.productModel2.mquantity != '0'
                  ? Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            size = "M";
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: size == "M" ? Colors.black : Colors.white,
                            borderRadius: const BorderRadius.only(
                                // topRight: Radius.circular(5),
                                //bottomRight: Radius.circular(5),
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
                    )
                  : Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.only(
                              //  topRight: Radius.circular(5),
                              // bottomRight: Radius.circular(5),
                              ),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "M",
                          style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ),
                    ),
              widget.productModel2.lquantity != '0'
                  ? Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            size = "L";
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: size == "L" ? Colors.black : Colors.white,
                            borderRadius: const BorderRadius.only(
                                // topRight: Radius.circular(5),
                                //bottomRight: Radius.circular(5),
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
                    )
                  : Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.only(
                              //  topRight: Radius.circular(5),
                              // bottomRight: Radius.circular(5),
                              ),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "L",
                          style: TextStyle(
                              color: Colors.white,
                              //fontWeight: FontWeight.bold,
                              decoration: TextDecoration.lineThrough),
                        ),
                      ),
                    ),
              widget.productModel2.xlquantity != '0'
                  ? Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            size = "XL";
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: size == "XL" ? Colors.black : Colors.white,
                            borderRadius: const BorderRadius.only(
                                // topRight: Radius.circular(5),
                                // bottomRight: Radius.circular(5),
                                ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "XL",
                            style: TextStyle(
                              color: size == "XL" ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.only(
                            //topRight: Radius.circular(5),
                            //bottomRight: Radius.circular(5),
                            ),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "XL",
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ),
              widget.productModel2.xxlquantity != '0'
                  ? Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            size = "XXL";
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: size == "XXL" ? Colors.black : Colors.white,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "XXL",
                            style: TextStyle(
                              color:
                                  size == "XXL" ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "XXL",
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    )
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
