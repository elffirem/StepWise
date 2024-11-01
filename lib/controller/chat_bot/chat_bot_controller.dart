import 'package:get/get.dart';
import 'package:step_wise/core/enums.dart';
import 'package:step_wise/model/chat_bot/chat_prompt_request_model.dart';
import 'package:step_wise/service/chat_bot/chat_bot_service.dart';
import 'package:step_wise/service/chat_bot/chat_bot_service_impl.dart';

import '../../core/utils/typedefs.dart';
import '../../model/chat_bot/chat_conversation_model.dart';
import '../../model/chat_bot/chat_prompt_response_model.dart';

final class ChatBotController extends GetxController {
  ChatBotController();

  late JobApplyTools? _jobApplyTools;

  final ChatBotService _chatBotService = ChatBotServiceImpl();

  final RxList<ChatConversationModel> _chatMessages =
      RxList<ChatConversationModel>();

  RxList<ChatConversationModel> get chatMessages => _chatMessages;

  int? _sessionId;

  final RxString _errorMessage = RxString('');

  final RxBool _isLoading = RxBool(false);

  RxBool get isLoading => _isLoading;

  RxString get errorMessage => _errorMessage;

  void setApplyTools(JobApplyTools jobApplyTools) {
    _jobApplyTools = jobApplyTools;
  }

  Future<void> sendPrompt(String prompt) async {
    chatMessages.add(ChatConversationModel(message: prompt, isResponse: false));

    _isLoading.value = true;
    final result = await _chatBotService.sendPrompt(ChatPromptRequestModel(
      prompt: prompt,
      sessionId: _sessionId,
    ));

    result.fold(
      (error) {
        /// Handle the error
      },
      (data) {
        _sessionId = data.sessionId;

        /// Add the chat bot's response to the chat list
        if (data.message != null) {
          chatMessages.add(ChatConversationModel(
            message: data.message!,
            isResponse: true,
          ));
        }
      },
    );

    _isLoading.value = false;
  }

  Future<void> sendPromptApplyTools(String? prompt) async {
    /// Add the user's message to the chat list
    if (prompt != null) {
      chatMessages
          .add(ChatConversationModel(message: prompt, isResponse: false));
    }

    _isLoading.value = true;

    /// Send the user's message to the chat bot
    late final Result<ChatPromptResponseModel> result;

    switch (_jobApplyTools) {
      case JobApplyTools.interviewPrep:
        result = await _chatBotService.interviewPrep(
          ChatPromptRequestModel(
            prompt: prompt,
            sessionId: _sessionId,
          ),
        );
        break;
      case JobApplyTools.languageSkill:
        result = await _chatBotService.languageSkill(
          ChatPromptRequestModel(
            prompt: prompt,
            sessionId: _sessionId,
          ),
        );
        break;
      case JobApplyTools.resume:
        result = await _chatBotService.resume(
          ChatPromptRequestModel(
            prompt: prompt,
            sessionId: _sessionId,
          ),
        );
        break;
      case JobApplyTools.coverLetter:
        result = await _chatBotService.coverLetter(
          ChatPromptRequestModel(
            prompt: prompt,
            sessionId: _sessionId,
          ),
        );
        break;
      case JobApplyTools.emailResponse:
        result = await _chatBotService.emailResponse(
          ChatPromptRequestModel(
            prompt: prompt,
            sessionId: _sessionId,
          ),
        );
        break;
      case JobApplyTools.writeCaption:
        result = await _chatBotService.writeCaption(
          ChatPromptRequestModel(
            prompt: prompt,
            sessionId: _sessionId,
          ),
        );
        break;
      case null:
    }

    result.fold(
      (error) {
        Get.snackbar("Error", error.message ?? "An error occurred");
      },
      (data) {
        _sessionId = data.sessionId;

        /// Add the chat bot's response to the chat list
        if (data.message != null) {
          chatMessages.add(ChatConversationModel(
            message: data.message!,
            isResponse: true,
          ));
        }
      },
    );

    _isLoading.value = false;
  }
}
