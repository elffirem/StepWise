import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class SegmentedToggle extends StatelessWidget {
  const SegmentedToggle({
    Key? key,
    required this.isTimerSelected,
    required this.onTimerTap,
    required this.onStopWatchTap,
  }) : super(key: key);

  final bool isTimerSelected;
  final VoidCallback onTimerTap;
  final VoidCallback onStopWatchTap;

  @override
  Widget build(BuildContext context) {
    const Color navy = Color(0xFF0D224F);
    const Color lightBlue = Color(0xFF66A9DC);

    return Container(
      decoration: BoxDecoration(
        color: navy,
        border: Border.all(color: navy, width: 3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Left: Timer
          GestureDetector(
            onTap: onTimerTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isTimerSelected ? lightBlue : navy,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(Icons.timer, color: Colors.white, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    "Timer",
                    style: GoogleFonts.sora(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Right: StopWatch
          GestureDetector(
            onTap: onStopWatchTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isTimerSelected ? navy : lightBlue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(Icons.watch_later, color: Colors.white, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    "StopWatch",
                    style: GoogleFonts.sora(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
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
}
