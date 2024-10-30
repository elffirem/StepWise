import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'chat_prompt_request_model.g.dart';

@JsonSerializable()
class ChatPromptRequestModel extends INetworkModel<ChatPromptRequestModel>
    with EquatableMixin {
  ChatPromptRequestModel({
    this.prompt,
    this.sessionId,
  });

  final String? prompt;
  final int? sessionId;

  @override
  ChatPromptRequestModel fromJson(Map<String, dynamic> json) =>
      ChatPromptRequestModel.fromJson(json);

  factory ChatPromptRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ChatPromptRequestModelFromJson(json);

  @override
  Map<String, dynamic>? toJson() => _$ChatPromptRequestModelToJson(this);

  @override
  List<Object?> get props => [prompt, sessionId];

  ChatPromptRequestModel copyWith({
    String? prompt,
    int? sessionId,
  }) {
    return ChatPromptRequestModel(
      prompt: prompt ?? this.prompt,
      sessionId: sessionId ?? this.sessionId,
    );
  }
}
