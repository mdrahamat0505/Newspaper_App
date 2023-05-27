import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewNews extends StatefulWidget {
  final newsUrl;

  const ViewNews({Key? key, this.newsUrl}) : super(key: key);

  @override
  State<ViewNews> createState() => _ViewNewsState();
}

class _ViewNewsState extends State<ViewNews> {
  late final WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(centerTitle: true, title: Text("News")),
        body: WebView(
          initialUrl: widget.newsUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller = webViewController;
          },
        ),
      ),
    );
  }
}
