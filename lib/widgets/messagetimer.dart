import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  final String message;
  final int duration;
  var classs;
  // Duration in milliseconds

  LoadingDialog(
      {required this.message, required this.duration, required this.classs});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: duration));

    return Dialog(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16.0),
            Text(message),
          ],
        ),
      ),
    );
  }
}
