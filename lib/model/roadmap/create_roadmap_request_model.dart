import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'create_roadmap_request_model.g.dart';

@JsonSerializable()
class CreateRoadmapRequestModel extends INetworkModel<CreateRoadmapRequestModel>
    with EquatableMixin {
  CreateRoadmapRequestModel({
    this.professionalBackground,
    this.goal,
  });

  final String? professionalBackground;
  final String? goal;

  @override
  CreateRoadmapRequestModel fromJson(Map<String, dynamic> json) =>
      CreateRoadmapRequestModel.fromJson(json);

  factory CreateRoadmapRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CreateRoadmapRequestModelFromJson(json);

  @override
  Map<String, dynamic>? toJson() => _$CreateRoadmapRequestModelToJson(this);

  @override
  List<Object?> get props => [professionalBackground, goal];

  CreateRoadmapRequestModel copyWith({
    String? professionalBackground,
    String? goal,
  }) {
    return CreateRoadmapRequestModel(
      professionalBackground:
          professionalBackground ?? this.professionalBackground,
      goal: goal ?? this.goal,
    );
  }
}
