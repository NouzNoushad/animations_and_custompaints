import 'package:flutter/material.dart';

class CatDrawing extends StatelessWidget {
  const CatDrawing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 400,
          width: 300,
          color: Colors.transparent,
          child: CustomPaint(
            painter: CatPainter(),
          ),
        ),
      ),
    );
  }
}

class CatPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var h = size.height;
    var w = size.width;
    var paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // nose and mouth
    canvas.drawPath(
        Path()
          ..moveTo(w * 0.5, h * 0.4)
          ..lineTo(w * 0.52, h * 0.38)
          ..lineTo(w * 0.48, h * 0.38)
          ..lineTo(w * 0.5, h * 0.4)
          ..quadraticBezierTo(w * 0.46, h * 0.42, w * 0.44, h * 0.4)
          ..moveTo(w * 0.5, h * 0.4)
          ..quadraticBezierTo(w * 0.54, h * 0.42, w * 0.56, h * 0.4),
        paint);

    // left eye
    canvas.drawCircle(
        Offset(w * 0.38, h * 0.36), 5, Paint()..color = Colors.black);

    // right eye
    canvas.drawCircle(
        Offset(w * 0.62, h * 0.36), 5, Paint()..color = Colors.black);

    // jaw
    canvas.drawPath(
        Path()
          ..moveTo(w * 0.3, h * 0.35)
          ..cubicTo(w * 0.25, h * 0.54, w * 0.75, h * 0.54, w * 0.7, h * 0.35),
        paint);

    // ear
    canvas.drawPath(
        Path()
          ..moveTo(w * 0.7, h * 0.35)
          ..lineTo(w * 0.69, h * 0.32)
          ..quadraticBezierTo(w * 0.7, h * 0.25, w * 0.66, h * 0.18)
          ..quadraticBezierTo(w * 0.62, h * 0.2, w * 0.58, h * 0.25)
          ..quadraticBezierTo(w * 0.5, h * 0.22, w * 0.42, h * 0.25)
          ..quadraticBezierTo(w * 0.38, h * 0.2, w * 0.34, h * 0.18)
          ..quadraticBezierTo(w * 0.3, h * 0.25, w * 0.31, h * 0.32)
          ..lineTo(w * 0.3, h * 0.35),
        paint);

    // left inner ear
    canvas.drawPath(
        Path()
          ..moveTo(w * 0.39, h * 0.26)
          ..lineTo(w * 0.33, h * 0.3)
          ..lineTo(w * 0.35, h * 0.21)
          ..close(),
        paint);

    // right inner ear
    canvas.drawPath(
        Path()
          ..moveTo(w * 0.61, h * 0.26)
          ..lineTo(w * 0.67, h * 0.3)
          ..lineTo(w * 0.65, h * 0.21)
          ..close(),
        paint);

    // left moustache
    canvas.drawPath(
        Path()
          ..moveTo(w * 0.34, h * 0.4)
          ..quadraticBezierTo(w * 0.28, h * 0.4, w * 0.25, h * 0.42)
          ..moveTo(w * 0.35, h * 0.42)
          ..quadraticBezierTo(w * 0.3, h * 0.43, w * 0.25, h * 0.47),
        paint);

    // right moustache
    canvas.drawPath(
        Path()
          ..moveTo(w * 0.66, h * 0.4)
          ..quadraticBezierTo(w * 0.72, h * 0.4, w * 0.75, h * 0.42)
          ..moveTo(w * 0.65, h * 0.42)
          ..quadraticBezierTo(w * 0.7, h * 0.43, w * 0.75, h * 0.47),
        paint);

    // body
    // canvas.drawPath(
    //     Path()
    //       ..moveTo(w * 0.38, h * 0.47)
    //       ..lineTo(w * 0.4, h * 0.8),
    //     paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
