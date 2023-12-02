import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ClockDesign extends StatefulWidget {
  const ClockDesign({super.key});

  @override
  State<ClockDesign> createState() => _ClockDesignState();
}

class _ClockDesignState extends State<ClockDesign> {
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
          child: SizedBox(
        height: 300,
        width: 300,
        // color: Colors.yellow,
        child: Transform.rotate(
          angle: -pi / 2,
          child: CustomPaint(
            painter: ClockPainter(),
          ),
        ),
      )),
    );
  }
}

class ClockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    ///
    /// Radian formula: degree * pi / 180
    /// 60 s => 360 | 1 s => 6
    /// 60 m => 360 | 1 m => 6
    /// 12 h => 360 | 1 h => 30 && 60 m => 30 | 1m => 0.5 ( hr line will move after 1 min)
    ///
    DateTime dateTime = DateTime.now();
    var h = size.height;
    var w = size.width;
    var centerX = w / 2;
    var centerY = h / 2;
    var offset = Offset(centerX, centerY);
    var radius = min(centerX, centerY);
    var paint = Paint()..color = const Color.fromARGB(255, 109, 1, 131);
    var outLinePaint = Paint()
      ..color = Colors.pink
      ..strokeWidth = 16
      ..style = PaintingStyle.stroke;
    var centerPointPaint = Paint()..color = Colors.pink;
    var secondHandBrush = Paint()
      ..color = Colors.amber
      ..shader = const RadialGradient(colors: [Colors.red, Colors.redAccent])
          .createShader(Rect.fromCircle(center: offset, radius: radius))
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    var minuteHandBrush = Paint()
      ..color = Colors.amber
      ..shader =
          const RadialGradient(colors: [Colors.orange, Colors.orangeAccent])
              .createShader(Rect.fromCircle(center: offset, radius: radius))
      ..strokeWidth = 16
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    var hourHandBrush = Paint()
      ..color = Colors.amber
      ..shader = const RadialGradient(colors: [Colors.teal, Colors.tealAccent])
          .createShader(Rect.fromCircle(center: offset, radius: radius))
      ..strokeWidth = 16
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(offset, radius - 40, paint);
    canvas.drawCircle(offset, radius - 40, outLinePaint);
    var hourHandX = centerX +
        60 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    var hourHandY = centerY +
        60 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    canvas.drawLine(offset, Offset(hourHandX, hourHandY), hourHandBrush);
    var minuteHandX = centerX + 80 * cos(dateTime.minute * 6 * pi / 180);
    var minuteHandY = centerY + 80 * sin(dateTime.minute * 6 * pi / 180);
    canvas.drawLine(offset, Offset(minuteHandX, minuteHandY), minuteHandBrush);
    var secondHandX = centerX + 90 * cos(dateTime.second * 6 * pi / 180);
    var secondHandY = centerY + 90 * sin(dateTime.second * 6 * pi / 180);
    canvas.drawLine(offset, Offset(secondHandX, secondHandY), secondHandBrush);
    canvas.drawCircle(offset, 14, centerPointPaint);
    var outerCircleRadius = radius;
    var innerCircleRadius = radius - 20;
    for (int i = 0; i <= 360; i += 6) {
      var x1 = centerX + outerCircleRadius * cos(i * pi / 180);
      var x2 = centerX + innerCircleRadius * cos(i * pi / 180);
      var y1 = centerY + outerCircleRadius * sin(i * pi / 180);
      var y2 = centerY + innerCircleRadius * sin(i * pi / 180);
      if (i % 30 == 0) {
        centerPointPaint.strokeWidth = 4;
      } else {
        centerPointPaint.strokeWidth = 1;
      }
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), centerPointPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
