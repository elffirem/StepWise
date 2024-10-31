import 'package:step_wise/core/utils/typedefs.dart';
import 'package:step_wise/model/chat_bot/chat_prompt_request_model.dart';
import 'package:step_wise/model/chat_bot/chat_prompt_response_model.dart';

abstract class ChatBotService {
  ResultFuture<ChatPromptResponseModel> sendPrompt(
      ChatPromptRequestModel prompt);

  ResultFuture<ChatPromptResponseModel> interviewPrep(
      ChatPromptRequestModel prompt);
  ResultFuture<ChatPromptResponseModel> languageSkill(
      ChatPromptRequestModel prompt);
  ResultFuture<ChatPromptResponseModel> resume(
      ChatPromptRequestModel prompt);
  ResultFuture<ChatPromptResponseModel> coverLetter(
      ChatPromptRequestModel prompt);
  ResultFuture<ChatPromptResponseModel> emailResponse(
      ChatPromptRequestModel prompt);
  ResultFuture<ChatPromptResponseModel> writeCaption(
      ChatPromptRequestModel prompt);
}
