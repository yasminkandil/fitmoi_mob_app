import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitmoi_mob_app/shop/details/components/add_review.dart';
import 'package:fitmoi_mob_app/shop/details/components/description.dart';
import 'package:fitmoi_mob_app/shop/details/components/product_info.dart';
import 'package:fitmoi_mob_app/shop/details/components/product_title_with_image.dart';
import 'package:fitmoi_mob_app/shop/details/components/review_product.dart';
import 'package:fitmoi_mob_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../models/cart_model2.dart';
import '../../../models/product_model2.dart';

class Body extends StatefulWidget {
  final String prod;

  const Body({super.key, required this.prod});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _isFavorited = true;
  int _favoriteCount = 41;
  int numofItems = 1;

  @override
  void initState() {
    super.initState();
    getProducatInfo();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: productModel2 == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: <Widget>[
                SizedBox(
                  height: size.height,
                  child: Stack(children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: size.height * 0.3),
                      padding: EdgeInsets.only(
                          top: size.height * 0.12, left: 10, right: 10),
                      height: 500,
                      decoration: BoxDecoration(
                          color: mintColors,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24))),
                      child: Column(
                        children: <Widget>[
                          productinfo(productModel2!),
                          description(productModel2!),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  IconButton(
                                      onPressed: (() {
                                        if (numofItems > 1) {
                                          setState(() {
                                            numofItems--;
                                          });
                                        }
                                      }),
                                      icon: Icon(Icons.remove)),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15 / 2),
                                    child: Text(
                                      numofItems.toString().padLeft(2, "0"),
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: (() {
                                        setState(() {
                                          numofItems++;
                                        });
                                      }),
                                      icon: Icon(Icons.add)),
                                ],
                              ),
                              Container(
                                height: 32,
                                width: 32,
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (_isFavorited) {
                                        _favoriteCount -= 1;
                                        _isFavorited = false;
                                      } else {
                                        _favoriteCount += 1;
                                        _isFavorited = true;
                                      }
                                    });
                                  },
                                  icon: (_isFavorited
                                      ? Icon(Icons.favorite)
                                      : Icon(Icons.favorite_border)),
                                  color: Colors.red[500],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                    child: const Text(
                                        style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 6, 6, 6)),
                                        "View Reviews"),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Review(
                                                    ratee:
                                                        widget.prod.toString(),
                                                  )));
                                    }),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      height: 50,
                                      width: 58,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          border: Border.all(
                                              color: GreyLightColors)),
                                      // child: IconButton(
                                      //   icon: Icon(
                                      //     Icons.add_shopping_cart_outlined,
                                      //   ),
                                      //   onPressed: () => Navigator.push(
                                      //       context,
                                      //       MaterialPageRoute(
                                      //           builder: (context) =>
                                      //               CartItem())),
                                      // ),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                          height: 38,
                                          child: FloatingActionButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18)),
                                            backgroundColor: GreyLightColors,
                                            onPressed: () async {
                                              CartModel2 cartModel = CartModel2(
                                                description:
                                                    productModel2!.description,
                                                id: productModel2!.id,
                                                name: productModel2!.name,
                                                image: productModel2!.image,
                                                onSale: productModel2!.onSale,
                                                price: int.parse(
                                                    "${productModel2!.price}"),
                                                price2: int.parse(
                                                    "${productModel2!.price2}"),
                                                totalPrice: productModel2!
                                                            .onSale ==
                                                        true
                                                    ? numofItems *
                                                        int.parse(productModel2!
                                                                .price2 ??
                                                            "")
                                                    : numofItems *
                                                        int.parse(productModel2!
                                                                .price ??
                                                            ""),
                                                count: numofItems,
                                              );
                                              if (FirebaseAuth
                                                      .instance.currentUser !=
                                                  null) {
                                                List<CartModel2> list = [];
                                                FirebaseFirestore.instance
                                                    .collection("cart")
                                                    .doc(FirebaseAuth.instance
                                                        .currentUser!.uid)
                                                    .collection(FirebaseAuth
                                                        .instance
                                                        .currentUser!
                                                        .uid)
                                                    .get()
                                                    .then((value) {
                                                  list.clear();
                                                  value.docs.forEach((element) {
                                                    list.add(
                                                        CartModel2.fromJson(
                                                            element.data()));
                                                  });
                                                  var contain = list.where(
                                                      (element) =>
                                                          element.name ==
                                                          productModel2!.name);
                                                  if (contain.isEmpty) {
                                                    FirebaseFirestore.instance
                                                        .collection("cart")
                                                        .doc(FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .uid)
                                                        .collection(FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .uid)
                                                        .add(cartModel.toMap())
                                                        .then((val) {
                                                      FirebaseFirestore.instance
                                                          .collection("cart")
                                                          .doc(FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .uid)
                                                          .collection(
                                                              FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid)
                                                          .doc(val.id)
                                                          .update(
                                                              {"id": val.id});
                                                    }).then((value) {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "Product added to cart sucessfully ✔️",
                                                          backgroundColor:
                                                              GreyLightColors);
                                                    });
                                                  } else {
                                                    int oldPrice = contain
                                                        .first.totalPrice!;
                                                    int oldCount =
                                                        contain.first.count!;
                                                    int newPrice = oldPrice +
                                                        numofItems *
                                                            int.parse(
                                                                productModel2!
                                                                        .price ??
                                                                    "");
                                                    int newCount =
                                                        oldCount + numofItems;

                                                    String uid = FirebaseAuth
                                                        .instance
                                                        .currentUser!
                                                        .uid;
                                                    FirebaseFirestore.instance
                                                        .collection("cart")
                                                        .doc(uid)
                                                        .collection(uid)
                                                        .doc(contain.first.id)
                                                        .update({
                                                      "count": newCount,
                                                      "totalPrice": newPrice,
                                                    }).then((value) {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "Product added to cart sucessfully ✔️",
                                                          backgroundColor:
                                                              GreyLightColors);
                                                    });
                                                  }
                                                });
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Please Sign-In first.",
                                                    backgroundColor:
                                                        GreyLightColors);
                                                Navigator.pushNamed(
                                                    context, 'login');
                                              }
                                            },
                                            child: Text("Add to cart",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                          )),
                                    ),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: GreyLightColors,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18))),
                                        onPressed: () {
                                          if (FirebaseAuth
                                                  .instance.currentUser ==
                                              null) {
                                            Navigator.pushNamed(
                                                context, 'must_have_account');
                                          } else {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AddReview(
                                                          ratee: widget.prod
                                                              .toString(),
                                                        )));
                                          }
                                        },
                                        child: Text(
                                          "Add Review",
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    ProductTitleWithImage(productModel2!)
                  ]),
                )
              ],
            ),
    );
  }

  ProductModel2? productModel2;

  void getProducatInfo() {
    FirebaseFirestore.instance
        .collection("product")
        .doc(widget.prod)
        .get()
        .then((value) {
      setState(() {
        productModel2 = ProductModel2.fromJson(value.data() ?? {});
      });
    });
  }
}
