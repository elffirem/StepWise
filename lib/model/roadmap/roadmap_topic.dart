import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:net_kit/net_kit.dart';

import 'roadmap_resource.dart';

part 'roadmap_topic.g.dart';

@JsonSerializable()
class RoadmapTopic extends INetKitModel with EquatableMixin {
  final int? id;
  final String? title;
  final String? description;
  final List<RoadmapResource>? resources;
  final RxBool isChecked;

  RoadmapTopic({
    this.id,
    this.title,
    this.description,
    this.resources,
    bool isChecked = false,
  }) : isChecked = RxBool(isChecked);

  @override
  RoadmapTopic fromJson(Map<String, dynamic> json) =>
      RoadmapTopic.fromJson(json);

  factory RoadmapTopic.fromJson(Map<String, dynamic> json) =>
      _$RoadmapTopicFromJson(json);

  @override
  Map<String, dynamic>? toJson() => _$RoadmapTopicToJson(this);

  @override
  List<Object?> get props => [id, title, description, resources, isChecked];

  RoadmapTopic copyWith({
    int? id,
    String? title,
    String? description,
    List<RoadmapResource>? resources,
    bool? isChecked,
  }) {
    return RoadmapTopic(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      resources: resources ?? this.resources,
      isChecked: isChecked ?? this.isChecked.value,
    );
  }
}
