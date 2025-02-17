import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/focus_mode_controller.dart';

class UserStatusSection extends StatelessWidget {
  const UserStatusSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FocusModeController controller = Get.find<FocusModeController>();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Örnek statik "City Level"
          Text(
            "City Level: 5",
            style: GoogleFonts.sora(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),

          // İlerleme göstergesi
         LinearProgressIndicator(
              value: controller.progress,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          const SizedBox(height: 8),

          // Örnek statik "Streak" bilgisi
          Text(
            "Streak: 7 days",
            style: GoogleFonts.sora(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),

          // Motivasyon Mesajı (Obx içinde Rx değeri okuyarak)
          Obx(() {
            final done = controller.completedSessions.value;
            // Her 2 seans bir bina ekleniyor diyelim
            int neededForNext = 2 - (done % 2);
            if (neededForNext == 0) neededForNext = 2;

            return Text(
              "Bir sonraki bina için $neededForNext odak seansı kaldı!",
              style: GoogleFonts.sora(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            );
          }),
        ],
      ),
    );
  }
}
