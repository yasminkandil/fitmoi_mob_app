import 'dart:convert';
import 'dart:io' as Io;
import 'dart:io';
import 'dart:typed_data';
import 'package:fitmoi_mob_app/models/measurments.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class Api_3DService {
  Future getmeasurements(
    String unique,
    double height,
    File frontImageFile,
    File sideImageFile,
    File backImageFile,
  ) async {
    List<int> frontImageBytes = await frontImageFile.readAsBytes();
    String frontBase64Encode = base64.encode(frontImageBytes);
    List<int> sideImageBytes = await sideImageFile.readAsBytes();
    String sideBase64Encode = base64.encode(sideImageBytes);
    List<int> backImageBytes = await backImageFile.readAsBytes();
    String backBase64Encode = base64.encode(backImageBytes);

    var measurements = {
      "uniqueId": unique,
      "height": "${height}",
      "frontImage": "${frontBase64Encode}",
      "sideImage": "${sideBase64Encode}",
      "backImage": "${backBase64Encode}",
    };

    var jsonBody = measurements;
    var response = await http.post(
      Uri.parse("http://192.168.1.108:8000/get_measurement"),
      body: jsonEncode(jsonBody),
      headers: {"content-type": "application/json"},
    );

    bool completed = false;
    var wait = {"waiting": unique, "uniqueId": unique};

    while (!completed) {
      await Future.delayed(Duration(seconds: 4));

      var response2 = await http.post(
        Uri.parse("http://192.168.1.108:8000/get_measurement"),
        body: jsonEncode(wait),
        headers: {"content-type": "application/json"},
      );

      var jsonResponse2 = jsonDecode(response2.body);
      var status = jsonResponse2['Status'];

      if (status == 'Done') {
        completed = true;
        var measurements = Measurements(
          chest: jsonResponse2["measurements"]['chest'],
          hip: jsonResponse2['measurements']["hip"],
          back: jsonResponse2['measurements']["back"],
          waist: jsonResponse2['measurements']['waist'],
        );

        return measurements;
      } else if (status == 'NoHuman') {
        completed = true;
        // Handle the case where no human is detected in the image
        // Display an appropriate message to the user or take necessary action
        Fluttertoast.showToast(msg: "No human detected in image");
        return null;
      }
    }

    return null;
  }

  Future _sleep(duration) {
    return new Future.delayed(Duration(seconds: duration));
  }
}
