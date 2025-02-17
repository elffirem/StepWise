import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/focus_mode_controller.dart';
import 'dart:math';

class CityMapSection extends StatelessWidget {
  const CityMapSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FocusModeController controller = Get.find<FocusModeController>();

    return Container(
     
      child: InteractiveViewer(
        panEnabled: true,
        minScale: 0.5,
        maxScale: 2.0,
        clipBehavior: Clip.none, // Kayma sınırlarını kaldırmak için
        child: Container(
          width: double.infinity,
          height: 100, // Harita alanı yüksekliği
          decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFB3E5FC), // Hafif mavi
              Color(0xFFE1F5FE), // Daha açık mavi
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
          child: Obx(() {
            int sessionCount = controller.completedSessions.value;
            List<Widget> buildings = [];

            int buildingCount = sessionCount ~/ 2; // Her 2 seans için 1 bina
            double cityWidth = MediaQuery.of(context).size.width - 100;

            Random random = Random(); // Rastgele bina yerleşimi için

            for (int i = 0; i < buildingCount; i++) {
              double leftPosition = random.nextDouble() * cityWidth;
              double bottomPosition = random.nextDouble() * 100 + 20;

              buildings.add(
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  left: leftPosition,
                  bottom: bottomPosition,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: min(70, 50 + i * 5), // Maksimum 70px olacak
                    height: min(70, 50 + i * 5),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: const Offset(0, 4),
                          blurRadius: 6,
                        )
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "Bina ${i + 1}",
                        style: const TextStyle(
                          fontFamily: "Sora",
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
            return Stack(children: buildings);
          }),
        ),
      ),
    );
  }
}
