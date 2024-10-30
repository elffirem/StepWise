// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_prompt_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatPromptRequestModel _$ChatPromptRequestModelFromJson(
        Map<String, dynamic> json) =>
    ChatPromptRequestModel(
      prompt: json['prompt'] as String?,
      sessionId: (json['sessionId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ChatPromptRequestModelToJson(
        ChatPromptRequestModel instance) =>
    <String, dynamic>{
      'prompt': instance.prompt,
      'sessionId': instance.sessionId,
    };
