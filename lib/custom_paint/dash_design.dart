import 'dart:math';

import 'package:flutter/material.dart';

class DashDesign extends StatefulWidget {
  const DashDesign({super.key});

  @override
  State<DashDesign> createState() => _DashDesignState();
}

class _DashDesignState extends State<DashDesign> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              height: 300,
              width: 400,
              color: Colors.transparent,
              child: CustomPaint(
                painter: DashPainter(),
              ),
            ),
          ),
          Positioned(
              bottom: 100,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'Flutter Dash',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyan.withOpacity(0.3),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

class DashPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var h = size.height;
    var w = size.width;
    var centerX = w / 2;
    var centerY = h / 2;
    var offset = Offset(centerX, centerY);
    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.black;

    // head
    canvas.drawArc(
        Rect.fromCenter(
            center: Offset(w * 0.5, h * 0.18), width: 40, height: 50),
        pi,
        pi,
        false,
        Paint()..color = Colors.cyan.shade300);

    // body
    canvas.drawArc(Rect.fromCenter(center: offset, width: 180, height: 200), pi,
        2 * pi, false, Paint()..color = Colors.cyan.shade300);

    // left eye
    canvas.drawArc(
        Rect.fromCenter(
            center: Offset(w * 0.43, h * 0.4), width: 65, height: 65),
        pi,
        2 * pi,
        false,
        Paint()..color = Colors.blue.shade500);
    canvas.drawCircle(Offset(w * 0.43, h * 0.4), 18,
        Paint()..color = const Color.fromARGB(255, 46, 46, 46));
    canvas.drawCircle(
        Offset(w * 0.43, h * 0.4),
        18,
        Paint()
          ..color = Colors.greenAccent
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke);
    canvas.drawCircle(
        Offset(w * 0.45, h * 0.38), 4, Paint()..color = Colors.white);

    // right eye
    canvas.drawArc(
        Rect.fromCenter(
            center: Offset(w * 0.57, h * 0.4), width: 65, height: 65),
        pi,
        2 * pi,
        false,
        Paint()..color = Colors.blue.shade500);
    canvas.drawCircle(Offset(w * 0.57, h * 0.4), 18,
        Paint()..color = const Color.fromARGB(255, 46, 46, 46));
    canvas.drawCircle(
        Offset(w * 0.57, h * 0.4),
        18,
        Paint()
          ..color = Colors.greenAccent
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke);
    canvas.drawCircle(
        Offset(w * 0.59, h * 0.38), 4, Paint()..color = Colors.white);

    // belly
    canvas.drawPath(
        Path()
          ..moveTo(w * 0.5, h * 0.83)
          ..cubicTo(w * 0.8, h * 0.7, w * 0.6, h * 0.5, w * 0.5, h * 0.55)
          ..cubicTo(w * 0.4, h * 0.5, w * 0.2, h * 0.7, w * 0.5, h * 0.83),
        Paint()..color = Colors.white);

    // beak
    canvas.drawPath(
        Path()
          ..moveTo(w * 0.47, h * 0.45)
          ..quadraticBezierTo(w * 0.5, h * 0.75, w * 0.53, h * 0.45)
          ..quadraticBezierTo(w * 0.5, h * 0.4, w * 0.47, h * 0.45),
        Paint()..color = Colors.brown);

    // left legs
    canvas.drawPath(
        Path()
          ..moveTo(w * 0.48, h * 0.83)
          ..lineTo(w * 0.48, h * 0.9)
          ..quadraticBezierTo(w * 0.52, h * 0.92, w * 0.48, h * 0.95)
          ..lineTo(w * 0.47, h * 0.92)
          ..quadraticBezierTo(w * 0.46, h * 0.97, w * 0.45, h * 0.92)
          ..quadraticBezierTo(w * 0.435, h * 0.95, w * 0.43, h * 0.9)
          ..lineTo(w * 0.46, h * 0.89)
          ..lineTo(w * 0.46, h * 0.82),
        Paint()..color = Colors.brown);

    // right legs
    canvas.drawPath(
        Path()
          ..moveTo(w * 0.52, h * 0.83) // 48 = 52
          ..lineTo(w * 0.52, h * 0.9) // 48 = 52, 52 = 68,
          ..quadraticBezierTo(w * 0.48, h * 0.92, w * 0.52, h * 0.95)
          ..lineTo(w * 0.53,
              h * 0.92) // 47 = 53, 46 = 54, 45 = 55, 435 = 585, 43 = 58
          ..quadraticBezierTo(w * 0.54, h * 0.97, w * 0.55, h * 0.92)
          ..quadraticBezierTo(w * 0.575, h * 0.95, w * 0.57, h * 0.9)
          ..lineTo(w * 0.54, h * 0.89)
          ..lineTo(w * 0.54, h * 0.82),
        Paint()..color = Colors.brown);

    // left wing
    canvas.drawPath(
        Path()
          ..moveTo(w * 0.28, h * 0.5)
          ..quadraticBezierTo(w * 0.25, h * 0.55, w * 0.1, h * 0.45)
          ..quadraticBezierTo(w * 0.05, h * 0.48, w * 0.08, h * 0.52)
          ..quadraticBezierTo(w * 0.02, h * 0.58, w * 0.08, h * 0.6)
          ..quadraticBezierTo(w * 0.02, h * 0.8, w * 0.18, h * 0.69)
          ..lineTo(w * 0.29, h * 0.6),
        Paint()..color = Colors.blue.shade500);

    // right wing
    canvas.drawPath(
        Path()
          ..moveTo(w * 0.72, h * 0.5) //
          ..quadraticBezierTo(w * 0.75, h * 0.55, w * 0.9, h * 0.45)
          ..quadraticBezierTo(w * 0.95, h * 0.48, w * 0.92, h * 0.52)
          ..quadraticBezierTo(w * 0.96, h * 0.58, w * 0.92, h * 0.6)
          ..quadraticBezierTo(w * 0.96, h * 0.8, w * 0.82, h * 0.69)
          ..lineTo(w * 0.71, h * 0.6),
        Paint()..color = Colors.blue.shade500);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
