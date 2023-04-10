import 'package:fitmoi_mob_app/admin/add_offer.dart';
import 'package:fitmoi_mob_app/admin/editProdPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/category_model.dart';
import '../provider/category_provider.dart';
import '../utils/color.dart';
import 'edit_category.dart';

class ViewCategoriesPage extends ConsumerWidget {
  const ViewCategoriesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: GreyColors,
          title: const Text("Categories List"),
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
              final Categoriess = ref.watch(categoriesProvider);
              return Categoriess.when(
                data: (value) {
                  return ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      CategoryModel Categories = value[index];
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
                                          image:
                                              NetworkImage(Categories.image))),
                                ),
                                Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: mintColors),
                                          Categories.name),
                                      const SizedBox(
                                        height: 10,
                                        width: 10,
                                      ),
                                      Text(
                                        "SubCategories: ",
                                        style: TextStyle(color: mintColors),
                                      ),
                                      Text(
                                          "${Categories.subcategory.toString().replaceAll("[", "").replaceAll("]", "")}"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: InkWell(
                              child: RichText(
                                text: TextSpan(children: [
                                  const TextSpan(
                                      text: "To Edit this Categories click ",
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
                                    builder: (context) => EditCateg(
                                          id: Categories.id,
                                          subcategory: Categories.subcategory,
                                          name: Categories.name,
                                        )));
                                Fluttertoast.showToast(
                                  msg: Categories.id,
                                  // toastLength: Toast.LENGTH_SHORT,
                                  // gravity: ToastGravity.BOTTOM,
                                  // timeInSecForIosWeb: 1,
                                  // backgroundColor: Colors.grey,
                                  // textColor: Colors.white,
                                  // fontSize: 16.0
                                );
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
