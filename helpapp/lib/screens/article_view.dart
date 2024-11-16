import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
String blogUrl;
ArticleView({required this.blogUrl});

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         backgroundColor:
            const Color.fromARGB(255, 58, 57, 57),

        title: 
            
            Text(
              "News",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
      child: WebView(
        initialUrl:widget.blogUrl ,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    ));
  }
}