import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class CustomClockDesign extends StatefulWidget {
  const CustomClockDesign({super.key});

  @override
  State<CustomClockDesign> createState() => _CustomClockDesignState();
}

class _CustomClockDesignState extends State<CustomClockDesign> {
  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 300,
          width: 300,
          color: Colors.transparent,
          child: Transform.rotate(
            angle: -pi / 2,
            child: CustomPaint(
              painter: CustomClockPainter(),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomClockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var h = size.height;
    var w = size.width;
    var centerX = w / 2;
    var centerY = h / 2;
    var offset = Offset(centerX, centerY);
    var radius = min(centerX, centerY);
    var dateTime = DateTime.now();
    canvas.drawCircle(offset, radius - 10, Paint()..color = Colors.black);
    var hourHandX = centerX +
        60.0 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    var hourHandY = centerY +
        60.0 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    canvas.drawLine(
        offset,
        Offset(hourHandX, hourHandY),
        Paint()
          ..color = Colors.white
          ..strokeWidth = 7
          ..strokeCap = StrokeCap.square);
    var minuteHandX = centerX + 100.0 * cos(dateTime.minute * 6 * pi / 180);
    var minuteHandY = centerY + 100.0 * sin(dateTime.minute * 6 * pi / 180);
    canvas.drawLine(
        offset,
        Offset(minuteHandX, minuteHandY),
        Paint()
          ..color = Colors.white
          ..strokeWidth = 5
          ..strokeCap = StrokeCap.square);
    var secondHandX = centerX + 120.0 * cos(dateTime.second * 6 * pi / 180);
    var secondHandY = centerY + 120.0 * sin(dateTime.second * 6 * pi / 180);
    canvas.drawLine(
        offset,
        Offset(secondHandX, secondHandY),
        Paint()
          ..color = Colors.red
          ..strokeWidth = 3);
    canvas.drawCircle(offset, 8, Paint()..color = Colors.grey);
    var insideOuterCircleRadius = radius - 20;
    var insideInnerCircleRadius = radius - 23;
    var paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i <= 360; i += 6) {
      if (i % 30 == 0) {
        insideInnerCircleRadius = radius - 30;
      } else {
        insideInnerCircleRadius = radius - 23;
      }
      var x1 = centerX + insideOuterCircleRadius * cos(i * pi / 180);
      var x2 = centerX + insideInnerCircleRadius * cos(i * pi / 180);
      var y1 = centerY + insideOuterCircleRadius * sin(i * pi / 180);
      var y2 = centerY + insideInnerCircleRadius * sin(i * pi / 180);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
