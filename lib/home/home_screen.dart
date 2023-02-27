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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(children: <Widget>[
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
