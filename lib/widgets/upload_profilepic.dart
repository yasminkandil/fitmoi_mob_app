import 'package:flutter/material.dart';
import 'package:fitmoi_mob_app/utils/color.dart';

typedef OnIconPressed = void Function();

class UploadImages extends StatefulWidget {
  String textt;
  OnIconPressed function;
  String imagepath;

  UploadImages(
      {Key? key,
      required this.textt,
      required this.function,
      required this.imagepath})
      : super(key: key);

  @override
  State<UploadImages> createState() => _UploadImagesState();
}

class _UploadImagesState extends State<UploadImages> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
                border: Border.all(width: 4, color: Colors.white),
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.1))
                ],
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(widget.imagepath))),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
                height: 40,
                width: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
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
                  onPressed: widget.function,
                )),
          )
        ],
      ),
    );
  }
}
