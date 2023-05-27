// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artical_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ArticleModelAdapter extends TypeAdapter<ArticleModel> {
  @override
  final int typeId = 2;

  @override
  ArticleModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ArticleModel(
      source: fields[7] as Source?,
      author: fields[0] as String?,
      title: fields[4] as String?,
      description: fields[1] as String?,
      url: fields[5] as String?,
      urlToImage: fields[2] as String?,
      publishedAt: fields[6] as String?,
      content: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ArticleModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.author)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.urlToImage)
      ..writeByte(3)
      ..write(obj.content)
      ..writeByte(4)
      ..write(obj.title)
      ..writeByte(5)
      ..write(obj.url)
      ..writeByte(6)
      ..write(obj.publishedAt)
      ..writeByte(7)
      ..write(obj.source);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArticleModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleModel _$ArticleModelFromJson(Map<String, dynamic> json) => ArticleModel(
      source: json['source'] == null
          ? null
          : Source.fromJson(json['source'] as Map<String, dynamic>),
      author: json['author'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      url: json['url'] as String?,
      urlToImage: json['urlToImage'] as String?,
      publishedAt: json['publishedAt'] as String?,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$ArticleModelToJson(ArticleModel instance) =>
    <String, dynamic>{
      'author': instance.author,
      'description': instance.description,
      'urlToImage': instance.urlToImage,
      'content': instance.content,
      'title': instance.title,
      'url': instance.url,
      'publishedAt': instance.publishedAt,
      'source': instance.source?.toJson(),
    };
