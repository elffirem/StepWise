// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roadmap_topic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoadmapTopic _$RoadmapTopicFromJson(Map<String, dynamic> json) => RoadmapTopic(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      resources: (json['resources'] as List<dynamic>?)
          ?.map((e) => RoadmapResource.fromJson(e as Map<String, dynamic>))
          .toList(),
      isChecked: json['isChecked'] as bool? ?? false,
    );

Map<String, dynamic> _$RoadmapTopicToJson(RoadmapTopic instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'resources': instance.resources,
      'isChecked': instance.isChecked,
    };
