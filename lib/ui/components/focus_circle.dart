import 'package:flutter/material.dart';

class FocusCircle extends StatelessWidget {
  final Widget child;
  final bool showProgress;
  final double progress;

  const FocusCircle({
    Key? key,
    required this.child,
    this.showProgress = false,
    this.progress = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 300,
      child: Stack(
        alignment: Alignment.center,
        children: [
           Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F0),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF0D224F),
                width: 4,
              ),
            ),
            child: child,
          ),
          if (showProgress)
            SizedBox(
              width: 285,
              height: 285,
              child: CircularProgressIndicator(
                value: 1-progress,
                strokeWidth: 10,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF0D224F),
                ),
              ),
            ),
         
        ],
      ),
    );
  }
}
