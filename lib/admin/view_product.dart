import 'package:fitmoi_mob_app/admin/add_product.dart';
import 'package:fitmoi_mob_app/admin/editProdPage.dart';
import 'package:fitmoi_mob_app/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../provider/product_provider.dart';
import '../utils/color.dart';
import 'edit_product.dart';

class ViewProductPage extends ConsumerWidget {
  const ViewProductPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: GreyColors,
          title: const Text("Products List"),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: mintColors,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          actions: [
            IconButton(
              onPressed: () {
                // method to show the search bar
                //context: context, delegate:
                // Navigator.pushNamed(context, 'search_users');
              },
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        body: SafeArea(
          child: Consumer(
            builder: (context, watch, _) {
              final products = ref.watch(productsProvider);
              return products.when(
                data: (value) {
                  return ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      ProductModel product = value[index];
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 110,
                                  height: 120,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2, color: Colors.white),
                                      boxShadow: [
                                        BoxShadow(
                                            spreadRadius: 2,
                                            blurRadius: 10,
                                            color:
                                                Colors.black.withOpacity(0.1))
                                      ],
                                      shape: BoxShape.rectangle,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(product.image))),
                                ),
                                Column(
                                  children: [
                                    Text(
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: mintColors),
                                        product.name),
                                    const SizedBox(
                                      height: 10,
                                      width: 10,
                                    ),
                                    Text(product.description),
                                    const SizedBox(
                                      height: 10,
                                      width: 10,
                                    ),
                                    Text("Price: ${product.price}"),
                                    const SizedBox(
                                      height: 10,
                                      width: 10,
                                    ),
                                    Text("Quantity: ${product.quantity}"),
                                    const SizedBox(
                                      height: 10,
                                      width: 10,
                                    ),
                                    Text(
                                        "Color: ${product.colors.toString().replaceAll("[", "").replaceAll("]", "")}"),
                                    Text(
                                        "Size: ${product.size.toString().replaceAll("[", "").replaceAll("]", "")}"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: InkWell(
                              child: RichText(
                                text: TextSpan(children: [
                                  const TextSpan(
                                      text: "To Edit this product click ",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15)),
                                  TextSpan(
                                      text: "here",
                                      style: TextStyle(
                                          color: mintColors, fontSize: 15)),
                                ]),
                              ),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        EditProd(prodd: product.id)));
                                Fluttertoast.showToast(
                                    msg: product.id,
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.grey,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              },
                            ),
                          ),
                          Divider(
                            color: mintColors,
                            height: 10,
                            thickness: 3,
                            indent: 25,
                            endIndent: 25,
                          )
                        ],
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => Text(error.toString()),
              );
            },
          ),
        ),
      ),
    );
  }
}
