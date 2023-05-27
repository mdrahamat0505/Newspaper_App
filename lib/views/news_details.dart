import 'package:flutter/material.dart';

class NewsDetails extends StatefulWidget {
  final newsUrl;
  const NewsDetails({Key? key, this.newsUrl}) : super(key: key);

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(centerTitle: true, title: Text("News")),
        body: const SizedBox(),
      ),
    );
  }
}
