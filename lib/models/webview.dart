import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MyWebView extends StatefulWidget {
  @override
  _MyWebViewState createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  InAppWebViewController? _webViewController;
  String _url = 'http://127.0.0.1:8000/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My WebView'),
      ),
      body: Container(
        child: InAppWebView(
          initialUrlRequest: URLRequest(
            url: Uri.parse(_url),
          ),
          onWebViewCreated: (InAppWebViewController controller) {
            _webViewController = controller;
          },
          onLoadStart: (InAppWebViewController controller, Uri? uri) {},
          onLoadStop: (InAppWebViewController controller, Uri? uri) {},
          onProgressChanged:
              (InAppWebViewController controller, int progress) {},
        ),
      ),
    );
  }
}
