import 'package:fitmoi_mob_app/utils/color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fitmoi_mob_app/pages/my_drawer_header.dart';
import 'package:fitmoi_mob_app/home/navbar.dart';

import 'package:fitmoi_mob_app/utils/color.dart';
import 'package:fitmoi_mob_app/pages/components/body.dart';

import '../widgets/app_bar.dart';

class Products extends StatelessWidget {
  Products({super.key, required this.cat, required this.subcat});
  String cat;
  String subcat;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "Shop"),
      body: Body(
        cat: cat,
        subcat: subcat,
      ),
    );
  }

  // AppBar buildAppBar(BuildContext context) {
  // return AppBar(
  //   title: Text("Shop"),
  //   backgroundColor: mintColors,
  //   elevation: 0,
  //   leading: IconButton(
  //     onPressed: () {
  //       Navigator.pop(context);
  //     },
  //     icon: Icon(Icons.arrow_back_ios),
  //   ),
  //   actions: <Widget>[
  //     IconButton(
  //       icon: Icon(Icons.search),
  //       onPressed: () {},
  //     ),
  //     IconButton(
  //       icon: Icon(
  //         Icons.add_shopping_cart_outlined,
  //       ),
  //       onPressed: () {},
  //     ),
  //     SizedBox(
  //       width: 2,
  //     )
  //   ],
  // );
  // }
}
