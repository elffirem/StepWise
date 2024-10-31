part of 'chat_bot_view.dart';

mixin ChatBotMixin on State<ChatBotView> {
  late final ChatBotController controller;

  final TextEditingController promptController = TextEditingController();
  final FocusNode promptFocusNode = FocusNode();

  @override
  void initState() {
    controller = Get.put(ChatBotController());
    if (widget.jobApplyTools != null) {
      controller.setApplyTools(widget.jobApplyTools!);
      controller.sendPromptApplyTools(null);
    }
    super.initState();
  }

  @override
  void dispose() {
    /// Commented out due to the double dispose which is causing error in debug
    //controller.dispose();
    //promptController.dispose();
    //promptFocusNode.dispose();
    controller.dispose();
    super.dispose();
  }
}
