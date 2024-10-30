// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_prompt_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatPromptResponseModel _$ChatPromptResponseModelFromJson(
        Map<String, dynamic> json) =>
    ChatPromptResponseModel(
      message: json['message'] as String?,
      initialTopic: json['initialTopic'] as String?,
      sessionId: (json['sessionId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ChatPromptResponseModelToJson(
        ChatPromptResponseModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'initialTopic': instance.initialTopic,
      'sessionId': instance.sessionId,
    };
