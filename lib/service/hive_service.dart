import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:newspaper_app/models/artical_model.dart';
import 'package:newspaper_app/models/news_model.dart';
import 'package:newspaper_app/models/source.dart';
import 'package:path_provider/path_provider.dart';

class HiveService extends GetxService {
  Future<void> onInitHive() async {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();
    Directory appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);

    Hive.openBox('articleNews_list');
    Hive.registerAdapter(ArticleModelAdapter(), override: true); //2
    Hive.registerAdapter(SourceAdapter(), override: true); //3
    Hive.registerAdapter(NewsModelAdapter(), override: true); //4

    log('Hive initialized onInitForApp');
  }
}
