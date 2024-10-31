import 'package:flutter/material.dart';

class TimelinePainter extends CustomPainter {
  final bool isFirst;
  final bool isLast;

  TimelinePainter({required this.isFirst, required this.isLast});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    const circleRadius = 10.0;
    final circleCenter = Offset(size.width / 2, size.height / 2);

    if (!isFirst) {
      final lineStartUpper = Offset(size.width / 2, 0);
      final lineEndUpper = Offset(size.width / 2, circleCenter.dy - circleRadius);
      canvas.drawLine(lineStartUpper, lineEndUpper, paint);
    }

    if (!isLast) {
      final lineStartLower = Offset(size.width / 2, circleCenter.dy + circleRadius);
      final lineEndLower = Offset(size.width / 2, size.height);
      canvas.drawLine(lineStartLower, lineEndLower, paint);
    }

    canvas.drawCircle(circleCenter, circleRadius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
