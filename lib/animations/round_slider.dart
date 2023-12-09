import 'dart:math';

import 'package:flutter/material.dart';

class RoundSlider extends StatefulWidget {
  const RoundSlider({super.key});

  @override
  State<RoundSlider> createState() => _RoundSliderState();
}

class _RoundSliderState extends State<RoundSlider> {
  double angle = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: GestureDetector(
          onPanUpdate: (details) {
            final touchFromCenter = details.localPosition;
            setState(() {
              angle = touchFromCenter.direction;
              // angle = atan(details.delta.dy / details.delta.dx);
              print('//////// angle : $angle');
            });
          },
          child: Transform.rotate(
            angle: angle,
            child: Container(
              height: 350,
              width: 350,
              color: Colors.transparent,
              child: CustomPaint(painter: CircularPainter()),
            ),
          ),
        ),
      ),
    );
  }
}

class CircularPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var h = size.height;
    var w = size.width;
    var centerX = w / 2;
    var centerY = h / 2;
    var offset = Offset(centerX, centerY);
    var outerRadius = max(centerX, centerY);
    var outerStrokeWidth = 5.0;

    // outer circle
    canvas.drawCircle(
        offset,
        outerRadius,
        Paint()
          ..strokeWidth = outerStrokeWidth
          ..color = const Color.fromARGB(255, 250, 3, 85)
          ..style = PaintingStyle.stroke);
    // inner circle
    canvas.drawCircle(offset, outerRadius - (outerStrokeWidth * 0.5),
        Paint()..color = Colors.black);
    // inner stroke
    var outerStrokeRadius = outerRadius - 10;
    var innerStrokeRadius = outerStrokeRadius - 8;
    var roundStrokeWidth = 2.0;

    for (int i = 0; i <= 360; i += 2) {
      if (i % 10 == 0) {
        innerStrokeRadius = outerStrokeRadius - 20;
      } else {
        innerStrokeRadius = outerStrokeRadius - 8;
      }
      var x1 = centerX + outerStrokeRadius * cos(i * pi / 180);
      var y1 = centerY + outerStrokeRadius * sin(i * pi / 180);
      var x2 = centerX + innerStrokeRadius * cos(i * pi / 180);
      var y2 = centerY + innerStrokeRadius * sin(i * pi / 180);

      canvas.drawLine(
          Offset(x1, y1),
          Offset(x2, y2),
          Paint()
            ..color = Colors.pink.shade200
            ..strokeWidth = roundStrokeWidth
            ..style = PaintingStyle.stroke);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
