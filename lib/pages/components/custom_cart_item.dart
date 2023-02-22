import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/cart_model2.dart';
//import 'package:cached_network_image/cached_network_image.dart';

class CustomCartItem extends StatefulWidget {
  CartModel2 cartModel;

  CustomCartItem(this.cartModel);

  @override
  State<CustomCartItem> createState() => _CustomCartItemState();
}

class _CustomCartItemState extends State<CustomCartItem> {
  @override
  Widget build(BuildContext context) {
    int newCount = 0;
    return Dismissible(
      onDismissed: (direction) async {
        String uid = FirebaseAuth.instance.currentUser!.uid;
        await FirebaseFirestore.instance
            .collection('cart')
            .doc(uid)
            .collection(uid)
            .doc(widget.cartModel.id)
            .delete();
      },
      key: UniqueKey(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey)),
          child: Row(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height * 0.12,
                  width: MediaQuery.of(context).size.height * 0.12,
                  child: Image.network("${widget.cartModel.image}",
                      fit: BoxFit.cover)),
              const SizedBox(
                width: 8,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.17,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      '${widget.cartModel.name}',
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'Price : ',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                        Text(
                          '${widget.cartModel.totalPrice}',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        SizedBox(width: 5),
                        Text(
                          'EGP',
                          style: TextStyle(fontSize: 17, color: Colors.black),
                        ),
                      ],
                    ),
                    //Expanded(child: Text("${cartModel.description}",maxLines: 4,overflow: TextOverflow.ellipsis,)),
                    Row(
                      children: <Widget>[
                        IconButton(
                            onPressed: (() {
                              String uid =
                                  FirebaseAuth.instance.currentUser!.uid;
                              FirebaseFirestore.instance
                                  .collection("cart")
                                  .doc(uid)
                                  .collection(uid)
                                  .doc(widget.cartModel.id)
                                  .get()
                                  .then((value) {
                                CartModel2 model =
                                    CartModel2.fromJson(value.data() ?? {});

                                if (model.count! > 1) {
                                  int countNew = model.count! - 1;
                                  int oldPrice = model.onSale == true
                                      ? model.price2!
                                      : model.price!;
                                  int newPrice = countNew * oldPrice;

                                  print(countNew);
                                  print(oldPrice);
                                  print(newPrice);

                                  FirebaseFirestore.instance
                                      .collection("cart")
                                      .doc(uid)
                                      .collection(uid)
                                      .doc(widget.cartModel.id)
                                      .update({
                                    "count": countNew,
                                    "totalPrice": newPrice
                                  });
                                }
                              });
                            }),
                            icon: Icon(Icons.remove)),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 15 / 2),
                          child: Text(
                            newCount == 0
                                ? "${widget.cartModel.count ?? 0}"
                                : "${newCount}",
                            // numofItems.toString().padLeft(2, "0"),
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        IconButton(
                            onPressed: (() {
                              String uid =
                                  FirebaseAuth.instance.currentUser!.uid;
                              FirebaseFirestore.instance
                                  .collection("cart")
                                  .doc(uid)
                                  .collection(uid)
                                  .doc(widget.cartModel.id)
                                  .get()
                                  .then((value) {
                                CartModel2 model =
                                    CartModel2.fromJson(value.data() ?? {});
                                int countNew = model.count! + 1;
                                int oldPrice = model.onSale == true
                                    ? model.price2!
                                    : model.price!;
                                int newPrice = countNew * oldPrice;

                                FirebaseFirestore.instance
                                    .collection("cart")
                                    .doc(uid)
                                    .collection(uid)
                                    .doc(widget.cartModel.id)
                                    .update({
                                  "count": countNew,
                                  "totalPrice": newPrice
                                });
                              });
                            }),
                            icon: Icon(Icons.add)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
