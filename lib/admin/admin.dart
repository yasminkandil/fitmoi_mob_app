import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../home/home_page.dart';
import '../utils/color.dart';
import '../widgets/header_container.dart';
import '../widgets/header_containerdash.dart';

enum Page { dashboard, manage }

//var usersC =
//  FirebaseFirestore.instance.collection("users").count().get().toString();

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Dashboard"),
          backgroundColor: GreyColors,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: mintColors,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const MyHomePage();
                  }),
                );
              }),
        ),
        body: _loadScreen());
  }

  Widget _loadScreen() {
    return ListView(
      children: <Widget>[
        HeaderContainerDash("Dashboard"),
        SizedBox(
          height: 10,
        ),
        ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text("Add product"),
            onTap: () => Navigator.pushNamed(context, 'add_product')),
        Divider(
          color: mintColors,
          height: 10,
          thickness: 3,
          indent: 25,
          endIndent: 25,
        ),
        ListTile(
            leading: const Icon(Icons.library_books),
            title: const Text("Products list"),
            onTap: () => Navigator.pushNamed(context, 'view_products')),
        Divider(
          color: mintColors,
          height: 10,
          thickness: 3,
          indent: 25,
          endIndent: 25,
        ),
        ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text("Add category"),
            onTap: () => Navigator.pushNamed(context, 'add_category')),
        Divider(
          color: mintColors,
          height: 10,
          thickness: 3,
          indent: 25,
          endIndent: 25,
        ),
        ListTile(
            leading: const Icon(Icons.library_books),
            title: const Text("Category list"),
            onTap: () => Navigator.pushNamed(context, 'view_categories')),
        Divider(
          color: mintColors,
          height: 10,
          thickness: 3,
          indent: 25,
          endIndent: 25,
        ),
        ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text("Add in homepage images"),
            onTap: () => Navigator.pushNamed(context, 'add_homeimage')),
        Divider(
          color: mintColors,
          height: 10,
          thickness: 3,
          indent: 25,
          endIndent: 25,
        ),
        ListTile(
            leading: const Icon(Icons.library_books),
            title: const Text("Orders List"),
            onTap: () => Navigator.pushNamed(context, 'view_orders')),
        Divider(
          color: mintColors,
          height: 10,
          thickness: 3,
          indent: 25,
          endIndent: 25,
        ),
        ListTile(
            leading: const Icon(Icons.library_books),
            title: const Text("Users List"),
            onTap: () => Navigator.pushNamed(context, 'view_users')),
        Divider(
          color: mintColors,
          height: 10,
          thickness: 3,
          indent: 25,
          endIndent: 25,
        ),
        ListTile(
            leading: const Icon(Icons.library_books),
            title: const Text("Messages List"),
            onTap: () => Navigator.pushNamed(context, 'view_messages')),
        Divider(
          color: mintColors,
          height: 10,
          thickness: 3,
          indent: 25,
          endIndent: 25,
        ),
        ListTile(
            leading: const Icon(Icons.library_books),
            title: const Text("Refunds Requests"),
            onTap: () => Navigator.pushNamed(context, 'view_refunds')),
        Divider(
          color: mintColors,
          height: 10,
          thickness: 3,
          indent: 25,
          endIndent: 25,
        ),
      ],
    );
  }
}
