import 'dart:math';

import 'package:flutter/material.dart';

class FrogHeadDrawing extends StatefulWidget {
  const FrogHeadDrawing({super.key});

  @override
  State<FrogHeadDrawing> createState() => _FrogHeadDrawingState();
}

class _FrogHeadDrawingState extends State<FrogHeadDrawing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned(
              bottom: 0,
              child: Text(
                'Frog',
                style: TextStyle(
                  fontSize: 80,
                  color: Colors.black12,
                  fontWeight: FontWeight.bold,
                ),
              )),
          Center(
            child: Container(
              height: 300,
              width: 300,
              color: Colors.transparent,
              child: CustomPaint(painter: FrogHead()),
            ),
          ),
        ],
      ),
    );
  }
}

class FrogHead extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var h = size.height;
    var w = size.width;

    var paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // head
    canvas.drawPath(
        Path()
          ..moveTo(w * 0.05, h * 0.61)
          ..quadraticBezierTo(w * 0.05, h * 0.55, w * 0.13, h * 0.46)
          ..quadraticBezierTo(w * 0.12, h * 0.42, w * 0.17, h * 0.36)
          ..lineTo(w * 0.23, h * 0.25)
          ..quadraticBezierTo(w * 0.32, h * 0.14, w * 0.43, h * 0.28)
          ..quadraticBezierTo(w * 0.5, h * 0.25, w * 0.57, h * 0.28)
          ..quadraticBezierTo(w * 0.68, h * 0.14, w * 0.77, h * 0.25)
          ..lineTo(w * 0.83, h * 0.36)
          ..quadraticBezierTo(w * 0.88, h * 0.42, w * 0.87, h * 0.46)
          ..quadraticBezierTo(w * 0.95, h * 0.55, w * 0.95, h * 0.61)
          ..moveTo(w * 0.85, h * 0.6)
          ..quadraticBezierTo(w * 0.5, h * 0.85, w * 0.15, h * 0.6)
          ..close(),
        Paint()..color = const Color.fromRGBO(171, 199, 85, 1));
    canvas.drawPath(
        Path()
          ..moveTo(w * 0.05, h * 0.6)
          ..lineTo(w * 0.15, h * 0.6)
          ..quadraticBezierTo(w * 0.5, h * 0.85, w * 0.85, h * 0.6)
          ..lineTo(w * 0.95, h * 0.6)
          ..cubicTo(w * 0.92, h * 0.95, w * 0.08, h * 0.95, w * 0.05, h * 0.6),
        Paint()
          ..color = const Color.fromRGBO(215, 221, 195, 1)
          ..style = PaintingStyle.fill);

    // left nose
    canvas.drawOval(
        Rect.fromCenter(center: Offset(w * 0.4, h * 0.5), width: 10, height: 5),
        Paint()..color = Colors.black);
    canvas.drawArc(
        Rect.fromCenter(
            center: Offset(w * 0.4, h * 0.5), width: 20, height: 15),
        -pi * 0.5,
        pi * 0.5,
        false,
        paint);
    canvas.drawPath(
        Path()
          ..moveTo(w * 0.44, h * 0.45)
          ..quadraticBezierTo(w * 0.4, h * 0.4, w * 0.4, h * 0.35),
        paint);

    // right nose
    canvas.drawOval(
        Rect.fromCenter(center: Offset(w * 0.6, h * 0.5), width: 10, height: 5),
        Paint()..color = Colors.black);
    canvas.drawArc(
        Rect.fromCenter(
            center: Offset(w * 0.6, h * 0.5), width: 20, height: 15),
        -pi * 0.5,
        -pi * 0.5,
        false,
        paint);
    canvas.drawPath(
        Path()
          ..moveTo(w * 0.56, h * 0.45)
          ..quadraticBezierTo(w * 0.6, h * 0.4, w * 0.6, h * 0.35),
        paint);

    // left eye
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(w * 0.25, h * 0.35), width: 50, height: 60),
        Paint()..color = Colors.white);
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(w * 0.25, h * 0.35), width: 50, height: 60),
        paint);
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(w * 0.27, h * 0.36), width: 30, height: 40),
        Paint()..color = Colors.black);
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(w * 0.24, h * 0.34), width: 15, height: 18),
        Paint()..color = Colors.white);

    // right eye
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(w * 0.75, h * 0.35), width: 50, height: 60),
        Paint()..color = Colors.white);
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(w * 0.75, h * 0.35), width: 50, height: 60),
        paint);
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(w * 0.73, h * 0.36), width: 30, height: 40),
        Paint()..color = Colors.black);
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(w * 0.76, h * 0.34), width: 15, height: 18),
        Paint()..color = Colors.white);

    // jaw
    canvas.drawArc(
        Rect.fromCenter(
            center: Offset(w * 0.5, h * 0.6), width: w * 0.9, height: h * 0.52),
        pi,
        -pi,
        false,
        paint);

    // left jaw
    canvas.drawPath(
        Path()
          ..moveTo(w * 0.05, h * 0.6)
          ..quadraticBezierTo(w * 0.05, h * 0.55, w * 0.13, h * 0.46)
          ..quadraticBezierTo(w * 0.12, h * 0.42, w * 0.17, h * 0.36),
        paint);

    // right jaw
    canvas.drawPath(
        Path()
          ..moveTo(w * 0.95, h * 0.6)
          ..quadraticBezierTo(w * 0.95, h * 0.55, w * 0.87, h * 0.46)
          ..quadraticBezierTo(w * 0.88, h * 0.42, w * 0.83, h * 0.36),
        paint);

    // eyebrow
    canvas.drawPath(
        Path()
          ..moveTo(w * 0.23, h * 0.25)
          ..quadraticBezierTo(w * 0.32, h * 0.14, w * 0.43, h * 0.28)
          ..quadraticBezierTo(w * 0.5, h * 0.25, w * 0.57, h * 0.28)
          ..quadraticBezierTo(w * 0.68, h * 0.14, w * 0.77, h * 0.25),
        paint);

    // mouth
    canvas.drawPath(
        Path()
          ..moveTo(w * 0.12, h * 0.64)
          ..quadraticBezierTo(w * 0.07, h * 0.6, w * 0.12, h * 0.57)
          ..moveTo(w * 0.1, h * 0.6)
          ..lineTo(w * 0.15, h * 0.6)
          ..quadraticBezierTo(w * 0.5, h * 0.85, w * 0.85, h * 0.6)
          ..lineTo(w * 0.9, h * 0.6)
          ..moveTo(w * 0.88, h * 0.64)
          ..quadraticBezierTo(w * 0.93, h * 0.6, w * 0.88, h * 0.57),
        paint);

    // lower lip
    canvas.drawPath(
        Path()
          ..moveTo(w * 0.42, h * 0.76)
          ..quadraticBezierTo(w * 0.5, h * 0.8, w * 0.58, h * 0.76),
        paint..strokeWidth = 1.5);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
