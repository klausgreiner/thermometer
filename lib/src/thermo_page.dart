import 'package:flutter/material.dart';
import 'package:thermometer/src/widgets/thermometer_complete.dart';

class ThermoPage extends StatefulWidget {
  const ThermoPage({super.key});

  @override
  State<ThermoPage> createState() => _ThermoPageState();
}

class _ThermoPageState extends State<ThermoPage> with TickerProviderStateMixin {
  int selected = 1;
  double fluidHeight = 120;
  int temp = 20;

  late Animation<double> agitationAnimation;
  late AnimationController controller;

  late Animation<double> aliveFeeling;
  late AnimationController controller2;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    controller2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    Tween<double> lateralMovement = Tween(begin: 1, end: 3);
    Tween<double> agitation = Tween(begin: 1, end: 3);

    agitationAnimation = agitation.animate(controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });

    aliveFeeling = lateralMovement.animate(controller2)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller2.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller2.forward();
        }
      });

    controller.forward();
    controller2.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: Stack(children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.width / 2,
              ),
              child: FullThermometer(
                agitationAnimation: agitationAnimation,
                aliveFeeling: aliveFeeling,
                fluidHeight: fluidHeight,
              ),
            ),
          ),
          Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.width / 2 + 200,
                  left: 40,
                ),
                child: Text(
                  '$temp°',
                  style: const TextStyle(
                      fontSize: 120,
                      color: Color(0xFFD6D6D6),
                      fontWeight: FontWeight.w400),
                ),
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icons.ac_unit,
                    color: const Color(0xFF07BCD4),
                    onPressed: () {
                      setState(() {
                        selected = 0;
                        fluidHeight = 160;
                        temp = 10;
                      });
                    },
                    selected: selected == 0,
                  ),
                  IconButton(
                    icon: Icons.water_drop,
                    color: const Color(0xFFFFC107),
                    onPressed: () {
                      setState(() {
                        selected = 1;
                        fluidHeight = 120;
                        temp = 20;
                      });
                    },
                    selected: selected == 1,
                  ),
                  IconButton(
                    icon: Icons.whatshot,
                    color: const Color(0xFFFF5722),
                    onPressed: () {
                      setState(() {
                        selected = 2;
                        fluidHeight = 50;
                        temp = 35;
                      });
                    },
                    selected: selected == 2,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: RotatedBox(
              quarterTurns: 3,
              child: Container(
                height: 100,
                padding: const EdgeInsets.symmetric(horizontal: 250),
                child: Slider(
                  value: temp.toDouble(),
                  min: 0,
                  max: 50,
                  label: temp.toString(),
                  divisions: 50,
                  onChanged: (value) {
                    setState(() {
                      temp = value.toInt();
                      fluidHeight = getFluidHeight(temp.toDouble());
                    });
                  },
                ),
              ),
            ),
          ),
        ]));
  }

  double getFluidHeight(double temp) {
    List<double> tempValues = [0, 10, 20, 35, 50];
    List<double> fluidHeightValues = [190, 160, 120, 50, -20];

    // If the temperature is outside the range of the given values, return null
    if (temp < tempValues.first) {
      return 190;
    }
    if (temp > tempValues.last) {
      return -20;
    }

    // Find the index of the interval that the temperature belongs to
    int index = 0;
    for (int i = 0; i < tempValues.length; i++) {
      if (temp == tempValues[i]) return fluidHeightValues[i];
      if (temp < tempValues[i]) {
        index = i - 1;
        break;
      }
    }

    // Calculate the fluid height using linear interpolation between the values of the interval
    double tempDiff = tempValues[index + 1] - tempValues[index];
    double fluidHeightDiff =
        fluidHeightValues[index + 1] - fluidHeightValues[index];
    double ratio = (temp - tempValues[index]) / tempDiff;
    double fluidHeight = fluidHeightValues[index] + (ratio * fluidHeightDiff);

    return fluidHeight;
  }
}

class IconButton extends StatelessWidget {
  final bool selected;
  final IconData icon;
  final Color color;
  final Function() onPressed;

  const IconButton({
    super.key,
    required this.selected,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 2.0,
      fillColor: Colors.white,
      padding: const EdgeInsets.all(8.0),
      shape: const CircleBorder(),
      child: Icon(
        icon,
        size: 40,
        color: !selected ? const Color(0xFFE0E0E0) : color,
      ),
    );
  }
}
