import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newspaper_app/controllers/news_controller.dart';
import 'package:get/get.dart';
import 'package:newspaper_app/views/view_news.dart';
import '../config/base.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with Base {
  @override
  void initState() {
    // TODO: implement initState
    NewsController().getDataFrom();
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
              newsC.country.value = '';
              newsC.category.value = '';
              newsC.findNews.value = '';
              newsC.cName.value = '';
              newsC.getDataFrom();
              newsC.update();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
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
                          elevation: 5,
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
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                      onPressed: () => setState(() {}),
                                      icon: const Icon(Icons.favorite_border),
                                    ),
                                  ),
                                  Stack(children: [
                                    newsC.newsList.value[index].urlToImage ==
                                            null
                                        ? Container()
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: CachedNetworkImage(
                                              placeholder: (context, url) =>
                                                  Container(
                                                      child:
                                                          const CircularProgressIndicator()),
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
                                    Positioned(
                                      bottom: 8,
                                      right: 8,
                                      child: Card(
                                        elevation: 0,
                                        color: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.8),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 8),
                                          child: Text(
                                              "${newsC.newsList.value[index].source.name}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2),
                                        ),
                                      ),
                                    ),
                                  ]),
                                  const Divider(),
                                  Text(newsC.newsList.value[index].title,
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
                //itemCount: controller.newsList.value.length,
              ),
      ),
    );
  }
}
