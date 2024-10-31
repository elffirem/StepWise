import 'package:flutter/material.dart';
import 'package:step_wise/core/constants/constants.dart';

class CustomButton extends StatelessWidget {
  final double height;
  final double width;
  final String title;
  final VoidCallback? onTap; // Added callback

  const CustomButton({
    super.key,
    required this.height,
    required this.width,
    required this.title,
     this.onTap, // Added callback
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Added callback
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: primaryColor,
        ),
        child: Center(
          child: Text(
            title,
            style: buttonTextStyle,
          ),
        ),
      ),
    );
  }
}
