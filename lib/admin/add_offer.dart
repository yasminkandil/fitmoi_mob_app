import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fitmoi_mob_app/admin/add_product.dart';
import 'package:fitmoi_mob_app/widgets/app_bar.dart';
import 'package:fitmoi_mob_app/widgets/btn_widget.dart';
import 'package:fitmoi_mob_app/widgets/reg_textinput.dart';
import '../models/product_model.dart';
import "package:path/path.dart" as p;

import '../utils/color.dart';

class AddOfferPage extends StatefulWidget {
  const AddOfferPage({super.key, required this.prodid, required this.p2});
  final String prodid;
  final String p2;
  @override
  _AddOfferPageState createState() => _AddOfferPageState();
}

class _AddOfferPageState extends State<AddOfferPage> {
  final _newPController = TextEditingController();
  String mregexp = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]+$';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "Add Offer"),
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.only(bottom: 20),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: IntrinsicHeight(
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 250),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text(
                            "New Price:",
                            style: TextStyle(
                                color: mintColors,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          RegTextInput(
                              controller: _newPController,
                              hint: widget.p2,
                              icon: Icons.money,
                              torf: false,
                              errormssg: errormssg,
                              regexp: mregexp,
                              enable: true),
                          SizedBox(
                            height: 20,
                          ),
                          ListTile(
                            title: Row(
                              children: <Widget>[
                                Expanded(
                                  child: ButtonWidget2(
                                    btnText: "Add Offer",
                                    onClick: () {
                                      if (formKey.currentState!.validate()) {
                                        final updateprod = FirebaseFirestore
                                            .instance
                                            .collection('product')
                                            .doc(widget.prodid)
                                            .update(
                                          {
                                            'price2':
                                                _newPController.text.trim(),
                                            'onSale': true,
                                          },
                                        ).then((value) {
                                          Fluttertoast.showToast(
                                            msg: "Offer addedd...",
                                          );
                                          Navigator.pop(context);
                                        });
                                      }
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: ButtonWidgetdelete(
                                      btnText: "Delete Offer",
                                      onClick: () {
                                        final updateprod = FirebaseFirestore
                                            .instance
                                            .collection('product')
                                            .doc(widget.prodid)
                                            .update(
                                          {
                                            'price2': "",
                                            'onSale': false,
                                          },
                                        ).then((value) {
                                          Fluttertoast.showToast(
                                            msg: "Offer Deleted...",
                                          );
                                          Navigator.pop(context);
                                        });
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
