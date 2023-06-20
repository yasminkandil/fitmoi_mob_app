import 'dart:convert';
import 'dart:io' as Io;
import 'dart:io';
import 'dart:typed_data';
import 'package:fitmoi_mob_app/models/measurments.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class NoHumanDetectedException implements Exception {}

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

    var measurementsData = {
      "uniqueId": unique,
      "height": "${height}",
      "frontImage": "${frontBase64Encode}",
      "sideImage": "${sideBase64Encode}",
      "backImage": "${backBase64Encode}",
    };

    var jsonBody = measurementsData;
    var response = await http.post(
      Uri.parse("http://192.168.1.108:8000/get_measurement"),
      body: jsonEncode(jsonBody),
      headers: {"content-type": "application/json"},
    );

    var jsonResponse = jsonDecode(response.body);
    var status = jsonResponse['Status'];

    if (status == 'NoHuman') {
      // Handle the case where no human is detected in the image
      // Display an appropriate message to the user or take necessary action
      Fluttertoast.showToast(msg: "No human detected in image");
      throw NoHumanDetectedException();
    }

    while (status != 'Done') {
      await Future.delayed(Duration(seconds: 4));

      var response2 = await http.post(
        Uri.parse("http://192.168.1.108:8000/get_measurement"),
        body: jsonEncode({"waiting": unique, "uniqueId": unique}),
        headers: {"content-type": "application/json"},
      );

      jsonResponse = jsonDecode(response2.body);
      status = jsonResponse['Status'];
    }

    var measurementsResult = Measurements(
      chest: jsonResponse["measurements"]['chest'],
      hip: jsonResponse['measurements']["hip"],
      back: jsonResponse['measurements']["back"],
      waist: jsonResponse['measurements']['waist'],
    );

    return measurementsResult;
  }

  Future _sleep(duration) {
    return new Future.delayed(Duration(seconds: duration));
  }
}
