import 'package:flutter/material.dart';

class MoodContainer extends StatelessWidget {
  final String mood;
  final String imagePath;
  final VoidCallback onTap;

  const MoodContainer(
      {super.key,
      required this.mood,
      required this.imagePath,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.grey.shade300, width: 4.0),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(imagePath, height: 70, width: 70),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                mood,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
