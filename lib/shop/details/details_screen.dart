import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitmoi_mob_app/shop/details/components/body.dart';
import 'package:fitmoi_mob_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DetailScreen extends StatelessWidget {
  final String prod;
  const DetailScreen({super.key, required this.prod});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GreyLightColors,
      appBar: buildAppBar(context),
      body: Body(
        prod: prod,
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: GreyColors,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back, color: mintColors),
      ),
      title: Text('Details'),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add_shopping_cart_outlined,
          ),
          onPressed: () {
            if (FirebaseAuth.instance.currentUser == null) {
              Navigator.pushNamed(context, 'must_have_account');
            } else {
              Navigator.pushNamed(context, 'cart');
            }
          },
        ),
        SizedBox(
          width: 2,
        )
      ],
    );
  }
}
