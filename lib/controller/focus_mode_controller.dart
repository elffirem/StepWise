import 'package:get/get.dart';
import 'dart:async';

class FocusModeController extends GetxController {
  var selectedTime = 25.obs;
  var remainingTime = (25 * 60).obs;
  var isRunning = false.obs;
  var completedSessions = 10.obs; // <-- ÖNEMLİ: Tamamlanan seans sayısı
  Timer? _timer;

  double get progress =>
      1 - (remainingTime.value / (selectedTime.value * 60));

  void startTimer() {
    if (isRunning.value) return;
    isRunning.value = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.value > 0) {
        remainingTime.value--;
      } else {
        // Odak süresi tamamlandı
        completedSessions.value++;
        stopTimer();
        // resetTimer(); // İsterseniz otomatik sıfırlayabilirsiniz.
      }
    });
  }

  void stopTimer() {
    isRunning.value = false;
    _timer?.cancel();
  }

  void resetTimer() {
    stopTimer();
    remainingTime.value = selectedTime.value * 60;
  }

  void updateSelectedTime(int minutes) {
    selectedTime.value = minutes;
    resetTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
