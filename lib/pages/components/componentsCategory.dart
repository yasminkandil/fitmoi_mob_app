import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitmoi_mob_app/admin/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
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

  Future<List<dynamic>> getSubcategoriesF() async {
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance
            .collection('category')
            .doc('iIDinMSxd9LMHvl1zlWy')
            .get();
    final data = documentSnapshot.data();
    if (data == null) {
      return [];
    } // Return an empty list if the document doesn't exist
    return data['subcategory'] ??
        []; // Return the subcategory array or an empty list if it doesn't exist
  }

  List<dynamic> _subcategoriesF = [];
  dynamic _selectedValuee;
  void fetchSubcategoriesF() async {
    _subcategoriesF = await getSubcategoriesF();
    if (_subcategoriesF.isNotEmpty) {
      setState(() {
        _selectedValuee = _subcategoriesF[0]; // Set the initial selected value
      });
    }
  }

  Future<List<dynamic>> getSubcategoriesM() async {
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance
            .collection('category')
            .doc('ypF4q51E7j7zVBlvFoYx')
            .get();
    final data = documentSnapshot.data();
    if (data == null) {
      return [];
    } // Return an empty list if the document doesn't exist
    return data['subcategory'] ??
        []; // Return the subcategory array or an empty list if it doesn't exist
  }

  List<dynamic> _subcategoriesM = [];
  dynamic _selectedValueeM;
  void fetchSubcategoriesM() async {
    _subcategoriesM = await getSubcategoriesM();
    if (_subcategoriesM.isNotEmpty) {
      setState(() {
        _selectedValueeM = _subcategoriesM[0]; // Set the initial selected value
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getDocProd(),
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: SizedBox(
              height: 30,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: prod.length,
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
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("subcategori",
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
