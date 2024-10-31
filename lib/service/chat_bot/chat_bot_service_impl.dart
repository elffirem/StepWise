import 'package:step_wise/core/constants/api_const.dart';
import 'package:step_wise/core/utils/typedefs.dart';
import 'package:step_wise/model/chat_bot/chat_prompt_request_model.dart';
import 'package:step_wise/service/chat_bot/chat_bot_service.dart';
import 'package:vexana/vexana.dart';

import '../../core/init/service_locator/service_locator.dart';
import '../../core/services/network/network_service.dart';
import '../../model/chat_bot/chat_prompt_response_model.dart';

class ChatBotServiceImpl implements ChatBotService {
  final NetworkService _networkService = sl<NetworkService>();

  @override
  ResultFuture<ChatPromptResponseModel> sendPrompt(
      ChatPromptRequestModel prompt) async {
    return _networkService
        .send<ChatPromptResponseModel, ChatPromptResponseModel>(
      APIConst.chatPrompt,
      parseModel: ChatPromptResponseModel(),
      method: RequestType.POST,
      data: prompt,
    );
  }

  @override
  ResultFuture<ChatPromptResponseModel> interviewPrep(
    ChatPromptRequestModel prompt,
  ) async {
    return _networkService
        .send<ChatPromptResponseModel, ChatPromptResponseModel>(
      APIConst.interview,
      parseModel: ChatPromptResponseModel(),
      method: RequestType.POST,
      data: prompt,
    );
  }
  @override
  ResultFuture<ChatPromptResponseModel> languageSkill(
    ChatPromptRequestModel prompt,
  ) async {
    return _networkService
        .send<ChatPromptResponseModel, ChatPromptResponseModel>(
      APIConst.languageSkill,
      parseModel: ChatPromptResponseModel(),
      method: RequestType.POST,
      data: prompt,
    );
  }
  @override
  ResultFuture<ChatPromptResponseModel> resume(
    ChatPromptRequestModel prompt,
  ) async {
    return _networkService
        .send<ChatPromptResponseModel, ChatPromptResponseModel>(
      APIConst.resume,
      parseModel: ChatPromptResponseModel(),
      method: RequestType.POST,
      data: prompt,
    );
  }
  @override
  ResultFuture<ChatPromptResponseModel> coverLetter(
    ChatPromptRequestModel prompt,
  ) async {
    return _networkService
        .send<ChatPromptResponseModel, ChatPromptResponseModel>(
      APIConst.coverLetter,
      parseModel: ChatPromptResponseModel(),
      method: RequestType.POST,
      data: prompt,
    );
  }
  @override
  ResultFuture<ChatPromptResponseModel> emailResponse(
    ChatPromptRequestModel prompt,
  ) async {
    return _networkService
        .send<ChatPromptResponseModel, ChatPromptResponseModel>(
      APIConst.emailResponse,
      parseModel: ChatPromptResponseModel(),
      method: RequestType.POST,
      data: prompt,
    );
  }
  @override
  ResultFuture<ChatPromptResponseModel> writeCaption(
    ChatPromptRequestModel prompt,
  ) async {
    return _networkService
        .send<ChatPromptResponseModel, ChatPromptResponseModel>(
      APIConst.writeCaption,
      parseModel: ChatPromptResponseModel(),
      method: RequestType.POST,
      data: prompt,
    );
  }
}
