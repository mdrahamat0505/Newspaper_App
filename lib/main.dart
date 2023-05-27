import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newspaper_app/service/hive_service.dart';
import 'package:newspaper_app/views/welcome_screen.dart';
import 'controllers/config_controller.dart';

//    git

//2638cc7ff4b94a488a46fa7642c06097  api key

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   //await Firebase.initializeApp();
//   await Get.put(ConfigController()).initAppConfig();
//   runApp(MyApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Get.put(HiveService()).onInitHive();
  await Get.put(ConfigController()).initAppConfig();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Newspaper',
      theme: ThemeData(primaryColor: Colors.white),
      home: const WelcomeScreen(),
    );
  }
}
