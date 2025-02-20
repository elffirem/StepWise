import 'package:net_kit/net_kit.dart';
import 'package:step_wise/core/constants/api_const.dart';
import 'package:step_wise/core/utils/typedefs.dart';
import 'package:step_wise/model/chat_bot/chat_prompt_request_model.dart';
import 'package:step_wise/service/chat_bot/chat_bot_service.dart';

import '../../core/init/service_locator/service_locator.dart';
import '../../core/services/network/network_service.dart';
import '../../model/chat_bot/chat_prompt_response_model.dart';

class ChatBotServiceImpl implements ChatBotService {
  final NetworkService _networkService = sl<NetworkService>();

  @override
  ResultFuture<ChatPromptResponseModel> sendPrompt(
      ChatPromptRequestModel prompt) async {
    return _networkService.requestModel<ChatPromptResponseModel>(
      APIConst.chatPrompt,
      parseModel: ChatPromptResponseModel(),
      method: RequestMethod.post,
      body: prompt.toJson(),
    );
  }

  @override
  ResultFuture<ChatPromptResponseModel> interviewPrep(
    ChatPromptRequestModel prompt,
  ) async {
    return _networkService.requestModel<ChatPromptResponseModel>(
      APIConst.interview,
      parseModel: ChatPromptResponseModel(),
      method: RequestMethod.post,
      body: prompt.toJson(),
    );
  }

  @override
  ResultFuture<ChatPromptResponseModel> languageSkill(
    ChatPromptRequestModel prompt,
  ) async {
    return _networkService.requestModel<ChatPromptResponseModel>(
      APIConst.languageSkill,
      parseModel: ChatPromptResponseModel(),
      method: RequestMethod.post,
      body: prompt.toJson(),
    );
  }

  @override
  ResultFuture<ChatPromptResponseModel> resume(
    ChatPromptRequestModel prompt,
  ) async {
    return _networkService.requestModel<ChatPromptResponseModel>(
      APIConst.resume,
      parseModel: ChatPromptResponseModel(),
      method: RequestMethod.post,
      body: prompt.toJson(),
    );
  }

  @override
  ResultFuture<ChatPromptResponseModel> coverLetter(
    ChatPromptRequestModel prompt,
  ) async {
    return _networkService.requestModel<ChatPromptResponseModel>(
      APIConst.coverLetter,
      parseModel: ChatPromptResponseModel(),
      method: RequestMethod.post,
      body: prompt.toJson(),
    );
  }

  @override
  ResultFuture<ChatPromptResponseModel> emailResponse(
    ChatPromptRequestModel prompt,
  ) async {
    return _networkService.requestModel<ChatPromptResponseModel>(
      APIConst.emailResponse,
      parseModel: ChatPromptResponseModel(),
      method: RequestMethod.post,
      body: prompt.toJson(),
    );
  }

  @override
  ResultFuture<ChatPromptResponseModel> writeCaption(
    ChatPromptRequestModel prompt,
  ) async {
    return _networkService.requestModel<ChatPromptResponseModel>(
      APIConst.writeCaption,
      parseModel: ChatPromptResponseModel(),
      method: RequestMethod.post,
      body: prompt.toJson(),
    );
  }
}
