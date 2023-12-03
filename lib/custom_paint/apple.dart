import 'package:flutter/material.dart';

class AppleDrawing extends StatelessWidget {
  const AppleDrawing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CustomPaint(
          painter: AppleDesign(),
          child: SizedBox(
            height: 300,
            width: 300,
            // color: Colors.black,
            child: Center(
              child: Text(
                'Apple'.toUpperCase(),
                style: TextStyle(
                    color: Colors.red.withOpacity(0.2),
                    fontSize: 60,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AppleDesign extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var h = size.height;
    var w = size.width;

    var paint = Paint()..color = Colors.red.shade800;

    var path = Path()
      ..moveTo(w * 0.5, h * 0.15)
      ..quadraticBezierTo(w * 0.3, h * 0.02, w * 0.1, h * 0.27)
      ..quadraticBezierTo(0, h * 0.5, w * 0.2, h * 0.8)
      ..quadraticBezierTo(w * 0.36, h, w * 0.45, h * 0.9)
      ..quadraticBezierTo(w * 0.5, h * 0.87, w * 0.55, h * 0.9)
      ..quadraticBezierTo(w * 0.66, h, w * 0.8, h * 0.8)
      ..quadraticBezierTo(w, h * 0.5, w * 0.9, h * 0.27)
      ..quadraticBezierTo(w * 0.7, h * 0.02, w * 0.5, h * 0.15)
      ..close();

    canvas.drawPath(path, paint);

    var path2 = Path()
      ..moveTo(w * 0.5, h * 0.12)
      ..quadraticBezierTo(w * 0.4, h * 0.01, w * 0.6, 0)
      ..quadraticBezierTo(w * 0.8, h * 0.03, w * 0.5, h * 0.12)
      ..close();

    canvas.drawPath(path2, Paint()..color = Colors.green.shade800);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
