import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:net_kit/net_kit.dart';

import 'roadmap_phase.dart';

part 'roadmap_model.g.dart';

@JsonSerializable()
class RoadmapModel extends INetKitModel with EquatableMixin {
  final int? id;
  final String? title;
  final String? description;
  final List<RoadmapPhase>? phases;

  RoadmapModel({
    this.id,
    this.title,
    this.description,
    this.phases,
  });

  @override
  RoadmapModel fromJson(Map<String, dynamic> json) =>
      RoadmapModel.fromJson(json);

  factory RoadmapModel.fromJson(Map<String, dynamic> json) =>
      _$RoadmapModelFromJson(json);

  @override
  Map<String, dynamic>? toJson() => _$RoadmapModelToJson(this);

  @override
  List<Object?> get props => [id, title, description, phases];

  RoadmapModel copyWith({
    int? id,
    String? title,
    String? description,
    List<RoadmapPhase>? phases,
  }) {
    return RoadmapModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      phases: phases ?? this.phases,
    );
  }
}
