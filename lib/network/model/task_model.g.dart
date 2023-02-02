// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => TaskModel(
      albumId: json['albumId'] as int,
      id: json['id'] as int,
      titile: json['titile'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
    );

Map<String, dynamic> _$TaskModelToJson(TaskModel instance) => <String, dynamic>{
      'albumId': instance.albumId,
      'id': instance.id,
      'titile': instance.titile,
      'url': instance.url,
      'thumbnailUrl': instance.thumbnailUrl,
    };
