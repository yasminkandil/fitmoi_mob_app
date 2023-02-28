import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../widgets/app_bar.dart';

class Review extends StatefulWidget {
  const Review({super.key, required this.ratee});
  final String ratee;

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  List<String> rev = [];

  Future getDocreview() async {
    await FirebaseFirestore.instance
        .collection('rate')
        .where('productID', isEqualTo: widget.ratee)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach((document) {
            print(document.reference);
            rev.add(document.reference.id);
          }),
        );
  }

  TextEditingController comment = TextEditingController();

  double rating = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: "Review",
      ),
      body: FutureBuilder(
        future: getDocreview(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (rev.isEmpty) {
            return const Center(
                child: Text(
              "No Reviews yet! \n"
              "Be the first to review this product",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 40),
            ));
          }
          return ListView.builder(
            itemCount: rev.length,
            itemBuilder: (context, index) => Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('rate')
                        .doc(rev[index])
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        Map<String, dynamic> data =
                            snapshot.data?.data() != null
                                ? snapshot.data?.data() as Map<String, dynamic>
                                : {};

                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              Text("Email: " + data['email']),
                              const SizedBox(
                                height: 10,
                              ),
                              RatingBar.builder(
                                initialRating: data['rate'],
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  setState(() {});
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text("Comment: " + data['comment']),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        );
                      }

                      return const Text("Loading....");
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
