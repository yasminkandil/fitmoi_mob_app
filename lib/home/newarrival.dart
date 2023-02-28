import 'package:fitmoi_mob_app/utils/color.dart';
import 'package:flutter/material.dart';

import 'package:velocity_x/velocity_x.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../shop/details/details_screen.dart';

class NewArrivalHome extends StatelessWidget {
  const NewArrivalHome({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference off = FirebaseFirestore.instance.collection('product');
    Future<QuerySnapshot> NewArrival() async {
      return await FirebaseFirestore.instance
          .collection("product")
          .orderBy("Date", descending: true)
          .limit(5)
          .get();
    }

    return Container(
//3shan yeb2oo fe center
      width: double.infinity,
      decoration: BoxDecoration(
        color: mintColors,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: <
          Widget>[
        SizedBox(
            child: Stack(children: <Widget>[
          Container(
            // margin: EdgeInsets.only(top: size.height * 0.01),
            // padding: EdgeInsets.only(
            //     top: height * 0.000001, left: 10, right: 10),
            height: 400,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // children: <Widget>[],
                ),
                SizedBox(
                  height: 5,
                ),
                FutureBuilder(
                    future: NewArrival(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("Loading");
                      }

                      return Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data?.docs.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                DetailScreen(
                                                                    prod: snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                        .id
                                                                        .toString())));
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.all(35),
                                                    height: 280,
                                                    width: 240,
                                                    decoration: BoxDecoration(
                                                      color: GreyColors,
                                                      //borderRadius: BorderRadius.circular(16)
                                                    ),
                                                    child: Image(
                                                        fit: BoxFit.fitWidth,
                                                        image: NetworkImage(
                                                            "${snapshot.data?.docs[index].get('image')}")),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                DetailScreen(
                                                                    prod: snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                        .id
                                                                        .toString())));
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.all(35),
                                                    width: 240,
                                                    decoration: BoxDecoration(
                                                      color: GreyColors,
                                                    ),
                                                    child: Text(
                                                        snapshot
                                                            .data?.docs[index]
                                                            .get('name'),
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white)),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                  height: 15,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ]),
                              );
                            }),
                      );
                    })
              ],
            ),
          )
        ])),
      ]),
    );
  }
}
