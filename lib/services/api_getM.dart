import 'dart:convert';
import 'dart:io' as Io;
import 'dart:io';
import 'dart:typed_data';
import 'package:fitmoi_mob_app/models/measurments.dart';
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
    List<int> frontImageBytes = await File(frontImageFile.path).readAsBytes();
    String frontBase64Encode = base64.encode(frontImageBytes);
    List<int> sideimageBytes = await File(sideImageFile.path).readAsBytes();
    String sidebase64Encode = base64.encode(sideimageBytes);
    List<int> backimageBytes = await File(backImageFile.path).readAsBytes();
    String backbase64Encode = base64.encode(backimageBytes);
    var measurments = {
      "uniqueId": unique,
      "height": "${height}",
      "frontImage": "${frontBase64Encode}",
      "sideImage": "${sidebase64Encode}",
      "backImage": "${backbase64Encode}",

      //"weight": "${weight}",
    };
    var JsonBody = measurments;
    var response = await http.post(
        Uri.parse("http://192.168.1.108:8000/get_measurement"),
        body: jsonEncode(JsonBody),
        headers: {"content-type": "application/json"});
    bool completed = false;
    var wait = {"waiting": unique, "uniqueId": unique};
    while (!completed) {
      await _sleep(4);
      var response2 = await http.post(
          Uri.parse("http://192.168.1.108:8000/get_measurement"),
          body: jsonEncode(wait),
          headers: {"content-type": "application/json"});

      var jsonResponse2 = jsonDecode(response2.body);
      var status = jsonResponse2['Status'];
      if (status == 'Done') {
        completed = true;
        var measurements = Measurements(
            chest: jsonResponse2["measurements"]['chest'],
            hip: jsonResponse2['measurements']["hip"],
            back: jsonResponse2['measurements']["back"]);
        return measurements;
      }
    }
    return null;
  }

  Future _sleep(duration) {
    return new Future.delayed(Duration(seconds: duration));
  }
}
