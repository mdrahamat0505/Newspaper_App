import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';
part 'source.g.dart';

@HiveType(typeId: 3)
@JsonSerializable()
class Source {
  Source({this.id = '', required this.name});
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;

  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);

  Map<String, dynamic> toJson() => _$SourceToJson(this);
}
