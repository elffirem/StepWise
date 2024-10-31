import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:step_wise/core/constants/constants.dart';
import 'package:step_wise/core/extensions/sized_box_extension.dart';
import 'package:step_wise/ui/views/loading/loading_controller.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    final LoadingController controller = Get.put(LoadingController());

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset('assets/animations/rocketship.json'),
          ),
          20.h,
          Obx(() {
            return Opacity(
              opacity: 0.0,
              child: Text(
                controller.displayText.value,
                style: headlineTextStyle,
              ),
            );
          }),
          20.h,
          Obx(() {
            return AnimatedOpacity(
              opacity: 1.0,  
              duration: const Duration(seconds:30),  
              child: Text(
                controller.displayText.value,
                style: headlineTextStyle,
                textAlign: TextAlign.center,
              ),
            );
          }),
        ],
      ),
    );
  }
}
