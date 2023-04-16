import 'dart:convert';
import 'package:http/http.dart' as http;

// Function to send image file to Flask API for processing
Future<void> sendImageToAPI(String imagePath) async {
  // Replace the API endpoint with the correct URL of your Flask API
  var url = Uri.parse('http://example.com/process_image');

  // Replace 'image' with the key used in the Flask API for the image file
  var request = http.MultipartRequest('POST', url)
    ..files.add(await http.MultipartFile.fromPath('image', imagePath));

  var response = await request.send();
  if (response.statusCode == 200) {
    var responseBody = await response.stream.bytesToString();
    var responseJson = jsonDecode(responseBody);
    // Process the response from the Flask API as needed
    print('Status: ${responseJson['status']}');
    print('Message: ${responseJson['message']}');
  } else {
    print('Error: ${response.statusCode}');
  }
}

// Call the function to send image to Flask API

//sendImageToAPI('/path/to/image.jpg') // Replace with the actual image file path