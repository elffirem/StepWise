// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roadmap_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoadmapModel _$RoadmapModelFromJson(Map<String, dynamic> json) => RoadmapModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      phases: (json['phases'] as List<dynamic>?)
          ?.map((e) => RoadmapPhase.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RoadmapModelToJson(RoadmapModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'phases': instance.phases,
    };
