import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newspaper_app/config/base.dart';
import 'package:get/get.dart';
import 'package:newspaper_app/dao/article_dao.dart';
import 'package:newspaper_app/views/view_news.dart';
import 'news_details.dart';

class BookmarkedScreen extends StatefulWidget {
  const BookmarkedScreen({Key? key}) : super(key: key);

  @override
  State<BookmarkedScreen> createState() => _BookmarkedScreenState();
}

class _BookmarkedScreenState extends State<BookmarkedScreen> with Base {
  final local = ArticleDao();

  @override
  void initState() {
    local.list.clear();
    local.readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Bookmarked News"),
      ),
      body: Obx(
        () => local.isLoadingVal.value == true
            ? const Center(child: CircularProgressIndicator())
            : local.list.isNotEmpty
                ? ListView.builder(
                    itemCount: local.list.length,
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
                                onTap: () => Get.to(
                                    ViewNews(newsUrl: local.list[index].url)),
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
                                              '${local.list[index].title}',
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
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Stack(
                                        children: [
                                          local.list[index].urlToImage == null
                                              ? Container()
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: CachedNetworkImage(
                                                    placeholder: (context,
                                                            url) =>
                                                        const CircularProgressIndicator(),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
                                                    imageUrl: local.list[index]
                                                            .urlToImage ??
                                                        '',
                                                  ),
                                                ),
                                          local.list[index].source?.name != null
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
                                                        local.list[index].source
                                                                    ?.name !=
                                                                null
                                                            ? "${local.list[index].source?.name}"
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
                                      Text('${local.list[index].description}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          index == local.list.length - 1 &&
                                  local.isLoadingVal.value == true
                              ? const Center(child: CircularProgressIndicator())
                              : const SizedBox(),
                        ],
                      );
                    },
                  )
                : Center(
                    child: Text('News not found!'),
                  ),
      ),
    ));
  }
}
