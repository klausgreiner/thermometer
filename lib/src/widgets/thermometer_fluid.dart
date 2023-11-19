import 'package:flutter/material.dart';

class ThermometerFluidPainter extends CustomPainter {
  final double heightFluid;
  final bool isBackFluid;
  final double animation;
  final double animation2;

  ThermometerFluidPainter(
      this.heightFluid, this.isBackFluid, this.animation, this.animation2);

  @override
  void paint(Canvas canvas, Size size) {
    // Define the dimensions and positions of the thermometer shape
    // double topWidth = size.width / 3;
    // double bottomWidth = size.width / 2;
    double height = size.height * 0.7;
    double x = size.width / 2;
    double y = size.height - height;
    LinearGradient gradient = LinearGradient(
      colors: [
        isBackFluid ? const Color(0xFF07BCD4) : const Color(0xFF7ED3DE),
        isBackFluid ? const Color(0xFFFFC107) : const Color(0xFFD0D594),
        isBackFluid ? const Color(0xFFFF5722) : const Color(0xFFECA482),
      ],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    );
    Shader shader = gradient.createShader(const Rect.fromLTRB(0, 0, 200, 200));

    Paint paint = Paint()
      ..color = const Color(0xFFE0E0E0)
      ..shader = shader;
    Path path = Path();
    path.lineTo(x - 37, y + heightFluid);

    path.lineTo(x - 37, y + 200);
    // Bottom piece of fluid
    path.arcToPoint(Offset(x + 37, y + 198.5),
        radius: const Radius.elliptical(1, 1), clockwise: false);

    path.lineTo(x + 37, y + 198);
    path.lineTo(x + 37, y + heightFluid);
    // print(animation);
    path.arcToPoint(Offset(x - 37, y + heightFluid),
        radius: Radius.elliptical(animation, 0.2), clockwise: isBackFluid);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
