import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitmoi_mob_app/utils/color.dart';
import 'package:fitmoi_mob_app/widgets/btn_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../widgets/app_bar.dart';

Future addrate(
    String? email, String comment, double rate, String productID) async {
  await FirebaseFirestore.instance.collection('rate').doc().set(
    {
      'comment': comment,
      'email': email,
      'rate': rate,
      'productID': productID,
    },
  );
}

class AddReview extends StatefulWidget {
  const AddReview({super.key, required this.ratee});
  final String ratee;
  @override
  State<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  TextEditingController comment = TextEditingController();
  double rating = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "Add Review"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Container(
            height: 400,
            width: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(padding: EdgeInsets.all(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          this.rating = rating;
                        });
                      },
                    ),
                  ],
                ),
                TextField(
                  controller: comment,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Review',
                      hintText: "Add a comment"),
                ),
                ButtonWidget(
                    onClick: () {
                      addrate(FirebaseAuth.instance.currentUser?.email,
                              comment.text.trim(), rating, widget.ratee!)
                          .then((value) {
                        Fluttertoast.showToast(
                          msg: "Review addedd...",
                        );
                        Navigator.pop(context);
                      });
                    },
                    btnText: "Submit"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
