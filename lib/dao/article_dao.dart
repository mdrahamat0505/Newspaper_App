import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:newspaper_app/config/base.dart';
import 'package:newspaper_app/controllers/news_controller.dart';
import 'package:newspaper_app/models/artical_model.dart';
import 'package:get/get.dart';

class ArticleDao {
  final databaseReference = FirebaseDatabase.instance.ref('article');

  final isLoadingVal = RxBool(false);
  final list = RxList<ArticleModel>([]);
  int number = 0;
  void saveMessage(ArticleModel articleModel) {
    if (list.isNotEmpty) {
      try {
        for (int i = 0; i < list.length; i++) {
          if (list[i].title?.replaceAll(' ', '') !=
              articleModel.title?.replaceAll(' ', '')) {
            databaseReference.push().set(articleModel.toJson());
          } else {
            Get.snackbar(
              'Attention!!',
              'Already save new.',
              colorText: Colors.red,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.white,
            );
          }
        }
      } catch (e) {}
    } else {
      databaseReference.push().set(articleModel.toJson());
    }

    try {
      readData();
    } catch (e) {}
  }

  // void saveMessage(String publishedAt) {
  //   databaseReference.push().set(articleModel.toJson());
  // }

  void publishedAt(String publishedAt) {
    databaseReference.push().set(
      {number: publishedAt},
    );
  }

  Query getMessageQuery() {
    return databaseReference;
  }

  void publisheRead() {
    databaseReference.get().then((snapshot) {
      var articleData = snapshot;
      if (snapshot.value != null) {
        //final numberValue = snapshot.value as Map<dynamic, dynamic>;

        final numbervalue = Map<String, dynamic>.from(snapshot.value as Map);

        if (numbervalue.isNotEmpty) {
          for (dynamic type in numbervalue.keys) {
            for (dynamic value in numbervalue.values) {
              // if (numbervalue.values == 2) {
              //   if (number == type) {
              //     NewsController().isPublisheRead.value = value;
              //   }
              // }
            }
          }
        }
      }
    });
  }

  void readData() {
    //  list.clear();
    isLoadingVal.value = true;
    // NewsController().newsListLocal.clear();

    databaseReference.get().then(
      (snapshot) {
        var articleData = snapshot;
        if (snapshot.value != null) {
          isLoadingVal.value = true;
          try {
            final Map<String, dynamic> newsjson = Map<String, dynamic>();
            //final json = snapshot.value as Map<dynamic, dynamic>;

            final json = Map<String, dynamic>.from(snapshot.value as Map);

            json.forEach((key, value) {
              //vale((kea, valu)=>newss[kea] = vale.toString());
              value.forEach((newKey, newValue) {
                if (newKey == 'source') {
                  newsjson[newKey] = newValue;
                } else {
                  newsjson[newKey.toString()] = newValue;
                }
              });
              isLoadingVal.value = false;
              final message =
                  ArticleModel.fromJson(newsjson as Map<String, dynamic>);
              list.value.add(message);
              //NewsController().newsListLocal.value = list;
              isLoadingVal.value = false;
              NewsController().update();
            });
          } catch (e) {
            isLoadingVal.value = false;

            list.clear();
            log('$e');
          }
        }

        //return message;
      },
    );
  }

  // void readData() {
  //   databaseReference.once().then((ArticleModel articleModel) {});
  // }
}

class KeyValue {
  dynamic name;
  dynamic age;

  KeyValue(this.name, this.age);

  @override
  String toString() {
    return '{ ${this.name}, ${this.age} }';
  }
}
