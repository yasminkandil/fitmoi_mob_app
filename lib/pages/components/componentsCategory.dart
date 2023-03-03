import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:fitmoi_mob_app/pages/contact_us.dart';
import 'package:fitmoi_mob_app/pages/products_all.dart';
//import 'package:fitmoi_mob_app/product_powerbank.dart';

import '../../home/home_page.dart';

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
  const buildCategory(
      {super.key,
      required this.category,
      required this.index,
      required this.cat});
  final String category;
  final int index;
  final String cat;
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
                    if (data['subCategF'] == "shirt") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Products(
                            cat: 'female',
                            subcat: 'shirt',
                          ),
                        ),
                      );
                    } else if (data['subCategF'] == 'pants') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Products(
                            cat: 'female',
                            subcat: 'pants',
                          ),
                        ),
                      );
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
                                    ? Color.fromARGB(72, 0, 0, 0)
                                    : Color.fromARGB(72, 0, 0, 0))),
                        Container(
                          margin: EdgeInsets.only(top: 15 / 4),
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
              return Text("Loading...");
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
                    if (data['subCategM'] == "shirts") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Products(
                            cat: 'male',
                            subcat: 'shirts',
                          ),
                        ),
                      );
                    } else if (data['subCategM'] == 'pants') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Products(
                            cat: 'male',
                            subcat: 'pants',
                          ),
                        ),
                      );
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
                                    ? Color.fromARGB(72, 0, 0, 0)
                                    : Color.fromARGB(72, 0, 0, 0))),
                        Container(
                          margin: EdgeInsets.only(top: 15 / 4),
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
              return Text("Loading...");
            }));
  }
}
