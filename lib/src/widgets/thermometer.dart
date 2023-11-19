import 'package:flutter/material.dart';
import 'dart:math';

class ThermometerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 6.0
      ..style = PaintingStyle.stroke;

    // Define the dimensions and positions of the thermometer shape
    // double topWidth = size.width / 3;
    // double bottomWidth = size.width / 2;
    double height = size.height * 0.7;
    double x = size.width / 2;
    double y = size.height - height;
    double radius = 40;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(x, y), radius: radius),
      pi,
      pi,
      false,
      paint,
    );
    // // Draw the shape of the thermometer using Canvas objects
    canvas.drawLine(
      Offset(x - 40, y - 1),
      Offset(x - 40, y + 201),
      paint,
    );
    canvas.drawLine(
      Offset(x + 40, y - 1),
      Offset(x + 40, y + 201),
      paint,
    );
    canvas.drawArc(
      Rect.fromCircle(center: Offset(x, y + 200), radius: radius),
      -pi,
      -pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
