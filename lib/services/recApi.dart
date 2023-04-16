import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:http/http.dart' as http;

Future<void> makeHttpRequest() async {
  Uri link = Uri.parse("https://www.youtube.com/");
  final response = await http.get(link); // Replace with your server URL
  if (response.statusCode == 200) {
    // Handle the successful response here
    print('HTTP request successful!');
    print('Response: ${response.body}');
  } else {
    // Handle any errors that occurred during the request
    print('HTTP request failed with status code: ${response.statusCode}');
  }
}

class RecommApi extends StatelessWidget {
  const RecommApi({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
