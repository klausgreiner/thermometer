import 'package:flutter/material.dart';
import 'dart:math';

class ThermometerBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Define the dimensions and positions of the thermometer shape
    // double topWidth = size.width / 3;
    // double bottomWidth = size.width / 2;
    double height = size.height * 0.7;
    double x = size.width / 2;
    double y = size.height - height;
    double radius = 40;

    Paint paint = Paint()..color = const Color(0xFFE0E0E0);
    Path path = Path();
    path.lineTo(x - 38, y + 0);

    path.lineTo(x - 38, y + 200);
    path.arcTo(
        Rect.fromCircle(center: Offset(x + 2, y + 198.5), radius: radius),
        pi,
        -pi / 2,
        false);
    path.arcTo(
        Rect.fromCircle(center: Offset(x - 2, y + 198.5), radius: radius),
        pi / 2,
        -pi / 2,
        false);

    path.lineTo(x + 38, y + 198);
    path.lineTo(x + 38, y + 0);
    path.lineTo(x + 38, y + 0);
    path.arcTo(
      Rect.fromCircle(center: Offset(x + 0, y), radius: 38),
      pi,
      pi,
      false,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
