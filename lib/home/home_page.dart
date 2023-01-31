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
      BottomNavigationBarItem(icon: const Icon(Icons.photo), label: 'Gallery'),
      BottomNavigationBarItem(icon: const Icon(Icons.shop), label: 'Shop'),
    ];
    var navBody = [
      Container(child: Navigation_bar()),
      Container(
          // child: gallery(),
          ),
      Container(
          //child: CategoryPage(),
          ),
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
