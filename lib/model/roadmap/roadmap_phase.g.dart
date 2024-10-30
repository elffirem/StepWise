// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roadmap_phase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoadmapPhase _$RoadmapPhaseFromJson(Map<String, dynamic> json) => RoadmapPhase(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      duration: json['duration'] as String?,
      imageUrl: json['imageUrl'] as String?,
      topics: (json['topics'] as List<dynamic>?)
          ?.map((e) => RoadmapTopic.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RoadmapPhaseToJson(RoadmapPhase instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'duration': instance.duration,
      'imageUrl': instance.imageUrl,
      'topics': instance.topics,
    };
