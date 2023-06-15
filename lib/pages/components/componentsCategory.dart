import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitmoi_mob_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:fitmoi_mob_app/pages/contact_us.dart';
import 'package:fitmoi_mob_app/pages/products_all.dart';
//import 'package:fitmoi_mob_app/product_powerbank.dart';

import '../../home/home_page.dart';

String chosenCateg = 't-shirt';

class Categorie extends StatefulWidget {
  String cat;
  Categorie({
    super.key,
    required this.cat,
  });

  @override
  State<Categorie> createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {
  List<String> prod = [];

  Future getDocProdF() async {
    await FirebaseFirestore.instance.collection('subcategoryF').get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            print(document.reference);
            prod.add(document.reference.id);
          }),
        );
  }

  //List<String> prodM = [];
  Future getDocProdM() async {
    await FirebaseFirestore.instance.collection('subcategoryM').get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            print(document.reference);
            prod.add(document.reference.id);
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.cat == 'female' ? getDocProdF() : getDocProdM(),
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: SizedBox(
              height: 30,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: prod.length,
                itemBuilder: (context, indexx) => buildCategory(
                  category: prod[indexx],
                  index: indexx,
                  cat: widget.cat,
                ),
              ),
            ),
            //Container(child: MyHomePage()),
          );
        });
  }
}

class buildCategory extends StatelessWidget {
  final String category;
  final int index;
  final String cat;
  const buildCategory(
      {super.key,
      required this.category,
      required this.index,
      required this.cat});

  @override
  Widget build(BuildContext context) {
    List arkam = [index];
    int selected = 0;

    return cat == 'female'
        ? FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('subcategoryF')
                .doc(category)
                .get(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data = snapshot.data?.data() != null
                    ? snapshot.data!.data()! as Map<String, dynamic>
                    : <String, dynamic>{};
                return GestureDetector(
                  onTap: () {
                    if (data['subCategF'] == "t-shirt") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Products(
                            cat: 'female',
                            subcat: 't-shirt',
                          ),
                        ),
                      );

                      chosenCateg = "t-shirt";
                      selected = 0;
                    } else if (data['subCategF'] == 'pant') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Products(
                            cat: 'female',
                            subcat: 'pant',
                          ),
                        ),
                      );
                      chosenCateg = "pant";
                      selected = 1;
                    } else if (data['subCategF'] == 'short-pant') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Products(
                            cat: 'female',
                            subcat: 'short-pant',
                          ),
                        ),
                      );
                      chosenCateg = "short-pant";
                      selected = 2;
                    } else if (data['subCategF'] == 'skirt') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Products(
                            cat: 'female',
                            subcat: 'skirt',
                          ),
                        ),
                      );
                      chosenCateg = "skirt";
                      selected = 3;
                    } else if (data['subCategF'] == 'shirt') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Products(
                            cat: 'female',
                            subcat: 'shirt',
                          ),
                        ),
                      );
                      chosenCateg = "shirt";
                      selected = 4;
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("${data['subCategF']}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: selected == data[index]
                                    ? const Color.fromARGB(72, 0, 0, 0)
                                    : const Color.fromARGB(72, 0, 0, 0))),
                        Container(
                          margin: const EdgeInsets.only(top: 15 / 4),
                          height: 2,
                          width: 30,
                          color: selected == data[index]
                              ? Colors.black
                              : Colors.transparent,
                        )
                      ],
                    ),
                  ),
                );
              }
              return const Text("Loading...");
            }))
        : FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('subcategoryM')
                .doc(category)
                .get(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data = snapshot.data?.data() != null
                    ? snapshot.data!.data()! as Map<String, dynamic>
                    : <String, dynamic>{};
                return GestureDetector(
                  onTap: () {
                    if (data['subCategM'] == "shirt") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Products(
                            cat: 'male',
                            subcat: 'shirt',
                          ),
                        ),
                      );
                      chosenCateg = "shirt";
                    } else if (data['subCategM'] == 'pant') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Products(
                            cat: 'male',
                            subcat: 'pants',
                          ),
                        ),
                      );
                      chosenCateg = "pant";
                    } else if (data['subCategM'] == 'short-pant') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Products(
                            cat: 'male',
                            subcat: 'short-pant',
                          ),
                        ),
                      );
                      chosenCateg = "short-pant";
                    } else if (data['subCategM'] == 't-shirt') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Products(
                            cat: 'male',
                            subcat: 't-shirt',
                          ),
                        ),
                      );
                      chosenCateg = "t-shirt";
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("${data['subCategM']}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: selected == data[index]
                                    ? const Color.fromARGB(72, 0, 0, 0)
                                    : const Color.fromARGB(72, 0, 0, 0))),
                        Container(
                          margin: const EdgeInsets.only(top: 15 / 4),
                          height: 2,
                          width: 30,
                          color: selected == data[index]
                              ? Colors.black
                              : Colors.transparent,
                        )
                      ],
                    ),
                  ),
                );
              }
              return const Text("Loading...");
            }));
  }
}
