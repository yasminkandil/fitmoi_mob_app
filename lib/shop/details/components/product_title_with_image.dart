import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../models/product_model2.dart';

class ProductTitleWithImage extends StatelessWidget {
  ProductModel2 productModel2;

  ProductTitleWithImage(this.productModel2);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "${productModel2.name}",
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              children: <Widget>[
                productModel2.onSale == true
                    ? RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: "Price\n", style: TextStyle(fontSize: 22)),
                          TextSpan(
                              text: "on sale\n",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 26, 250, 1),
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: "${productModel2.price} LE \n\n",
                              style: TextStyle(
                                  color: Colors.red,
                                  decoration: TextDecoration.lineThrough)),
                          TextSpan(
                              text: "${productModel2.price2} LE ",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                        ]),
                      )
                    : RichText(
                        text: TextSpan(children: [
                          TextSpan(text: "Price\n"),
                          TextSpan(
                              text: "${productModel2.price} LE",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                        ]),
                      ),
                SizedBox(
                  width: 3,
                ),
                Expanded(
                    child: CarouselSlider(
                  options: CarouselOptions(
                    height: 200.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 2.0,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                  ),
                  items: [productModel2.image, productModel2.image2].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                              color: Colors.amber.withOpacity(0.0)),
                          child: Image.network(
                            "${i} ",
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  }).toList(),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
