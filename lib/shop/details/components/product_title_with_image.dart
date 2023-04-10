import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitmoi_mob_app/shop/details/components/generate_model.dart';
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TryyOn(),
                SizedBox(
                  width: 10,
                ),
                Center(
                  child: Text(
                    "${productModel2.name}",
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: <Widget>[
                const SizedBox(
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
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                  ),
                  items: [productModel2.image, productModel2.image2].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                              color: Colors.amber.withOpacity(0.0)),
                          child: GestureDetector(
                            child: Image.network(
                              "${i} ",
                              fit: BoxFit.cover,
                            ),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return Scaffold(
                                  body: GestureDetector(
                                    child: Center(
                                      child: Hero(
                                        tag: 'image',
                                        child: Image.network(
                                          "${i} ",
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                );
                              }));
                            },
                          ),
                        );
                      },
                    );
                  }).toList(),
                ))
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            productModel2.onSale == true
                ? Row(
                    children: [
                      RichText(
                        text: TextSpan(children: [
                          const TextSpan(
                              text: "on sale\n",
                              style: TextStyle(
                                  color: Colors.white,
                                  backgroundColor:
                                      Color.fromARGB(255, 238, 121, 11),
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                            text: "${productModel2.price2} LE ",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24),
                          ),
                          TextSpan(
                              text: "${productModel2.price} LE \n ",
                              style: const TextStyle(
                                  color: Colors.red,
                                  decoration: TextDecoration.lineThrough)),
                        ]),
                      ),
                    ],
                  )
                : RichText(
                    text: TextSpan(children: [
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
          ],
        ),
      ),
    );
  }
}
