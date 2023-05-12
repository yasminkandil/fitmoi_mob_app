import 'package:fitmoi_mob_app/utils/color.dart';
import 'package:flutter/material.dart';

class DialogBuilder {
  DialogBuilder(this.context);

  final BuildContext context;

  void showLoadingIndicator([String? text]) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              backgroundColor: Colors.white,
              content: LoadingIndicator(text: text.toString()),
            ));
      },
    );
  }

  void hideOpenDialog() {
    Navigator.of(context).pop();
  }
}

class LoadingIndicator extends StatelessWidget {
  LoadingIndicator({this.text = ''});

  final String text;

  @override
  Widget build(BuildContext context) {
    var displayedText = text;

    return Container(
        padding: EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _getLoadingIndicator(),
              _getHeading(context),
              _getText(displayedText),
              _getOKButton(context)
            ]));
  }

  Padding _getLoadingIndicator() {
    return Padding(
        child: Container(
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: new AlwaysStoppedAnimation<Color>(mintLightColors),
            ),
            width: 32,
            height: 32),
        padding: EdgeInsets.only(bottom: 16));
  }

  Widget _getHeading(context) {
    return Padding(
        child: Text(
          'Please wait …',
          style: TextStyle(color: Colors.black, fontSize: 16),
          textAlign: TextAlign.center,
        ),
        padding: EdgeInsets.only(bottom: 4));
  }

  Text _getText(String displayedText) {
    return Text(
      displayedText,
      style: TextStyle(color: Colors.black, fontSize: 14),
      textAlign: TextAlign.center,
    );
  }
}

Widget _getOKButton(BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      Navigator.of(context).pop();
    },
    style: ElevatedButton.styleFrom(
      primary: mintLightColors,
      onPrimary: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
      ),
    ),
    child: const Text(
      "go back",
      style: TextStyle(
        color: Colors.white,
        fontSize: 15,
      ),
    ),
  );
}
