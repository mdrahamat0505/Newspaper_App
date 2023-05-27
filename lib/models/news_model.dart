import 'package:json_annotation/json_annotation.dart';
import 'package:newspaper_app/models/artical_model.dart';
import 'package:hive/hive.dart';
part 'news_model.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 4)
class NewsModel {
  NewsModel({this.status, this.totalResults, this.articles});
  @HiveField(0)
  String? status;
  @HiveField(1)
  int? totalResults;
  @HiveField(2)
  List<ArticleModel>? articles;

  factory NewsModel.fromJson(Map<String, dynamic> json) =>
      _$NewsModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsModelToJson(this);
}
