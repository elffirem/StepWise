import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'mental_roadmap_model.g.dart';

@JsonSerializable()
class MentalRoadmapModel extends INetworkModel<MentalRoadmapModel>
    with EquatableMixin {
  MentalRoadmapModel({
    this.id,
    this.title,
    this.description,
    this.mood,
    this.time,
    this.createdAt,
  });

  final int? id;
  final String? title;
  final String? description;
  final String? mood;
  final String? time;
  final String? createdAt;

  @override
  MentalRoadmapModel fromJson(Map<String, dynamic> json) =>
      MentalRoadmapModel.fromJson(json);

  factory MentalRoadmapModel.fromJson(Map<String, dynamic> json) =>
      _$MentalRoadmapModelFromJson(json);

  @override
  Map<String, dynamic>? toJson() => _$MentalRoadmapModelToJson(this);

  @override
  List<Object?> get props => [id, title, description, mood, time, createdAt];

  MentalRoadmapModel copyWith({
    int? id,
    String? title,
    String? description,
    String? mood,
    String? time,
    String? createdAt,
  }) {
    return MentalRoadmapModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      mood: mood ?? this.mood,
      time: time ?? this.time,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
