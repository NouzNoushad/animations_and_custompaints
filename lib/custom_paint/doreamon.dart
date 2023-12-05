import 'package:flutter/material.dart';

class DoreamonDrawing extends StatelessWidget {
  const DoreamonDrawing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Container(
          height: 300,
          width: 300,
          color: Colors.yellow,
          child: CustomPaint(
            painter: DoreamonSmiling(),
          ),
        ),
      ),
    );
  }
}

class DoreamonSmiling extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var h = size.height;
    var w = size.width;

    // nose
    canvas.drawCircle(
        Offset(w / 2, h / 2), 15, Paint()..color = Colors.red.shade800);
    canvas.drawCircle(
        Offset(w / 2, h / 2),
        15,
        Paint()
          ..color = Colors.black
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke);

    // left eye
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(w * 0.4, h * 0.36), width: 60, height: 70),
        Paint()..color = Colors.white);
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(w * 0.4, h * 0.36), width: 60, height: 70),
        Paint()
          ..color = Colors.black
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke);

    // right eye
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(w * 0.6, h * 0.36), width: 60, height: 70),
        Paint()..color = Colors.white);
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(w * 0.6, h * 0.36), width: 60, height: 70),
        Paint()
          ..color = Colors.black
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke);

    // lip
    var path = Path()
      ..moveTo(w * 0.5, h * 0.55)
      ..lineTo(w * 0.5, h * 0.63)
      ..lineTo(w * 0.2, h * 0.63)
      ..quadraticBezierTo(w * 0.1, h * 0.55, w * 0.22, h * 0.5)
      ..moveTo(w * 0.5, h * 0.63)
      ..lineTo(w * 0.8, h * 0.63)
      ..quadraticBezierTo(w * 0.9, h * 0.55, w * 0.77, h * 0.5);

    canvas.drawPath(
        path,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5
          ..color = Colors.black);

    canvas.drawArc(
        Rect.fromCircle(center: Offset(w * 0.5, h * 0.63), radius: 90),
        6.25,
        3.2,
        true,
        Paint()
          ..style = PaintingStyle.fill
          ..color = Colors.red.shade800);
    canvas.drawArc(
        Rect.fromCircle(center: Offset(w * 0.5, h * 0.63), radius: 90),
        6.25,
        3.2,
        true,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = Colors.black);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
