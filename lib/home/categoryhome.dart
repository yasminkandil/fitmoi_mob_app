import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../pages/products_all.dart';
import '../read data/get_categoryhome.dart';
import '../widgets/app_bar.dart';

class CategoryGender extends StatefulWidget {
  CategoryGender({super.key});

  @override
  State<CategoryGender> createState() => _CategoryGenderState();
}

class _CategoryGenderState extends State<CategoryGender> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 15,
              width: 15,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Products(
                        cat: 'female',
                        subcat: 't-shirt',
                      ),
                    ),
                  );
                },
                child: ClipRRect(
                  //borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset(
                    'assets/womenhome.jpeg',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
              width: 15,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Products(
                        cat: 'male',
                        subcat: 't-shirt',
                      ),
                    ),
                  );
                },
                child: ClipRRect(
                  // borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset(
                    'assets/menhome.jpeg',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
              width: 15,
            ),
          ],
        ),
      ),
    );
  }
}
