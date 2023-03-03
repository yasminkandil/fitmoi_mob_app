import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitmoi_mob_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fitmoi_mob_app/models/checkout_model.dart';
import 'package:fitmoi_mob_app/models/order_model.dart';
import 'package:fitmoi_mob_app/widgets/header_container.dart';

import '../widgets/app_bar.dart';

class checkout extends StatefulWidget {
  final int totalPrice;
  final List<String> products;
  final Map<String, String> sizes;
  final Map<String, String> color;
  const checkout({
    super.key,
    required this.totalPrice,
    required this.products,
    required this.sizes,
    required this.color,
  });

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<checkout> {
  final formKey = GlobalKey<FormState>();

  List<bool> isCash = [true, false];

  @override
  void initState() {
    super.initState();
    getUserDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "Checkout"),
      body: email == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(bottom: 30),
                child: Column(
                  children: <Widget>[
                    HeaderContainer("Checkout"),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            _textInput(
                                type: TextInputType.text,
                                hint: "Name",
                                icon: Icons.person,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return "Username is Required";
                                  }
                                },
                                controller: nameController),
                            _textInput(
                                hint: "Phone Number",
                                type: TextInputType.phone,
                                icon: Icons.phone,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return "phone number is Required";
                                  }
                                },
                                controller: phoneController),
                            _textInput(
                                hint: "Address",
                                icon: Icons.home,
                                type: TextInputType.streetAddress,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return "Address is Required";
                                  }
                                },
                                controller: addressController),
                            SizedBox(height: 10),
                            ToggleButtons(
                              onPressed: (int index) {
                                if (index == 0) {
                                  isCash[0] = true;
                                  isCash[1] = false;
                                } else {
                                  isCash[0] = false;
                                  isCash[1] = true;
                                }
                                setState(() {});
                              },
                              isSelected: isCash,
                              children: const <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Text("Cash",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Text("Visa",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                            Visibility(
                              visible: isCash[1],
                              child: Column(
                                children: [
                                  _textInput(
                                      controller: ccnController,
                                      type: TextInputType.number,
                                      hint: "Credit Card Number",
                                      validate: isCash[1]
                                          ? (String? value) {
                                              if (value!.isEmpty) {
                                                return "Credit Card Number is Required";
                                              }
                                            }
                                          : null,
                                      icon: Icons.credit_card),
                                  _textInput(
                                      controller: expdateController,
                                      hint: "Expiry Date",
                                      type: TextInputType.datetime,
                                      validate: isCash[1]
                                          ? (String? value) {
                                              if (value!.isEmpty) {
                                                return "Expiry Date is Required";
                                              }
                                            }
                                          : null,
                                      icon: Icons.date_range,
                                      isDate: true),
                                  _textInput(
                                      controller: ccvController,
                                      hint: "CCV",
                                      type: TextInputType.number,
                                      validate: isCash[1]
                                          ? (String? value) {
                                              if (value!.isEmpty) {
                                                return "CCV is Required";
                                              }
                                            }
                                          : null,
                                      icon: Icons.credit_card_sharp),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  primary: mintColors,
                                ),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    OrderModel2 model = OrderModel2(
                                      phone: phoneController.text,
                                      name: nameController.text,
                                      address: addressController.text,
                                      totalPrice: "${widget.totalPrice}",
                                      orderBy: email,
                                      orderDate: DateTime.now()
                                          .toString()
                                          .split(" ")[0],
                                      orderNo: UniqueKey().toString(),
                                      paymentMethod:
                                          isCash[0] ? "Cash" : "Visa",
                                      products: widget.products,
                                      sizes: widget.sizes,
                                      color: widget.color,
                                    );

                                    FirebaseFirestore.instance
                                        .collection("orders")
                                        .doc()
                                        .set(model.toMap())
                                        .then((value) async {
                                      await FirebaseFirestore.instance
                                          .collection("cart")
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .delete();
                                      Fluttertoast.showToast(
                                        msg: "Order Placed SuccessFully",
                                      );
                                      Navigator.pushNamed(context, 'homepage');
                                    });
                                  }
                                },
                                child: Text('Click to place Order☑️'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  Widget _textInput(
      {controller,
      hint,
      icon,
      bool isDate = false,
      required validate,
      required TextInputType type}) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: 10),
      child: TextFormField(
        controller: controller,
        validator: validate,
        keyboardType: type,
        onTap: isDate == true
            ? () {
                showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2030, 10, 30))
                    .then((value) {
                  if (isDate == true) {
                    print(value.toString());
                    String date = value.toString().split(" ")[0];
                    controller.text = date;
                  }
                });
              }
            : null,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }

  String? email;

  void getUserDate() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        email = FirebaseAuth.instance.currentUser!.email;
      });
    });
  }
}

class _MyAppState extends State<MaterialApp> {
  bool _myBoolean = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Checkbox(
        value: _myBoolean,
        onChanged: (bool? value) {
          setState(() {
            _myBoolean = value!; // WILL rebuild
          });
        },
      ),
    );
  }
}
