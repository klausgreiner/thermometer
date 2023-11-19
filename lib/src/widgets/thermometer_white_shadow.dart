import 'package:flutter/material.dart';
import 'dart:math';

class ThermometerWhiteShadowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Define the dimensions and positions of the thermometer shape
    // double topWidth = size.width / 3;
    // double bottomWidth = size.width / 2;
    double height = size.height * 0.7;
    double x = size.width / 2;
    double y = size.height - height;
    double radius = 10;

    Paint paint = Paint()
      ..color = Colors.white.withOpacity(0.7)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
    Path path = Path();
    path.lineTo(x - 12, y + 0);

    path.lineTo(x - 12, y + 200);
    path.arcTo(Rect.fromCircle(center: Offset(x, y + 200), radius: radius), pi,
        -pi / 2, false);
    path.arcTo(Rect.fromCircle(center: Offset(x, y + 200), radius: radius), pi,
        -pi, false);

    path.lineTo(x + 12, y + 200);
    path.lineTo(x + 12, y + 20);
    path.lineTo(x + 12, y + 0);
    path.arcTo(
      Rect.fromCircle(center: Offset(x, y), radius: radius),
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
