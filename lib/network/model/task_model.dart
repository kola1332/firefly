import 'package:json_annotation/json_annotation.dart';

part 'task_model.g.dart';

@JsonSerializable()
class TaskModel {
  int albumId;
  int id;
  String titile;
  String url;
  String thumbnailUrl;

  TaskModel({
    required this.albumId,
    required this.id,
    required this.titile,
    required this.url,
    required this.thumbnailUrl,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);
}
