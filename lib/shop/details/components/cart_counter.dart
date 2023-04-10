import 'package:fitmoi_mob_app/utils/color.dart';
import 'package:flutter/material.dart';

class CartCounter extends StatefulWidget {
  const CartCounter({super.key});

  @override
  State<CartCounter> createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  int numofItems = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
            color: GreyColors,
            onPressed: (() {
              if (numofItems > 1) {
                setState(() {
                  numofItems--;
                });
              }
            }),
            icon: Icon(Icons.remove)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15 / 2),
          child: Text(
            numofItems.toString().padLeft(2, "0"),
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        IconButton(
            color: GreyColors,
            onPressed: (() {
              setState(() {
                numofItems++;
              });
            }),
            icon: Icon(Icons.add)),
      ],
    );
  }

  SizedBox buildButton({IconData? icon, required Function press}) {
    return SizedBox(
      width: 40,
      height: 32,
      child: OutlinedButton(
        onPressed: (() {
          press;
        }),
        child: Icon(icon),
      ),
    );
  }
}
