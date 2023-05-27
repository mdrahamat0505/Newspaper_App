import 'dart:convert';

import 'package:newspaper_app/config/base.dart';
import 'package:newspaper_app/controllers/news_controller.dart';
import 'package:newspaper_app/models/news_model.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApiService with Base {
  String baseApi = "https://newsapi.org/v2/top-headlines?";

  NewsController newsController = NewsController();
}
