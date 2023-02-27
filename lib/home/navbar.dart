import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitmoi_mob_app/home/home_screen.dart';
import 'package:flutter/material.dart';

import '../controllers/search_product.dart';
import '../pages/my_drawer_header.dart';
import '../shop/details/components/body.dart';
import '../utils/color.dart';
import '../widgets/header_container.dart';
import 'categoryhome.dart';

class Navigation_bar extends StatefulWidget {
  @override
  HomeNavbar createState() => HomeNavbar();
}

class HomeNavbar extends State<Navigation_bar> {
  var currentPage = Sections.Dashboard;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GreyColors,
        title: Text("Menu"),
        actions: [
          /*Consumer<ThemeProvider>(
            builder: (context, theme, child) {
              return IconButton(
                icon: Icon(Icons.brightness_6),
                onPressed: () {
                  theme.toggleTheme();
                },
              );
            },
          ),*/
          IconButton(
            onPressed: () {
              Future<void> ProdSearch() async {
                await showSearch(
                  context: context,
                  delegate: ProductSearch(),
                );
              }

              ProdSearch();
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              // method to show the search bar
            },
            icon: const Icon(Icons.notifications),
          ),
          IconButton(
            onPressed: () {
              // method to show the search bar
            },
            icon: const Icon(Icons.shopping_bag),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(children: <Widget>[
            HeaderContainer("Home Page"),
            CategoryGender(),
            HomeScreen(salma: "salma")
          ]),
        ),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
            child: Container(
          child: Column(children: [
            // Malhashh lazmaa walla ehhh!!!!!!!!
            MyHeaderDrawer(),
            MyDrawerList(),
          ]),
        )),
      ),
    );

    // TODO: implement build
  }

  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        children: [
          menuItem(7, "Sign Up", Icons.login_rounded,
              currentPage == Sections.Sign_Up ? true : false),
          menuItem(10, "Login", Icons.login_rounded,
              currentPage == Sections.login ? true : false),
          menuItem(3, "Shop", Icons.category_rounded,
              currentPage == Sections.Categories ? true : false),
          menuItem(8, "Cart", Icons.shop_two_outlined,
              currentPage == Sections.Cart ? true : false),
          menuItem(1, "Try-On", Icons.image,
              currentPage == Sections.Gallery ? true : false),
          menuItem(9, "Order History", Icons.history,
              currentPage == Sections.order_history ? true : false),
          menuItem(2, "Contact US", Icons.people_alt_outlined,
              currentPage == Sections.contacts ? true : false),
          menuItem(4, " Profile", Icons.edit_attributes_rounded,
              currentPage == Sections.Edit_Profile ? true : false),
          menuItem(5, " Favourites", Icons.favorite,
              currentPage == Sections.fav ? true : false),
          menuItem(6, "Log Out", Icons.logout_rounded,
              currentPage == Sections.Log_Out ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      //color: selected ? Colors.grey : Colors.transparent,
      child: InkWell(
        onTap: () {
          if (id == 7) {
            Navigator.pushNamed(context, 'register');
            currentPage = Sections.Sign_Up;
          } else if (id == 2) {
            if (FirebaseAuth.instance.currentUser == null) {
              Navigator.pushNamed(context, 'must_have_account');
            } else {
              Navigator.pushNamed(context, 'contact_us');
            }
            currentPage = Sections.contacts;
          } else if (id == 5) {
            if (FirebaseAuth.instance.currentUser == null) {
              Navigator.pushNamed(context, 'must_have_account');
            } else {
              Navigator.pushNamed(context, 'fav');
            }
            currentPage = Sections.contacts;
          } else if (id == 3) {
            Navigator.pushNamed(context, 'shop');
            currentPage = Sections.Categories;
          } else if (id == 4) {
            if (FirebaseAuth.instance.currentUser == null) {
              Navigator.pushNamed(context, 'must_have_account');
            } else {
              Navigator.pushNamed(context, 'profile');
            }
            currentPage = Sections.Edit_Profile;
          } else if (id == 9) {
            if (FirebaseAuth.instance.currentUser == null) {
              Navigator.pushNamed(context, 'must_have_account');
            } else {
              Navigator.pushNamed(context, 'order_history');
            }
            currentPage = Sections.order_history;
          } else if (id == 6) {
            favprod.clear();
            FirebaseAuth.instance.signOut();
            Navigator.pushNamed(context, 'homepage');

            currentPage = Sections.Log_Out;
          } else if (id == 1) {
            Navigator.pushNamed(context, 'tryon');
            currentPage = Sections.Gallery;
          } else if (id == 8) {
            if (FirebaseAuth.instance.currentUser == null) {
              Navigator.pushNamed(context, 'must_have_account');
            } else {
              Navigator.pushNamed(context, 'cart');
            }
            currentPage = Sections.Cart;
          } else if (id == 10) {
            Navigator.pushNamed(context, 'login');
            currentPage = Sections.login;
          }
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(children: [
            Expanded(
              child: Icon(
                icon,
                size: 20,
                color: Colors.grey,
              ),
            ),
            Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ))
          ]),
        ),
      ),
    );
  }
}

enum Sections {
  Dashboard,
  contacts,
  Notifications,
  Sign_Up,
  Categories,
  Edit_Profile,
  Log_Out,
  Cart,
  CheckOut,
  login,
  Gallery,
  order_history,
  fav
}
