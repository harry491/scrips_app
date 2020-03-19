import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BlogWeb extends StatefulWidget {
  final String url;
  final String title;

  BlogWeb({this.url, this.title});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BlogWebState();
  }
}

class BlogWebState extends State<BlogWeb> {
  WebViewController _webViewController;

  String _title;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text(_title ?? ""),
        ),
        body: WebView(
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (web) {
              _webViewController = web;
            },
            onPageStarted: (url){
              print("start-"+url);
            },
            debuggingEnabled: true,
            onPageFinished: (url) {
              print("finish-"+url);
              _webViewController
                  .evaluateJavascript("document.title")
                  .then((result) {
                setState(() {
                  _title = result;
                });
              });
            }));
  }
}
