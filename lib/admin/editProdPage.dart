import 'package:fitmoi_mob_app/admin/edit_product.dart';
import 'package:fitmoi_mob_app/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class EditProd extends StatefulWidget {
  final String prodd;
  const EditProd({super.key, required this.prodd});

  @override
  State<EditProd> createState() => _EditProdState();
}

class _EditProdState extends State<EditProd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "Edit Product"),
      body: Container(
        child: EditProductPage(prod: widget.prodd),
      ),
    );
  }
}
