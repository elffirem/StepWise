import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:net_kit/net_kit.dart';

part 'roadmap_resource.g.dart';

@JsonSerializable()
class RoadmapResource extends INetKitModel with EquatableMixin {
  final int? id;
  final String? type;
  final String? title;
  final String? link;
  final String? provider;
  final String? description;

  RoadmapResource({
    this.id,
    this.type,
    this.title,
    this.link,
    this.provider,
    this.description,
  });

  @override
  RoadmapResource fromJson(Map<String, dynamic> json) =>
      RoadmapResource.fromJson(json);

  factory RoadmapResource.fromJson(Map<String, dynamic> json) =>
      _$RoadmapResourceFromJson(json);

  @override
  Map<String, dynamic>? toJson() => _$RoadmapResourceToJson(this);

  @override
  List<Object?> get props => [id, type, title, link, provider, description];

  RoadmapResource copyWith({
    int? id,
    String? type,
    String? title,
    String? link,
    String? provider,
    String? description,
  }) {
    return RoadmapResource(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      link: link ?? this.link,
      provider: provider ?? this.provider,
      description: description ?? this.description,
    );
  }
}
