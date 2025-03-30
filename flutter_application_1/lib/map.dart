import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_application_1/police.dart';

void main() {
  runApp(MyAppMap());
}

class MyAppMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WebPage(),
    );
  }
}

class WebPage extends StatefulWidget {
  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // Включаем JS
      ..loadRequest(Uri.parse('https://imaginative-manatee-9b1e79.netlify.app/')); // Замени на свой сайт
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Карта"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HelpOptionsScreen()),
                );
              },
        ),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
