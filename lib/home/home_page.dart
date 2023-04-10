import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitmoi_mob_app/pages/cart.dart';
import 'package:fitmoi_mob_app/pages/must_have_account.dart';
import 'package:fitmoi_mob_app/pages/view_account.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../utils/color.dart';
import 'navbar.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var navbarItem = [
      BottomNavigationBarItem(icon: const Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: const Icon(Icons.person), label: 'Account'),
      BottomNavigationBarItem(icon: const Icon(Icons.shop), label: 'Cart'),
    ];
    var navBody = [
      Container(child: Navigation_bar()),
      Container(
        child: FirebaseAuth.instance.currentUser == null
            ? MustHaveAccountPage()
            : ViewAccountPage(),
      ),
      Container(
          child: FirebaseAuth.instance.currentUser == null
              ? MustHaveAccountPage()
              : CartItem()),
      Container(
          // child: Products(cat: 'Cables'),
          ),
    ];
    return Scaffold(
      body: Column(
        children: [
          Obx(
            () => Expanded(
                child: navBody.elementAt(controller.currentNavIndex.value)),
          ),
        ],
      ),
      bottomNavigationBar: Obx(
        (() => BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            selectedItemColor: mintColors,
            onTap: (value) {
              controller.currentNavIndex.value = value;
            },
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.grey,
            items: navbarItem)),
      ),
    );
  }
}
