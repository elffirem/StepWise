import 'package:get/get.dart';

class LoadingController extends GetxController {
  var displayText = "Fasten Your Seatbelts!".obs;
  var textIndex = 0;

  final List<String> messages = [
    "Fasten Your Seatbelts!",
    "Preparing Your Adventure...",
    "Processing Your Information...",
    "Crafting Your Unique Roadmap...",
    "Almost There, Get Ready!"
  ];

  @override
  void onInit() {
    super.onInit();
    _changeText();
  }

  void _changeText() {
    Future.delayed(const Duration(seconds: 6), () {
      textIndex = (textIndex + 1) % messages.length;
      displayText.value = messages[textIndex];

      _changeText();
    });
  }
}
