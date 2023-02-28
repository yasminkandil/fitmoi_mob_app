import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitmoi_mob_app/shop/details/components/colors.dart';
import 'package:fitmoi_mob_app/utils/color.dart';
import 'package:flutter/material.dart';

import '../../../models/product_model2.dart';
import '../quantityinfo.dart';

class productinfo extends StatefulWidget {
  ProductModel2 productModel2;

  productinfo(this.productModel2);

  @override
  State<productinfo> createState() => _productinfoState();
}

class _productinfoState extends State<productinfo> {
  @override
  Widget build(BuildContext context) {
    var count = widget.productModel2.quantity;
    //String dropdownValue = list.first;

    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: widget.productModel2.quantity != "0"
                ? RichText(
                    text: TextSpan(
                        style: TextStyle(color: Color.fromARGB(225, 0, 0, 0)),
                        children: [
                          // TextSpan(text: "Capacity\n"),
                          TextSpan(
                              text: "In Stock",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: GreyLightColors))
                        ]),
                  )
                : RichText(
                    text: TextSpan(
                        style: TextStyle(color: Color.fromARGB(225, 0, 0, 0)),
                        children: [
                          // TextSpan(text: "Capacity\n"),
                          TextSpan(
                              text: "Out of stock",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red))
                        ]),
                  ),
          ),
          ColorsInfo(),
          QuantityDropDown(productModel2: widget.productModel2),
        ],
      ),
    );
  }
}
