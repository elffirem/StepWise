import 'package:flutter/material.dart';
import 'package:step_wise/core/constants/constants.dart';

class CustomCard extends StatelessWidget {
  final double height;
  final Color? color;

  final Widget child;

  const CustomCard(
      {super.key, required this.height, required this.child, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      key: key,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          width: 2,
          color: primaryColor,
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: child,
          ),
          // buildTappedOptions(),
        ],
      ),
    );
  }

  Visibility buildTappedOptions() {
    return Visibility(
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                ),
                color: primaryColor,
              ),
            ),
          ),
          Container(height: 2, color: Colors.white),
          Expanded(
            child: Container(
              color: Colors.blueAccent,
            ),
          ),
          Container(height: 2, color: Colors.white),
          Expanded(
            child: Container(
              color: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }
}
