import 'package:flutter/material.dart';
import 'package:fitmoi_mob_app/utils/color.dart';

typedef OnIconPressed = void Function();

class UploadBodyImages extends StatefulWidget {
  String textt;
  final OnIconPressed onPressed;
  String imagepath;
  UploadBodyImages(
      {Key? key,
      required this.textt,
      required this.onPressed,
      required this.imagepath})
      : super(key: key);

  @override
  State<UploadBodyImages> createState() => _UploadBodyImagesState();
}

class _UploadBodyImagesState extends State<UploadBodyImages> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.textt,
          style: TextStyle(
              color: mintColors, fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Stack(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  border: Border.all(width: 4, color: Colors.white),
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 2,
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.1))
                  ],
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.imagepath))),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        width: 4,
                        color: Colors.white,
                      ),
                      color: Color.fromARGB(255, 10, 169, 159)),
                  child: TextButton(
                    child: const Icon(
                      Icons.upload,
                      color: Colors.white,
                    ),
                    onPressed: widget.onPressed,
                  )),
            )
          ],
        ),
      ],
    );
  }
}
