import 'package:flutter/material.dart';

class DoreamonDrawing extends StatelessWidget {
  const DoreamonDrawing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 3, color: Colors.black),
                borderRadius: BorderRadius.circular(20),
              ),
              child: CustomPaint(
                painter: DoreamonSmiling(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Doreamon'.toUpperCase(),
              style: const TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ],
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
          ..strokeWidth = 1.5
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
          ..strokeWidth = 2.5
          ..style = PaintingStyle.stroke);

    canvas.drawArc(
        Rect.fromCircle(center: Offset(w * 0.43, h * 0.4), radius: 12),
        3.2,
        3,
        false,
        Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3.5);

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
          ..strokeWidth = 2.5
          ..style = PaintingStyle.stroke);

    canvas.drawArc(
        Rect.fromCircle(center: Offset(w * 0.57, h * 0.4), radius: 12),
        3.2,
        3,
        false,
        Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3.5);

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
          ..strokeWidth = 2.8
          ..color = Colors.black);

    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..color = Colors.black;
    // moustache
    canvas.drawLine(
        Offset(w * 0.4, h * 0.52), Offset(w * 0.15, h * 0.45), paint);
    canvas.drawLine(
        Offset(w * 0.4, h * 0.55), Offset(w * 0.15, h * 0.52), paint);
    canvas.drawLine(
        Offset(w * 0.4, h * 0.58), Offset(w * 0.15, h * 0.6), paint);

    canvas.drawLine(
        Offset(w * 0.6, h * 0.52), Offset(w * 0.85, h * 0.45), paint);
    canvas.drawLine(
        Offset(w * 0.6, h * 0.55), Offset(w * 0.85, h * 0.52), paint);
    canvas.drawLine(
        Offset(w * 0.6, h * 0.58), Offset(w * 0.85, h * 0.6), paint);

    // mouth
    canvas.drawArc(
        Rect.fromCircle(center: Offset(w * 0.5, h * 0.64), radius: 85),
        6.25,
        3.2,
        true,
        Paint()
          ..style = PaintingStyle.fill
          ..color = Colors.red.shade800);
    canvas.drawArc(
        Rect.fromCircle(center: Offset(w * 0.5, h * 0.64), radius: 85),
        6.25,
        3.2,
        true,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5
          ..color = Colors.black);

    // tongue
    var path1 = Path()
      ..moveTo(w * 0.5, h * 0.8)
      ..quadraticBezierTo(w * 0.35, h * 0.7, w * 0.3, h * 0.84)
      ..quadraticBezierTo(w * 0.5, h, w * 0.7, h * 0.84)
      ..quadraticBezierTo(w * 0.65, h * 0.7, w * 0.5, h * 0.8)
      ..close();

    canvas.drawPath(
        path1,
        Paint()
          ..style = PaintingStyle.fill
          ..color = const Color.fromARGB(255, 235, 80, 33));

    // chin
    var path2 = Path()
      ..moveTo(w * 0.3, h * 0.38)
      ..quadraticBezierTo(w * -0.06, h * 0.5, w * 0.26, h)
      ..lineTo(w * 0.74, h)
      ..quadraticBezierTo(w * 1.06, h * 0.5, w * 0.7, h * 0.38);

    canvas.drawPath(path2, paint);

    // head
    canvas.drawArc(
        Rect.fromCircle(center: Offset(w * 0.5, h * 0.6), radius: 140),
        2.1,
        5.2,
        false,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3
          ..color = Colors.black);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
