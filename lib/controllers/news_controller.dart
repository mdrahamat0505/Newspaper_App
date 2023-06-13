import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newspaper_app/dao/article_dao.dart';
import 'package:newspaper_app/models/artical_model.dart';
import 'package:newspaper_app/models/news_model.dart';

import 'package:http/http.dart' as http;
import 'package:newspaper_app/service/internet_connection.dart';

class NewsController extends GetxController {
  ScrollController scrollController = ScrollController();
  List<ArticleModel> news = <ArticleModel>[].toSet().toList();
  dynamic isSwitched = false.obs;
  dynamic isPageLoading = false.obs;
  RxInt pageSize = 10.obs;

  final isLoadingValue = RxBool(false);
  final newsList = RxList<ArticleModel>([]);
  //final newsListLocal = RxList<ArticleModel>([]);
  final isLoadingLocal = RxBool(false);
  RxBool notFound = false.obs;
  final databaseReference = ArticleDao();
  final checkList = RxList<ArticleModel>([]);

  final isPublisheRead = RxString('');

  String baseApi = "https://newsapi.org/v2/top-headlines?";
  String apiKey = "2638cc7ff4b94a488a46fa7642c06097";

  @override
  void onInit() {
    scrollController = new ScrollController()..addListener(_scrollListener);
    getDataFrom();
    ArticleDao().readData();
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    ArticleDao().readData();
    ArticleDao().publisheRead();
    //selectNewsCheck();
    super.onReady();
  }

  _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      isLoadingLocal.value = true;
      getDataFrom();
    }
  }

  selectNewsCheck() {
    if (databaseReference.list != null) {
      try {
        for (int i = 0; i <= newsList.value.length; i++) {
          for (int j = 0; j <= databaseReference.list.length; j++) {
            if (newsList.value[i].publishedAt!.isNotEmpty) ;
            if (newsList.value[i].publishedAt ==
                databaseReference.list[i].publishedAt) {
              checkList.value.add(databaseReference.list[j]);
            }
          }
        }
      } catch (e) {}

      // databaseReference
      //     .list.isNotEmpty &&
      //     newsC.newsList.value[index]
      //         .publishedAt ==
      //         databaseReference
      //             .list[index]
      //             .publishedAt)
    }
  }

  getDataFrom() async {
    isLoadingValue.value = true;
    final connectivityResult = await InternetConnection.isConnectedToInternet();
    if (connectivityResult) {
      newsList.clear();
      var now = DateTime.now();

      var date = DateFormat('yyyy-MM-dd')
          .format(DateTime(now.year, now.month - 1, now.day));

      var url =
          "https://newsapi.org/v2/everything?q=tesla&from=$date&sortBy=publishedAt&apiKey=2638cc7ff4b94a488a46fa7642c06097";

      var url1 =
          "https://newsapi.org/v2/everything?q=tesla&from=$date&sortBy=publishedAt&apiKey=2638cc7ff4b94a488a46fa7642c06097";
      var url4 ="https://newsapi.org/v2/top-headlines?country=us&apiKey=2638cc7ff4b94a488a46fa7642c06097";

      // var url1 =
      //     "https://newsapi.org/v2/everything?q=tesla&from=$date&sortBy=publishedAt&apiKey=2638cc7ff4b94a488a46fa7642c06097";

      var url3 =
          "https://newsapi.org/v2/everything?q=tesla&from=$date&sortBy=publishedAt&apiKey=2638cc7ff4b94a488a46fa7642c06097";

      // update();

      http.Response res = await http.get(Uri.parse(url4));

      if (res.statusCode == 200) {
        String data = res.body;
        var jsonData = jsonDecode(data);

        NewsModel newsData = NewsModel.fromJson(jsonData);

        if (newsData.articles?.length != 0) {
          newsList.value.addAll(newsData.articles as dynamic);
          news.addAll(newsData.articles as dynamic);
          //scrollController.jumpTo(0.0);

          try {
            final articleNews = Hive.box('articleNews_list');
            articleNews.clear();
            articleNews.put('articleNews_list', news);
          } catch (e) {}
          isLoadingValue.value = false;
        } else {
          notFound.value = false;
          isLoadingValue.value = false;
          newsList.clear();
          update();
        }
      } else {
        notFound.value = true;
        isLoadingValue.value = false;
        newsList.clear();
        update();
      }
    } else {
      try {
        final articleNews = Hive.box('articleNews_list');
        final data = articleNews.get('articleNews_list');
        if (data != null) {
          newsList.value.addAll(data);
          isLoadingValue.value = false;
          update();
        }
      } catch (e) {}
    }
  }
}
