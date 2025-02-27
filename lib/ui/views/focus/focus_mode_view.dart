import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:step_wise/controller/focus_mode_controller.dart';
import 'package:step_wise/core/constants/constants.dart';
import 'package:step_wise/core/extensions/sized_box_extension.dart';
import 'package:step_wise/ui/components/focus_circle.dart';
import 'package:step_wise/ui/components/tag_container.dart';

class FocusModeView extends StatelessWidget {
  const FocusModeView({Key? key}) : super(key: key);

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final FocusModeController controller = Get.find<FocusModeController>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              50.h,
              Obx(() {
                return _buildSegmentedToggle(
                  isTimerSelected: controller.isTimerSelected.value,
                  onTimerTap: () {
                    controller
                        .resetTimer(); 
                    controller.isTimerSelected.value = true;
                  },
                  onStopWatchTap: () {
                    controller
                        .resetTimer(); 
                    controller.isTimerSelected.value = false;
                  },
                );
              }),
              50.h,
              Expanded(
                child: Center(
                  child: Obx(() {
                    final bool isTimer = controller.isTimerSelected.value;
                    if (isTimer) {
                      return timerTab(context, controller);
                    } else {
                      return stopWatchTab(context, controller);
                    }
                  }),
                ),
              ),
              timeSelectingButtons(controller),
              34.h,
              startStopButton(controller),
              16.h,
            ],
          ),
        ),
      ),
    );
  }

  Obx startStopButton(FocusModeController controller) {
    return Obx(() {
      final isRunning = controller.isRunning.value;
      return ElevatedButton(
        onPressed: () {
          if (isRunning) {
            controller.stopTimer();
          } else {
            controller.startTimer();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
        ),
        child: Text(
          isRunning ? "Stop" : "Focus",
          style: GoogleFonts.sora(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      );
    });
  }

  Obx timeSelectingButtons(FocusModeController controller) {
    return Obx(() {
      if (!controller.isTimerSelected.value) {
        return const SizedBox(height: 60);
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildTimePreset("25 min", 25, controller),
          _buildTimePreset("45 min", 45, controller),
          _buildTimePreset("60 min", 60, controller),
        ],
      );
    });
  }

  // Updated to use the selectedTag from the controller.
  Widget stopWatchTab(BuildContext context, FocusModeController controller) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => _showIconPicker(context, controller),
          child: FocusCircle(
            showProgress: false,
            progress: controller.progress,
            child: Center(
              child: Image.asset(
                controller.selectedIconPath.value,
                width: 150,
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        18.h,
        // Display the selected tag
        Obx(() {
          return controller.selectedTag.value.isNotEmpty
              ? TagContainer(
                  tagTitle: controller.selectedTag.value,
                  isInner: false,
                )
              : const SizedBox();
        }),
        const Spacer(flex: 4),
        Obx(() {
          final timeDisplay = _formatTime(controller.stopwatchTime.value);
          return Text(
            timeDisplay,
            style: GoogleFonts.sora(
              fontSize: 48,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          );
        }),
        const Spacer(flex: 1),
      ],
    );
  }

  // Updated to use the selectedTag from the controller.
  Widget timerTab(BuildContext context, FocusModeController controller) {
    final timeDisplay = _formatTime(controller.remainingTime.value);
    return Column(
      children: [
        GestureDetector(
          onTap: () => _showIconPicker(context, controller),
          child: FocusCircle(
            showProgress: true,
            progress: controller.progress,
            child: Center(
              child: Image.asset(
                controller.selectedIconPath.value,
                width: 150,
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        18.h,
        // Display the selected tag
        Obx(() {
          return controller.selectedTag.value.isNotEmpty
              ? TagContainer(
                  tagTitle: controller.selectedTag.value,
                  isInner: false,
                )
              : const SizedBox();
        }),
        const Spacer(flex: 2),
        Text(
          timeDisplay,
          style: GoogleFonts.sora(
            fontSize: 48,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        const Spacer(flex: 1)
      ],
    );
  }

  Widget _buildSegmentedToggle({
    required bool isTimerSelected,
    required VoidCallback onTimerTap,
    required VoidCallback onStopWatchTap,
  }) {
    const Color navy = Color(0xFF0D224F);
    const Color lightBlue = Color(0xFF66A9DC);

    return Container(
      decoration: BoxDecoration(
        color: navy,
        border: Border.all(color: navy, width: 3),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: onTimerTap,
            child: AnimatedContainer(
              height: 40,
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isTimerSelected ? lightBlue : navy,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  const Icon(Icons.timer_outlined,
                      color: Colors.white, size: 20),
                  const SizedBox(width: 6),
                  Text(
                    "Timer",
                    style: GoogleFonts.sora(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: onStopWatchTap,
            child: AnimatedContainer(
              height: 40,
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isTimerSelected ? navy : lightBlue,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  const Icon(Icons.watch_later_outlined,
                      color: Colors.white, size: 20),
                  const SizedBox(width: 6),
                  Text(
                    "StopWatch",
                    style: GoogleFonts.sora(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimePreset(
    String label,
    int minutes,
    FocusModeController controller,
  ) {
    return GestureDetector(
      onTap: () => controller.updateSelectedTime(minutes),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: lightGreyColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: GoogleFonts.sora(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  void _showIconPicker(BuildContext context, FocusModeController controller) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Icons",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              16.h,
              iconGrid(controller, context),
              16.h,
              const Text(
                "Tags",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              16.h,
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  // Display available tags from the controller:
                  ...controller.availableTags
                      .map((tag) => GestureDetector(
                            onTap: () {
                              controller.selectedTag.value = tag;
                              Navigator.pop(context);
                            },
                            child: TagContainer(
                              tagTitle: tag,
                              isInner: true,
                            ),
                          ))
                      .toList(),
                  // Add Tag button:
                  GestureDetector(
                    onTap: () => _showAddTagDialog(context, controller),
                    child: Container(
                      constraints: const BoxConstraints(
                        minWidth: 80,
                        maxWidth: 150,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: lightGreyColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add, color: Colors.black),
                          SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              "Add Tag",
                              softWrap: true,
                              maxLines: 3,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Sora',
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  // Updated to use the controller for icon selection.
  GridView iconGrid(FocusModeController controller, BuildContext context) {
    final icons = [
      "assets/images/focus/icon1.png",
      "assets/images/focus/icon2.png",
      "assets/images/focus/icon3.png",
      "assets/images/focus/icon4.png",
      "assets/images/focus/icon5.png",
      "assets/images/focus/icon6.png",
      "assets/images/focus/icon7.png",
      "assets/images/focus/icon8.png",
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: icons.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            controller.setSelectedIcon(icons[index]);
            Navigator.pop(context);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Image.asset(
                icons[index],
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }

  // A new method to show a dialog to add a new tag.
  void _showAddTagDialog(BuildContext context, FocusModeController controller) {
    final TextEditingController tagController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add a new tag'),
          content: TextField(
            controller: tagController,
            decoration: const InputDecoration(hintText: 'Enter tag name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final newTag = tagController.text.trim();
                if (newTag.isNotEmpty) {
                  // Add the new tag to the availableTags list and select it.
                  controller.availableTags.add(newTag);
                  controller.selectedTag.value = newTag;
                }
                Navigator.pop(context);
                // Optionally, close the bottom sheet if still open:
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
