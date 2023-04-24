import 'dart:convert';
import 'dart:io' as Io;
import 'dart:io';
import 'dart:typed_data';
import 'package:fitmoi_mob_app/models/measurments.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

// Function to send image file to Flask API for processing
// Future<void> sendImageToAPI(String imagePath) async {
//   // Replace the API endpoint with the correct URL of your Flask API
//   var url = Uri.parse('http://192.168.100.130:8000/process_image');

//   // Replace 'image' with the key used in the Flask API for the image file
//   var request = http.MultipartRequest('POST', url)
//     ..files.add(await http.MultipartFile.fromPath('image', imagePath));

//   var response = await request.send();
//   if (response.statusCode == 200) {
//     var responseBody = await response.stream.bytesToString();
//     var responseJson = jsonDecode(responseBody);
//     // Process the response from the Flask API as needed
//     print('Status: ${responseJson['status']}');
//     print('Message: ${responseJson['message']}');
//   } else {
//     print('Error: ${response.statusCode}');
//   }
// }

// Future sendTryyRequest(
//     int id, File frontPath, File backPath, String clothType) async {
//   List<int> frontImageBytes = await File(frontPath.path).readAsBytes();
//   String frontBase64Encode = base64.encode(frontImageBytes);
//   List<int> backimageBytes = await File(backPath.path).readAsBytes();
//   String backbase64Encode = base64.encode(backimageBytes);

// final url = Uri.parse('http://192.168.100.130:8000/tryy');
// final headers = {'Content-Type': 'application/json'};
// final body = jsonEncode({
//   'id': id,
//   'frontPath': "${frontBase64Encode}",
//   'backPath': "${backbase64Encode}",
//   'clothType': clothType,
// });
//   final ioClient = HttpClient()..connectionTimeout = Duration(seconds: 100);
//   final client = IOClient(ioClient);
//   var response = await http.post(
//     Uri.parse("http://192.168.1.3:8050/tryy"),
//     body: jsonEncode({
//       'id': id,
//       'frontPath': "${frontBase64Encode}",
//       'backPath': "${backbase64Encode}",
//       'clothType': clothType,
//     }),
//     headers: {'Content-Type': 'application/json'},
//     //timeout: const Duration(seconds: 30),
//   );

//   //final response = await http.post(url, headers: headers, body: body);

//   if (response.statusCode == 200) {
//     // The response body contains the texture in base64 format
//     return response.body;
//   } else {
//     // Handle the error case
//     throw Exception('Failed to send tryy request: ${response.statusCode}');
//   }
// }

// Call the function to send image to Flask API

//sendImageToAPI('/path/to/image.jpg') // Replace with the actual image file path

Future<Map<String, String>> sendRequest({
  required String id,
  required File frontImage,
  required File backImage,
  required String clothType,
}) async {
  final url = Uri.parse('http://192.168.1.3:8050/tryy');

  final f_imgdata = await frontImage.readAsBytes();
  final b_imgdata = await backImage.readAsBytes();
  final frontPath = base64Encode(f_imgdata);
  final backPath = base64Encode(b_imgdata);

  final body = jsonEncode({
    'id': id,
    'frontPath': frontPath,
    'backPath': backPath,
    'clothType': clothType,
  });

  final response = await http.post(
    url,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    },
    body: body,
  );

  if (response.statusCode != 200) {
    throw Exception('Request failed with status: ${response.statusCode}.');
  }

  if (!response.headers['content-type']!.startsWith('application/json')) {
    throw Exception('Response is not JSON.');
  }

  final data = jsonDecode(response.body);
  return {
    'base': data['base'],
    'status': data['Status'],
  };
}
