import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:fitmoi_mob_app/controllers/search_product.dart';
import 'package:fitmoi_mob_app/utils/color.dart';

import '../controllers/search_product.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  String text;
  CustomAppBar({Key? key, required this.text})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  Widget build(BuildContext context) {
    Future<void> ProdSearch() async {
      await showSearch(
        context: context,
        delegate: ProductSearch(),
      );
    }

    return AppBar(
      backgroundColor: GreyColors,
      title: Text(text),
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: mintColors,
          ),
          onPressed: () {
            Navigator.pop(context);
          }),
      actions: [
        IconButton(
          onPressed: () {
            //ProdSearch();
          },
          icon: const Icon(Icons.search),
        ),
        IconButton(
          onPressed: () {
            if (FirebaseAuth.instance.currentUser == null) {
              Navigator.pushNamed(context, 'must_have_account');
            } else {
              Navigator.pushNamed(context, 'cart');
            }
          },
          icon: const Icon(Icons.shopping_bag),
        )
      ],
    );
  }
}
