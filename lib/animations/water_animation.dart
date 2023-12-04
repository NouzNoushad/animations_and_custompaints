
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as Vector;

class WaveWidget extends StatefulWidget {
  const WaveWidget({super.key});

  @override
  _WaveWidgetState createState() => _WaveWidgetState();
}

class _WaveWidgetState extends State<WaveWidget> with TickerProviderStateMixin {
  late AnimationController animationController;

  //Offset list used for creating wave
  List<Offset> animList1 = [];

  //for controlling width of wave container
  // width is calculated from top right corner since it's the origin
  double width = 700;

  //for controlling height of wave container below the wave curve
  // height is calculated from top right corner since it's the origin
  double height = 300;

  // for controlling depth of wave
  double depth = 10;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    animationController.addListener(() {
      animList1.clear();
      for (int i = -2; i <= width; i++) {
        var val = sin((animationController.value * 360 - i) %
            360 *
            Vector.degrees2Radians);
        animList1.add(Offset(i.toDouble(), val * depth + height));
      }
    });
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedBuilder(
      animation: CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
      builder: (context, child) {
        return ClipPath(
          clipper: WaveClipper(animationController.value, animList1),
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 19, 81, 189),
            ),
          ),
        );
      },
    ));
  }
}

class WaveClipper extends CustomClipper<Path> {
  final double animation;

  List<Offset> waveList1 = [];

  WaveClipper(this.animation, this.waveList1);

  @override
  Path getClip(Size size) {
    Path path = Path();

    path.addPolygon(waveList1, false);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(WaveClipper oldClipper) =>
      animation != oldClipper.animation;
}
