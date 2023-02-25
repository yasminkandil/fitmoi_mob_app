import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import '../../home/home_page.dart';
import '../products_all.dart';

class Categorie extends StatefulWidget {
  const Categorie({super.key});

  @override
  State<Categorie> createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {
  List<String> prod = [];
  Future getDocProd() async {
    await FirebaseFirestore.instance.collection('category').get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            print(document.reference);
            prod.add(document.reference.id);
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getDocProd(),
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: SizedBox(
              height: 430,
              child: ListView.builder(
                //  scrollDirection: Axis.horizontal,
                itemCount: 2,
                itemBuilder: (context, indexx) =>
                    buildCategory(category: prod[indexx], index: indexx),
              ),
            ),
            //Container(child: MyHomePage()),
          );
        });
  }
}

class buildCategory extends StatelessWidget {
  const buildCategory({super.key, required this.category, required this.index});
  final String category;
  final int index;
  @override
  Widget build(BuildContext context) {
    List arkam = [index];
    int selected = 0;
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('category')
            .doc(category)
            .get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data?.data() != null
                ? snapshot.data!.data()! as Map<String, dynamic>
                : <String, dynamic>{};
            return GestureDetector(
              onTap: () {
                if (data['name'] == "female") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Products(
                        cat: 'female',
                      ),
                    ),
                  );
                } else if (data['name'] == 'male') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Products(
                        cat: 'male',
                      ),
                    ),
                  );
                }
                // else if (data['name'] == 'Covers') {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => Products(
                //         cat: 'Covers',
                //       ),
                //     ),
                //   );
                // } else if (data['name'] == 'Headphones') {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => Products(
                //         cat: 'Headphones',
                //       ),
                //     ),
                //   );
                // }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Products(
                              cat: 'female',
                            ),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.asset('assets/womenhome.jpeg',
                            width: 400, height: 200.0),
                      ),
                    ),
                    Center(
                      child: Text("${data['name']}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: selected == data[index]
                                  ? Color.fromARGB(72, 0, 0, 0)
                                  : Color.fromARGB(72, 0, 0, 0))),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Products(
                              cat: 'male',
                            ),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.asset('assets/menhome.jpeg',
                            width: 400, height: 200.0),
                      ),
                    ),
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
