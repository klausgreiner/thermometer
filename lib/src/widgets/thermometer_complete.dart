import 'package:flutter/material.dart';
import 'package:thermometer/src/widgets/thermometer.dart';
import 'package:thermometer/src/widgets/thermometer_background.dart';
import 'package:thermometer/src/widgets/thermometer_backshadow.dart';
import 'package:thermometer/src/widgets/thermometer_fluid.dart';
import 'package:thermometer/src/widgets/thermometer_white_shadow.dart';

class FullThermometer extends StatelessWidget {
  final Animation<double> agitationAnimation;

  final Animation<double> aliveFeeling;
  final double fluidHeight;

  const FullThermometer(
      {super.key,
      required this.agitationAnimation,
      required this.fluidHeight,
      required this.aliveFeeling});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: CustomPaint(
            painter: ThermometerBackgroundPainter(),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(right: 80.0),
            child: AnimatedBuilder(
              animation: agitationAnimation,
              builder: (context, snapshot) => CustomPaint(
                painter: ThermometerBackShadowPainter(fluidHeight),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: AnimatedBuilder(
            animation: agitationAnimation,
            builder: (context, snapshot) => CustomPaint(
              painter: ThermometerFluidPainter(fluidHeight, false,
                  aliveFeeling.value, agitationAnimation.value),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: AnimatedBuilder(
            animation: aliveFeeling,
            builder: (context, snapshot) => CustomPaint(
              painter: ThermometerFluidPainter(fluidHeight, true,
                  aliveFeeling.value, agitationAnimation.value),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: CustomPaint(painter: ThermometerPainter()),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(left: 35.0),
            child: CustomPaint(
              painter: ThermometerWhiteShadowPainter(),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(right: 35.0),
            child: CustomPaint(
              painter: ThermometerWhiteShadowPainter(),
            ),
          ),
        ),
      ],
    );
  }
}
