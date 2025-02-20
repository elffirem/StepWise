import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:net_kit/net_kit.dart';

part 'chat_prompt_response_model.g.dart';

@JsonSerializable()
class ChatPromptResponseModel extends INetKitModel with EquatableMixin {
  ChatPromptResponseModel({
    this.message,
    this.initialTopic,
    this.sessionId,
  });

  final String? message;
  final String? initialTopic;
  final int? sessionId;

  @override
  ChatPromptResponseModel fromJson(Map<String, dynamic> json) =>
      ChatPromptResponseModel.fromJson(json);

  factory ChatPromptResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ChatPromptResponseModelFromJson(json);

  @override
  Map<String, dynamic>? toJson() => _$ChatPromptResponseModelToJson(this);

  @override
  List<Object?> get props => [message, initialTopic, sessionId];

  ChatPromptResponseModel copyWith({
    String? message,
    String? initialTopic,
    int? sessionId,
  }) {
    return ChatPromptResponseModel(
      message: message ?? this.message,
      initialTopic: initialTopic ?? this.initialTopic,
      sessionId: sessionId ?? this.sessionId,
    );
  }
}
