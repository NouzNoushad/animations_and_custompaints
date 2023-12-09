import 'package:flutter/material.dart';

class PikachuDrawing extends StatelessWidget {
  const PikachuDrawing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 350,
          width: 350,
          color: Colors.transparent,
          child: CustomPaint(
            painter: PikachuPainter(),
          ),
        ),
      ),
    );
  }
}

class PikachuPainter extends CustomPainter {
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

    canvas.translate(0, 0);
    // face
    canvas.drawPath(
        Path()
          ..moveTo(w * 0.42, h * 0.65)
          ..quadraticBezierTo(w * 0.2, h * 0.55, w * 0.28, h * 0.4)
          ..quadraticBezierTo(w * 0.25, h * 0.32, w * 0.3, h * 0.28)
          ..lineTo(w * 0.35, h * 0.23)
          ..quadraticBezierTo(w * 0.5, h * 0.15, w * 0.65, h * 0.23)
          ..lineTo(w * 0.7, h * 0.28)
          ..quadraticBezierTo(w * 0.75, h * 0.32, w * 0.72, h * 0.4)
          ..quadraticBezierTo(w * 0.8, h * 0.55, w * 0.58, h * 0.65),
        Paint()..color = Colors.yellow);

    // nose
    canvas.drawLine(
        Offset(w * 0.49, h * 0.45), Offset(w * 0.51, h * 0.45), paint);
    // mouth
    canvas.drawPath(
        Path()
          ..moveTo(w * 0.42, h * 0.5)
          ..quadraticBezierTo(w * 0.45, h * 0.55, w * 0.5, h * 0.5)
          ..quadraticBezierTo(w * 0.55, h * 0.55, w * 0.58, h * 0.5),
        paint);
    // left eye
    canvas.drawCircle(
        Offset(w * 0.37, h * 0.4), 13, Paint()..color = Colors.black);
    canvas.drawCircle(
        Offset(w * 0.38, h * 0.39), 6, Paint()..color = Colors.white);

    // right eye
    canvas.drawCircle(
        Offset(w * 0.63, h * 0.4), 13, Paint()..color = Colors.black);
    canvas.drawCircle(
        Offset(w * 0.62, h * 0.39), 6, Paint()..color = Colors.white);

    // left cheek

    canvas.drawPath(
        Path()
          ..moveTo(w * 0.42, h * 0.65)
          ..quadraticBezierTo(w * 0.2, h * 0.55, w * 0.28, h * 0.4)
          ..quadraticBezierTo(w * 0.25, h * 0.32, w * 0.3, h * 0.28),
        paint);

    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(w * 0.31, h * 0.51), width: 30, height: 36),
        Paint()..color = Colors.red);
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(w * 0.31, h * 0.51), width: 30, height: 36),
        paint);

    // right cheek

    canvas.drawPath(
        Path()
          ..moveTo(w * 0.58, h * 0.65)
          ..quadraticBezierTo(w * 0.8, h * 0.55, w * 0.72, h * 0.4)
          ..quadraticBezierTo(w * 0.75, h * 0.32, w * 0.7, h * 0.28),
        paint);

    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(w * 0.69, h * 0.51), width: 30, height: 36),
        Paint()..color = Colors.red);
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(w * 0.69, h * 0.51), width: 30, height: 36),
        paint);

    // head
    canvas.drawPath(
        Path()
          ..moveTo(w * 0.65, h * 0.23)
          ..quadraticBezierTo(w * 0.5, h * 0.15, w * 0.35, h * 0.23),
        paint);

    // left ear

    canvas.drawPath(
        Path()
          ..moveTo(w * 0.35, h * 0.23)
          ..quadraticBezierTo(w * 0.2, h * 0.05, w * 0, h * 0.05)
          ..quadraticBezierTo(w * 0.1, h * 0.2, w * 0.3, h * 0.28),
        Paint()..color = Colors.yellow);
    canvas.drawPath(
        Path()
          ..moveTo(w * 0.12, h * 0.07)
          ..quadraticBezierTo(w * -0.14, h * -0.025, w * 0.15, h * 0.2),
        Paint()..color = Colors.black);
    canvas.drawPath(
        Path()
          ..moveTo(w * 0.35, h * 0.23)
          ..quadraticBezierTo(w * 0.2, h * 0.05, w * 0, h * 0.05)
          ..quadraticBezierTo(w * 0.1, h * 0.2, w * 0.3, h * 0.28),
        paint);

    // right ear

    canvas.drawPath(
        Path()
          ..moveTo(w * 0.65, h * 0.23)
          ..quadraticBezierTo(w * 0.8, h * 0.05, w * 1, h * 0.05)
          ..quadraticBezierTo(w * 0.9, h * 0.2, w * 0.7, h * 0.28),
        Paint()..color = Colors.yellow);
    canvas.drawPath(
        Path()
          ..moveTo(w * 0.88, h * 0.07)
          ..quadraticBezierTo(w * 1.14, h * -0.025, w * 0.85, h * 0.2),
        Paint()..color = Colors.black);
    canvas.drawPath(
        Path()
          ..moveTo(w * 0.65, h * 0.23)
          ..quadraticBezierTo(w * 0.8, h * 0.05, w * 1, h * 0.05)
          ..quadraticBezierTo(w * 0.9, h * 0.2, w * 0.7, h * 0.28),
        paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
