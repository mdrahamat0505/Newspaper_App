import 'dart:io';

import 'package:get/get.dart';
import 'package:newspaper_app/dao/article_dao.dart';
import 'package:newspaper_app/service/hive_service.dart';
import '../config/base.dart';
import '../service/http_overrides_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ConfigController extends GetxController with Base {
  Future<void> initAppConfig() async {
    WidgetsFlutterBinding.ensureInitialized();
    HttpOverrides.global = THttpOverrides();
  }
}
