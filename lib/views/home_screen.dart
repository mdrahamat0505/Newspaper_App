import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newspaper_app/components/sideDrawer.dart';
import 'package:newspaper_app/controllers/news_controller.dart';
import 'package:get/get.dart';
import 'package:newspaper_app/dao/article_dao.dart';
import 'package:newspaper_app/views/view_news.dart';
import '../config/base.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with Base {
  final databaseReference = ArticleDao();

  @override
  void initState() {
    // TODO: implement initState
    NewsController().getDataFrom();
    databaseReference.readData();
    databaseReference.publisheRead();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Newspaper"),
        actions: [
          IconButton(
            onPressed: () {
              // newsC.country.value = '';
              // newsC.category.value = '';
              // newsC.findNews.value = '';
              // newsC.cName.value = '';
              newsC.getDataFrom();
              databaseReference.readData();
              newsC.selectNewsCheck();
              newsC.update();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      drawer: sideDrawer(),
      body: Obx(
        () => newsC.isLoadingValue.value
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: newsC.newsList.value.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: GestureDetector(
                            onTap: () => Get.to(ViewNews(
                                newsUrl: newsC.newsList.value[index].url)),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${newsC.newsList.value[index].title}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 0,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: IconButton(
                                            onPressed: () {
                                              try {
                                                databaseReference.saveMessage(
                                                    newsC
                                                        .newsList.value[index]);
                                              } catch (e) {
                                                log('e');
                                              }

                                              // try {
                                              //   databaseReference.publishedAt(
                                              //       newsC.newsList.value[index]
                                              //           .publishedAt
                                              //           .toString());
                                              // } catch (e) {}
                                            },
                                            icon: const Icon(
                                                Icons.favorite_border),

                                            // icon: newsC.newsListLocal.value != 0
                                            //     ? (newsC.newsList.value[index]
                                            //                 .publishedAt !=
                                            //             newsC.newsListLocal
                                            //                 .value[index].publishedAt)
                                            //         ? const Icon(
                                            //             Icons.favorite_border)
                                            //         : const Icon(Icons.favorite)
                                            //     : const Icon(Icons.favorite_border),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Stack(
                                    children: [
                                      newsC.newsList.value[index].urlToImage ==
                                              null
                                          ? Container()
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: CachedNetworkImage(
                                                placeholder: (context, url) =>
                                                    const CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                                imageUrl: newsC
                                                        .newsList
                                                        .value[index]
                                                        .urlToImage ??
                                                    '',
                                              ),
                                            ),
                                      newsC.newsList.value[index].source
                                                  ?.name !=
                                              null
                                          ? Positioned(
                                              bottom: 8,
                                              right: 8,
                                              child: Card(
                                                elevation: 0,
                                                color: Theme.of(context)
                                                    .primaryColor
                                                    .withOpacity(0.8),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10,
                                                      vertical: 8),
                                                  child: Text(
                                                    newsC.newsList.value[index]
                                                                .source?.name !=
                                                            null
                                                        ? "${newsC.newsList.value[index].source?.name}"
                                                        : '',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle2,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : const SizedBox(),
                                    ],
                                  ),
                                  const Divider(),
                                  Text(
                                      '${newsC.newsList.value[index].description}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      index == newsC.newsList.value.length - 1 &&
                              newsC.isLoadingValue == true
                          ? const Center(child: CircularProgressIndicator())
                          : const SizedBox(),
                    ],
                  );
                },
              ),
      ),
    );
  }
}
