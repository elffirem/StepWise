// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mental_roadmap_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MentalRoadmapModel _$MentalRoadmapModelFromJson(Map<String, dynamic> json) =>
    MentalRoadmapModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      mood: json['mood'] as String?,
      time: json['time'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$MentalRoadmapModelToJson(MentalRoadmapModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'mood': instance.mood,
      'time': instance.time,
      'createdAt': instance.createdAt,
    };
