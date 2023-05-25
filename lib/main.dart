import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newspaper_app/views/home.dart';

//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        ---- key git

//2638cc7ff4b94a488a46fa7642c06097  api key

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: Colors.white),
      home: const Home(),
    );
  }
}
