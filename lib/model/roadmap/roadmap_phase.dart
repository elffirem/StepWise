import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:net_kit/net_kit.dart';

import 'roadmap_topic.dart';

part 'roadmap_phase.g.dart';

@JsonSerializable()
class RoadmapPhase extends INetKitModel with EquatableMixin {
  final int? id;
  final String? title;
  final String? duration;
  final String? imageUrl;
  final List<RoadmapTopic>? topics;

  RoadmapPhase({
    this.id,
    this.title,
    this.duration,
    this.imageUrl,
    this.topics,
  });

  @override
  RoadmapPhase fromJson(Map<String, dynamic> json) =>
      RoadmapPhase.fromJson(json);

  factory RoadmapPhase.fromJson(Map<String, dynamic> json) =>
      _$RoadmapPhaseFromJson(json);

  @override
  Map<String, dynamic>? toJson() => _$RoadmapPhaseToJson(this);

  @override
  List<Object?> get props => [id, title, duration, imageUrl, topics];

  RoadmapPhase copyWith({
    int? id,
    String? title,
    String? duration,
    String? imageUrl,
    List<RoadmapTopic>? topics,
  }) {
    return RoadmapPhase(
      id: id ?? this.id,
      title: title ?? this.title,
      duration: duration ?? this.duration,
      imageUrl: imageUrl ?? this.imageUrl,
      topics: topics ?? this.topics,
    );
  }
}
