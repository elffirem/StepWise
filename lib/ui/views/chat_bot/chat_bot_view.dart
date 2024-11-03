import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/chat_bot/chat_bot_controller.dart';
import '../../../core/constants/constants.dart';
import '../../../core/enums.dart';

part 'chat_bot_mixin.dart';

class ChatBotView extends StatefulWidget {
  const ChatBotView({super.key, this.jobApplyTools});

  final JobApplyTools? jobApplyTools;

  @override
  State<ChatBotView> createState() => _ChatBotViewState();
}

class _ChatBotViewState extends State<ChatBotView> with ChatBotMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Step Wise',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          chatMessagesList(),
          textField(),
        ],
      ),
    );
  }

  Positioned textField() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      height: 76,
      child: Container(
        padding:
            const EdgeInsets.only(bottom: 20, left: 12, right: 12, top: 12),
        color: context.theme.scaffoldBackgroundColor,
        // color: Colors.red,
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey[500]!,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  focusNode: promptFocusNode,
                  controller: promptController,
                  decoration: const InputDecoration(
                    hintText: 'Type a message...',
                    contentPadding: EdgeInsets.only(left: 20, bottom: 4),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                if (widget.jobApplyTools == null) {
                  controller.sendPrompt(promptController.text);
                } else {
                  controller.sendPromptApplyTools(promptController.text);
                }
                promptController.clear();
              },
            )
          ],
        ),
      ),
    );
  }

  Positioned chatMessagesList() {
    return Positioned.fill(
      child: Obx(
        () => ListView.builder(
            itemCount: controller.chatMessages.length,
            padding: const EdgeInsets.only(bottom: 100),
            itemBuilder: (context, index) {
              final message = controller.chatMessages[index];
              return Column(
                children: [
                  Align(
                    alignment: message.isResponse
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Container(
                      constraints:
                          BoxConstraints(maxWidth: context.width * 0.66),
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.all(12) +
                          (message.isResponse
                              ? const EdgeInsets.only(right: 32)
                              : const EdgeInsets.only(left: 32)),
                      decoration: BoxDecoration(
                        color: message.isResponse
                            ? const Color(0xFFDFE3E5)
                            : const Color(0xFF2C878C),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        message.message,
                        style: captionTextStyle.copyWith(
                          color:
                              message.isResponse ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),
                  if (controller.chatMessages.length - 1 == index &&
                      controller.isLoading.value)
                    const CircularProgressIndicator(),
                ],
              );
            }),
      ),
    );
  }
}
