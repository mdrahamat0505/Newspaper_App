import 'package:json_annotation/json_annotation.dart';
import 'package:newspaper_app/models/source.dart';
import 'package:hive/hive.dart';

part 'artical_model.g.dart';

@HiveType(typeId: 2)
@JsonSerializable(explicitToJson: true)
class ArticleModel {
  @HiveField(0)
  String? author;
  @HiveField(1)
  String? description;
  @HiveField(2)
  String? urlToImage;
  @HiveField(3)
  String? content;
  @HiveField(4)
  String? title;
  @HiveField(5)
  String? url;
  @HiveField(6)
  String? publishedAt;
  @HiveField(7)
  Source? source;
  @HiveField(8)
  bool? favorite;

  ArticleModel({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
    this.favorite,
  });
  //
  // factory ArticleModel.fromJson(Map<String, dynamic> json) =>
  //     _$ArticleModelFromJson(json);

  ArticleModel.fromJson(Map<String, dynamic> json) {
    try {
      source = (json['source'] == null
          ? null
          : json['source']
              .map((e) => Source.fromJson(e as Map<String, dynamic>))
              .toList());
    } catch (e) {}
    author = json['author'] as String?;
    title = json['title'] as String;
    description = json['description'] as String?;
    url = json['url'] as String;
    urlToImage = json['urlToImage'] as String?;
    publishedAt = json['publishedAt'] as String;
    content = json['content'] as String;
  }

  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);
}
