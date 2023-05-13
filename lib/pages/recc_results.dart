import 'dart:convert';

import 'package:fitmoi_mob_app/models/recModel.dart';
import 'package:fitmoi_mob_app/utils/color.dart';
import 'package:fitmoi_mob_app/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RecResult extends StatefulWidget {
  RecPredict resultss;
  RecResult({
    super.key,
    required this.resultss,
  });

  @override
  State<RecResult> createState() => _RecResultState();
}

class _RecResultState extends State<RecResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "Recommendation Results"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            child: Column(
          children: [
            Text(
              widget.resultss.message,
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: mintColors),
            ),
            Row(
              children: [
                Text(
                  'original Score ',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: GreyColors),
                ),
                Text(
                  widget.resultss.revisedScore.toStringAsFixed(2),
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Revised Score ',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: GreyColors),
                ),
                Text(
                  widget.resultss.origScore.toStringAsFixed(2),
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
              ],
            ),
            Text(
              'Revised Outfit',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: mintColors),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.resultss.imgOutputs.length,
                itemBuilder: (context, index) {
                  final part = widget.resultss.imgOutputs.keys.toList()[index];
                  final base64Image = widget.resultss.imgOutputs[part];
                  final decodedImage = base64.decode(base64Image);
                  return SizedBox(
                    width: 100,
                    height: 150,
                    child: Image.memory(decodedImage),
                  );
                },
              ),
            ),
          ],
        )),
      ),
    );
  }
}
