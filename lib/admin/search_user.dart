import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fitmoi_mob_app/utils/color.dart';

class FirebaseSearchUserScreen extends StatefulWidget {
  const FirebaseSearchUserScreen({Key? key}) : super(key: key);
  @override
  State<FirebaseSearchUserScreen> createState() =>
      _FirebaseSearchUserScreenState();
}

class _FirebaseSearchUserScreenState extends State<FirebaseSearchUserScreen> {
  List searchResult = [];
  void searchFromFirebase(String query) async {
    final result = await FirebaseFirestore.instance
        .collection('users')
        .where('firstname', isGreaterThanOrEqualTo: query)
        .get();
    setState(() {
      searchResult = result.docs.map((e) => e.data()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GreyColors,
        title: const Text("Search"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Search Here",
              ),
              onChanged: (query) {
                searchFromFirebase(query);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResult.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 2, color: Colors.white),
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(0.1))
                                ],
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        searchResult[index]['image']))),
                          ),
                          Column(
                            children: [
                              Text(searchResult[index]['email']),
                              SizedBox(
                                height: 10,
                                width: 10,
                              ),
                              Text(searchResult[index]['firstname']),
                              SizedBox(
                                height: 10,
                                width: 10,
                              ),
                              Text(searchResult[index]['lastname']),
                              SizedBox(
                                height: 10,
                                width: 10,
                              ),
                              Text(searchResult[index]['address']),
                              SizedBox(
                                height: 10,
                                width: 10,
                              ),
                              Text(searchResult[index]['mobile']),
                            ],
                          ),
                        ],
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
            ),
          ),
        ],
      ),
    );
  }
}
