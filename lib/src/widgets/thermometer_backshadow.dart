import 'package:flutter/material.dart';

class ThermometerBackShadowPainter extends CustomPainter {
  final double heightFluid;

  ThermometerBackShadowPainter(this.heightFluid);
  @override
  void paint(Canvas canvas, Size size) {
    // Define the dimensions and positions of the thermometer shape
    // double topWidth = size.width / 3;
    // double bottomWidth = size.width / 2;
    double height = size.height * 0.7;
    double x = size.width / 2;
    double y = size.height - height;
    LinearGradient gradient = const LinearGradient(
      colors: [
        Color.fromARGB(255, 92, 236, 255),
        Color.fromARGB(255, 254, 215, 97),
        Color.fromARGB(255, 248, 110, 68),
      ],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    );
    Shader shader = gradient.createShader(const Rect.fromLTRB(0, 0, 200, 200));

    Paint paint = Paint()
      ..color = const Color(0xFFE0E0E0)
      ..shader = shader
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 25);

    Path path = Path();
    path.lineTo(x - 25, y + heightFluid);

    path.lineTo(x - 25, y + 200);
    // Bottom piece of fluid
    path.arcToPoint(Offset(x + 25, y + 180),
        radius: const Radius.elliptical(1, 1), clockwise: false);

    path.lineTo(x + 25, y + 180);
    path.lineTo(x + 25, y + heightFluid);
    // print(animation);
    path.arcToPoint(
      Offset(x - 25, y + heightFluid),
      radius: const Radius.elliptical(1, 0.2),
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
