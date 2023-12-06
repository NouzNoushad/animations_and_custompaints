import 'dart:math';

import 'package:flutter/material.dart';

class DrawFlower extends StatefulWidget {
  const DrawFlower({super.key});

  @override
  State<DrawFlower> createState() => _DrawFlowerState();
}

class _DrawFlowerState extends State<DrawFlower> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 100,
            left: MediaQuery.of(context).size.width * 0.3,
            child: const Text(
              'flower',
              style: TextStyle(
                fontSize: 50,
                letterSpacing: 1,
                color: Color.fromARGB(45, 244, 67, 54),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: Container(
              height: 600,
              width: 300,
              color: Colors.transparent,
              child: CustomPaint(
                painter: CustomFlowerPainter(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomFlowerPainter extends CustomPainter {
  drawPetal(canvas, x, x1, y, y1, paint) {
    canvas.drawPath(
      Path()
        ..moveTo(x1, y1)
        ..arcToPoint(Offset(x, y), radius: const Radius.circular(1))
        ..lineTo(x, y)
        ..arcToPoint(Offset(x1, y1), radius: const Radius.circular(1)),
      paint,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    var h = size.height;
    var w = size.width;
    var centerX = w / 2;
    var centerY = h / 2;
    var offset = Offset(centerX, centerY);
    var radius = min(centerX, centerY);
    var innerRadius = radius - w / 2.5;
    var middleRadius = (radius + innerRadius) / 2;
    var paintPetal = Paint()
      ..shader = const RadialGradient(
              colors: [Colors.orange, Colors.deepOrange, Colors.red])
          .createShader(Rect.fromCircle(center: offset, radius: radius))
      ..style = PaintingStyle.fill;

    var paintSPetal = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = Colors.black;
    var paintSeed = Paint()..color = Colors.yellow;
    var paintSSeed = Paint()
      ..color = Colors.black
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    for (int i = 0; i <= 360; i += 60) {
      var x = centerX + radius * cos(pi * i / 180);
      var y = centerY + radius * sin(pi * i / 180);

      var x1 = centerX + innerRadius * cos(pi * i / 180);
      var y1 = centerY + innerRadius * sin(pi * i / 180);

      var x2 = centerX + middleRadius * cos(pi * i / 180);
      var y2 = centerY + middleRadius * sin(pi * i / 180);

      canvas.drawLine(Offset(x1, y1), Offset(x, y), paintPetal);

      drawPetal(canvas, x, x1, y, y1, paintPetal);
      drawPetal(canvas, x, x1, y, y1, paintSPetal);

      canvas.drawCircle(offset, 30, paintSeed);
      canvas.drawCircle(offset, 30, paintSSeed);

      canvas.drawPath(
          Path()
            ..moveTo(w * 0.15, h * 0.6)
            ..quadraticBezierTo(w * -0.1, h * 0.8, w * 0.25, h * 1.0),
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 5
            ..shader = LinearGradient(
              colors: [
                Colors.green.shade800,
                Colors.green,
                Colors.green.shade400
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
            ).createShader(Rect.fromCircle(center: offset, radius: radius)));

      canvas.drawPath(
          Path()
            ..moveTo(w * 0.08, h * 0.85)
            ..quadraticBezierTo(w * 0.3, h * 0.75, w * 0.5, h * 0.9)
            ..quadraticBezierTo(w * 0.2, h * 0.95, w * 0.08, h * 0.85),
          Paint()
            ..style = PaintingStyle.fill
            ..strokeWidth = 5
            ..shader = LinearGradient(colors: [
              Colors.green.shade800,
              Colors.green,
              Colors.green.shade200
            ]).createShader(Rect.fromCircle(center: offset, radius: radius)));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
