import 'package:flutter/material.dart';
import 'package:fitmoi_mob_app/widgets/home_button.dart';

import 'package:velocity_x/velocity_x.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'newarrival.dart';
import 'offerhomepage.dart';

final pro = FirebaseFirestore.instance.collection('homePage');

class HomeScreen extends StatefulWidget {
  final String salma;
  const HomeScreen({super.key, required this.salma});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
//Connection to Gallery
    List<String> imageList = [];
    // Future getDocImage() async {
    //   await FirebaseFirestore.instance.collection('homePage').get().then(
    //         (snapshot) => snapshot.docs.forEach((document) {
    //           print(document.reference);
    //           imageList.add(document.reference.id);
    //         }),
    //       );
    // }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(children: <Widget>[
          VxSwiper.builder(
            aspectRatio: 16 / 5,
            autoPlay: true,
            height: 150,
            itemCount: 7,
            enlargeCenterPage: true,
            itemBuilder: (context, index) {
              //getDocImage();
              builder:
              (context, snapshot) {
                itemCount:
                snapshot.data.length;

                if (snapshot.hasError) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }
              };

              return Container(
                  //child: GetHomePhoto(homeimage: imageList[index])
                  );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              1,
              (index) => homeButton(
                width: context.screenWidth / 1.5,
                height: context.screenHeight * 0.12,
                icon: Icons.new_releases_sharp,
                title: 'New Arrival',
              ),
            ),
          ),
          NewArrivalHome(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              1,
              (index) => homeButton(
                width: context.screenWidth / 1.5,
                height: context.screenHeight * 0.12,
                icon: Icons.new_releases_sharp,
                title: 'Flash Sales',
              ),
            ),
          ),
          Offerrphoto(),
        ]),
      ),
    );
  }
}
