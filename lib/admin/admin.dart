import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../home/home_page.dart';
import '../utils/color.dart';

enum Page { dashboard, manage }

//var usersC =
//  FirebaseFirestore.instance.collection("users").count().get().toString();

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  Page _selectedPage = Page.dashboard;
  MaterialColor active = Colors.orange;
  MaterialColor notActive = Colors.grey;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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

          title: Row(
            children: <Widget>[
              Expanded(
                  child: ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 10, 169, 159)),
                      ),
                      onPressed: () {
                        setState(() => _selectedPage = Page.dashboard);
                      },
                      icon: const Icon(Icons.dashboard, color: Colors.white),
                      label: const Text('Dashboard'))),
              Expanded(
                  child: ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 10, 169, 159)),
                      ),
                      onPressed: () {
                        setState(() => _selectedPage = Page.manage);
                      },
                      icon: const Icon(Icons.sort, color: Colors.white),
                      label: const Text('Manage'))),
            ],
          ),
          //elevation: 0.0,
          //backgroundColor: Colors.white,
        ),
        body: _loadScreen());
  }

  Widget _loadScreen() {
    switch (_selectedPage) {
      case Page.dashboard:
        return Column(
          children: <Widget>[
            ListTile(
              subtitle: ElevatedButton.icon(
                onPressed: null,
                icon: const Icon(
                  Icons.attach_money,
                  size: 30.0,
                  color: Colors.black,
                ),
                label: Text('12,000',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30.0, color: mintColors)),
              ),
              title: const Text(
                'Revenue',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.0, color: Colors.black),
              ),
            ),
            Expanded(
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Card(
                      child: ListTile(
                          title: ElevatedButton.icon(
                              onPressed: null,
                              icon: const Icon(Icons.people_outline),
                              label: const Text("Users")),
                          subtitle: Text(
                            '150',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: mintColors, fontSize: 50.0),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Card(
                      child: ListTile(
                          title: ElevatedButton.icon(
                              onPressed: null,
                              icon: const Icon(Icons.category),
                              label: const Text("Categorie")),
                          subtitle: Text(
                            '23',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: mintColors, fontSize: 50.0),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Card(
                      child: ListTile(
                          title: ElevatedButton.icon(
                              onPressed: null,
                              icon: const Icon(Icons.track_changes),
                              label: const Text("Products")),
                          subtitle: Text(
                            '120',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: mintColors, fontSize: 50.0),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Card(
                      child: ListTile(
                          title: ElevatedButton.icon(
                              onPressed: null,
                              icon: const Icon(Icons.date_range),
                              label: const Text("In Fix")),
                          subtitle: Text(
                            '13',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: mintColors, fontSize: 50.0),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Card(
                      child: ListTile(
                          title: ElevatedButton.icon(
                              onPressed: null,
                              icon: const Icon(Icons.shopping_cart),
                              label: const Text("Orders")),
                          subtitle: Text(
                            '500',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: mintColors, fontSize: 50.0),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Card(
                      child: ListTile(
                          title: ElevatedButton.icon(
                              onPressed: null,
                              icon: const Icon(Icons.close),
                              label: const Text("Messages")),
                          subtitle: Text(
                            '20',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: mintColors, fontSize: 50.0),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      case Page.manage:
        return ListView(
          children: <Widget>[
            ListTile(
                leading: const Icon(Icons.add_circle_outline),
                title: const Text("Add product"),
                onTap: () => Navigator.pushNamed(context, 'add_product')),
            const Divider(),
            ListTile(
                leading: const Icon(Icons.library_books),
                title: const Text("Products list"),
                onTap: () => Navigator.pushNamed(context, 'view_products')),
            const Divider(),
            ListTile(
                leading: const Icon(Icons.add_circle_outline),
                title: const Text("Add category"),
                onTap: () => Navigator.pushNamed(context, 'add_category')),
            const Divider(),
            ListTile(
                leading: const Icon(Icons.library_books),
                title: const Text("Category list"),
                onTap: () => Navigator.pushNamed(context, 'view_categories')),
            const Divider(),
            ListTile(
                leading: const Icon(Icons.add_circle_outline),
                title: const Text("Add in homepage images"),
                onTap: () => Navigator.pushNamed(context, 'add_homeimage')),
            const Divider(),
            ListTile(
                leading: const Icon(Icons.library_books),
                title: const Text("Orders List"),
                onTap: () => Navigator.pushNamed(context, 'view_orders')),
            const Divider(),
            ListTile(
                leading: const Icon(Icons.library_books),
                title: const Text("Users List"),
                onTap: () => Navigator.pushNamed(context, 'view_users')),
            const Divider(),
            ListTile(
                leading: const Icon(Icons.library_books),
                title: const Text("Messages List"),
                onTap: () => Navigator.pushNamed(context, 'view_messages')),
          ],
        );
    }
  }
}
