import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/focus_mode_controller.dart';

class TimeControlSection extends StatelessWidget {
  const TimeControlSection({Key? key}) : super(key: key);

  // Geri sayımı mm:ss formatında göstermek için yardımcı metot
  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final FocusModeController controller = Get.find<FocusModeController>();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Süre seçenekleri
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTimeOption("25 min", 25, controller),
              _buildTimeOption("45 min", 45, controller),
              _buildTimeOption("60 min", 60, controller),
            ],
          ),
          const SizedBox(height: 16),

          // Geri sayım metni
          Obx(() {
            return Text(
              _formatTime(controller.remainingTime.value),
              style: GoogleFonts.sora(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            );
          }),
          const SizedBox(height: 16),

          // Kontrol butonları (Başlat/Duraklat, Durdur)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                return ElevatedButton(
                  onPressed: () {
                    if (controller.isRunning.value) {
                      controller.stopTimer();
                    } else {
                      controller.startTimer();
                    }
                  },
                  child: Text(controller.isRunning.value ? "Pause" : "Start"),
                );
              }),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  controller.stopTimer();
                  controller.resetTimer();
                },
                child: const Text("Stop"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeOption(String label, int minutes, FocusModeController controller) {
    return GestureDetector(
      onTap: () {
        controller.updateSelectedTime(minutes);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(16), // Daha yuvarlak kenarlar
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              offset: const Offset(0, 4),
              blurRadius: 6,
            )
          ],
        ),
        child: Text(
          label,
          style: GoogleFonts.sora(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
