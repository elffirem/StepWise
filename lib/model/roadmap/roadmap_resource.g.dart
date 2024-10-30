// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roadmap_resource.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoadmapResource _$RoadmapResourceFromJson(Map<String, dynamic> json) =>
    RoadmapResource(
      id: (json['id'] as num?)?.toInt(),
      type: json['type'] as String?,
      title: json['title'] as String?,
      link: json['link'] as String?,
      provider: json['provider'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$RoadmapResourceToJson(RoadmapResource instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'title': instance.title,
      'link': instance.link,
      'provider': instance.provider,
      'description': instance.description,
    };
