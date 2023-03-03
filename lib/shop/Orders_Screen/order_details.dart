import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitmoi_mob_app/pages/refund.dart';
import 'package:fitmoi_mob_app/utils/color.dart';
import 'package:fitmoi_mob_app/widgets/btn_widget.dart';
import 'package:flutter/material.dart';

import '../../widgets/app_bar.dart';

class OrdersDetails extends StatefulWidget {
  const OrdersDetails({super.key, required this.ord});
  final String ord;

  @override
  State<OrdersDetails> createState() => _OrdersDetailsState();
}

class _OrdersDetailsState extends State<OrdersDetails> {
  @override
  void initState() {
    super.initState();
    fetchProd();
  }

  Future<List<dynamic>> getProducts() async {
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance
            .collection('orders')
            .doc(widget.ord)
            .get();
    final data = documentSnapshot.data();
    if (data == null) {
      return [];
    } // Return an empty list if the document doesn't exist
    return data['products'] ??
        []; // Return the subcategory array or an empty list if it doesn't exist
  }

  var prodname;
  var prodid;
  var valuee;
  // void searchFromFirebase(String query) async {
  //   final result = await FirebaseFirestore.instance
  //       .collection('product')
  //       .where('name', isEqualTo: query)
  //       .get();
  //   setState(() {
  //     prodname = result.docs.single;
  //   });
  // }

  String capitalizeFirstLetter(String input) {
    if (input == null || input.isEmpty) {
      return input;
    }
    return input
        .split(' ')
        .map((word) => '${word[0].toUpperCase()}${word.substring(1)}')
        .join(' ');
  }

  Future<String> getProductId(String productName) async {
    final productsRef = FirebaseFirestore.instance.collection('product');
    final querySnapshot =
        await productsRef.where('name', isEqualTo: productName).get();
    if (querySnapshot.size == 1) {
      final docSnapshot = querySnapshot.docs.first;
      return docSnapshot.id;
    } else {
      throw Exception(
          'Product not found or multiple products found with the same name');
    }
  }

  List<dynamic> _prod = [];
  dynamic _selectedValuee;
  void fetchProd() async {
    _prod = await getProducts();
    if (_prod.isNotEmpty) {
      setState(() {
        _selectedValuee = _prod[0]; // Set the initial selected value
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          text: "Order Details",
        ),
        //backgroundColor: Colors.orange,
        body: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('orders')
                .doc(widget.ord)
                .get(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data = snapshot.data?.data() != null
                    ? snapshot.data!.data()! as Map<String, dynamic>
                    : <String, dynamic>{};
                var list = data['products'].toList();
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    child: Center(
                      child: ListView(
                        children: [
                          Text("Email: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: mintColors,
                                  fontSize: 18,
                                  height: 2)),
                          Text("${data['orderBy']} ",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  height: 2)),
                          Text("Date:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: mintColors,
                                  fontSize: 18,
                                  height: 2)),
                          Text("${data['orderDate']}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  height: 2)),
                          Text("Order Status:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                height: 2,
                                color: mintColors,
                              )),
                          Text(" ${data['orderStatus']}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  height: 2)),
                          Text(
                            "Product Name:",
                            style: TextStyle(
                                color: mintColors,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                height: 2),
                          ),
                          Text(
                            data['products']
                                .toString()
                                .replaceAll("[", "")
                                .replaceAll("]", ""),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                height: 2),
                          ),
                          Text("Colors:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                height: 2,
                                color: mintColors,
                              )),
                          Text(
                            data['color']
                                .toString()
                                .replaceAll("[", "")
                                .replaceAll("]", "")
                                .replaceAll("{", "")
                                .replaceAll("}", ""),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                height: 2),
                          ),
                          Text("Sizes:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                height: 2,
                                color: mintColors,
                              )),
                          Text(
                            data['sizes']
                                .toString()
                                .replaceAll("[", "")
                                .replaceAll("]", "")
                                .replaceAll("{", "")
                                .replaceAll("}", ""),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                height: 2),
                          ),
                          Text("Total Paid:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                height: 2,
                                color: mintColors,
                              )),
                          Text("${data['totalPrice']} " + " EGP",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  height: 2)),
                          Text("Payment Method:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                height: 2,
                                color: mintColors,
                              )),
                          Text("${data['paymentMethod']}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  height: 2)),
                          data['orderStatus'] == "Delivered"
                              ? DropdownButtonFormField(
                                  value: _selectedValuee,
                                  onChanged: (dynamic newValue) async {
                                    setState(() {
                                      _selectedValuee = newValue;

                                      print(newValue);
                                      // valuee = capitalizeFirstLetter(newValue);
                                      // prodid = prodname['id'].toString();
                                    });
                                    prodid =
                                        await getProductId(_selectedValuee);
                                  },
                                  items: _prod.map<DropdownMenuItem<dynamic>>(
                                      (dynamic value) {
                                    return DropdownMenuItem<dynamic>(
                                      value: value,
                                      child: Text(value.toString()),
                                    );
                                  }).toList(),
                                  icon: const Icon(
                                    Icons.arrow_drop_down_circle,
                                    color: Color.fromARGB(255, 10, 169, 159),
                                  ),
                                  dropdownColor:
                                      Color.fromARGB(255, 10, 169, 159),
                                  decoration: const InputDecoration(
                                      labelText: "Choose product to return",
                                      prefixIcon: Icon(
                                        Icons.category,
                                        color:
                                            Color.fromARGB(255, 10, 169, 159),
                                      ),
                                      border: UnderlineInputBorder()),
                                )
                              : Container(),
                          data['orderStatus'] == "Delivered"
                              ? ButtonWidget(
                                  btnText: "Return",
                                  onClick: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Refund(
                                          prodid: prodid,
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return const Text("Loading...");
            })));
  }
}
