import 'package:get/get.dart';
import 'dart:async';

class FocusModeController extends GetxController {
  var isTimerSelected = true.obs;
  var selectedTime = 25.obs;
  var totalTime = (25 * 60).obs;
  var remainingTime = (25 * 60).obs;
  var stopwatchTime = 0.obs;
  var isRunning = false.obs;
  var completedSessions = 10.obs;
  Timer? _timer;
  var selectedIconPath = "assets/images/focus/icon1.png".obs;

  RxList<String> availableTags = RxList(['Study', 'Python', 'Math']);
  RxString selectedTag = ''.obs;

  double get progress {
    if (isTimerSelected.value) {
      if (totalTime.value == 0) return 0;
      return (totalTime.value - remainingTime.value) / totalTime.value;
    } else {
      return 0;
    }
  }

  void startTimer() {
    if (isRunning.value) return;
    isRunning.value = true;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (isTimerSelected.value) {
        if (remainingTime.value > 0) {
          remainingTime.value--;
        } else {
          completedSessions.value++;
          stopTimer();
        }
      } else {
        stopwatchTime.value++;
      }
    });
  }

  void stopTimer() {
    isRunning.value = false;
    _timer?.cancel();
  }

  void resetTimer() {
    stopTimer();
    if (isTimerSelected.value) {
      remainingTime.value = totalTime.value;
    } else {
      stopwatchTime.value = 0;
    }
  }

  void updateSelectedTime(int minutes) {
    selectedTime.value = minutes;
    totalTime.value = minutes * 60;
    remainingTime.value = totalTime.value;
  }

  void setSelectedIcon(String iconPath) {
    selectedIconPath.value = iconPath;
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
