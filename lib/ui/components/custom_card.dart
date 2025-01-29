import 'package:flutter/material.dart';
import 'package:step_wise/core/constants/constants.dart';

class CustomCard extends StatelessWidget {
  final double height;
  final Color? color;
  final bool? isShadowVisible;
  final Widget child;

  const CustomCard({
    super.key,
    required this.height,
    required this.child,
    this.color,
    this.isShadowVisible = true, // Varsayılan olarak gölge görünür
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      key: key,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color ?? cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          width: 2,
          color: primaryColor,
        ),
        boxShadow: isShadowVisible == true
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25), // %25 opak siyah
                  offset: const Offset(0, 3), // X: 0, Y: 3
                  blurRadius: 3, // Blur: 3
                  spreadRadius: 0, // Spread: 0
                ),
              ]
            : [], // Eğer false ise boş bir liste gönderiyoruz (gölge yok)
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}
