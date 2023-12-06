import 'dart:math';

import 'package:flutter/material.dart';

class FlowerDesign extends StatelessWidget {
  const FlowerDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Paint Flower'),
      ),
      body: Center(
        child: CustomPaint(
          painter: CirclePainter(),
          child: const SizedBox(
            height: 200,
            width: 200,
            // color: Colors.yellow,
          ),
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var h = size.height;
    var w = size.width;
    var centerX = w / 2;
    var centerY = h / 2;
    var radius = min(centerX, centerY);
    var paint = Paint()
      ..color = Colors.purple
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    for (int i = 0; i <= 360; i += 30) {
      var x = centerX + radius * cos(i * pi / 180);
      var y = centerY + radius * sin(i * pi / 180);
      canvas.drawCircle(Offset(x, y), 20, paint);
      canvas.drawLine(
          Offset(centerX, centerY),
          Offset(x, y),
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2
            ..color = Colors.purple);
    }
    canvas.drawCircle(
        Offset(centerX, centerY),
        50,
        Paint()
          ..color = Colors.green
          ..strokeWidth = 2
          ..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

// class ManFacePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint skinPaint = Paint()
//       ..color = const Color(0xFFECC29E)
//       ..style = PaintingStyle.fill;

//     Paint eyePaint = Paint()
//       ..color = Colors.white
//       ..style = PaintingStyle.fill;

//     Paint blackPaint = Paint()
//       ..color = Colors.black
//       ..style = PaintingStyle.fill;

//     double centerX = size.width / 2;
//     double centerY = size.height / 2;

//     // Draw face
//     canvas.drawCircle(Offset(centerX, centerY), 80.0, skinPaint);

//     // Draw eyes
//     canvas.drawCircle(Offset(centerX - 30, centerY - 20), 12.0, eyePaint);
//     canvas.drawCircle(Offset(centerX + 30, centerY - 20), 12.0, eyePaint);

//     // Draw pupils
//     canvas.drawCircle(Offset(centerX - 30, centerY - 20), 6.0, blackPaint);
//     canvas.drawCircle(Offset(centerX + 30, centerY - 20), 6.0, blackPaint);

//     // Draw nose
//     Path path = Path()
//       ..moveTo(centerX, centerY)
//       ..lineTo(centerX - 10, centerY + 20)
//       ..lineTo(centerX + 10, centerY + 20)
//       ..close();
//     canvas.drawPath(path, blackPaint);

//     // Draw mouth
//     Rect mouthRect =
//         Rect.fromCircle(center: Offset(centerX, centerY + 30), radius: 30.0);
//     canvas.drawArc(mouthRect, 0, pi, false, blackPaint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }

// class FlowerPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint petalPaint = Paint()
//       ..color = Colors.red
//       ..style = PaintingStyle.fill;

//     Paint centerPaint = Paint()
//       ..color = Colors.yellow
//       ..style = PaintingStyle.fill;

//     double petalWidth = 20.0;
//     double petalHeight = 50.0;
//     double centerX = size.width / 2;
//     double centerY = size.height / 2;

//     // Draw petals
//     for (int i = 0; i < 6; i++) {
//       double angle = (2 * pi / 6) * i;
//       double x = centerX + petalWidth * cos(angle);
//       double y = centerY + petalHeight * sin(angle);
//       canvas.drawOval(
//           Rect.fromPoints(Offset(centerX, centerY), Offset(x, y)), petalPaint);
//     }

//     // Draw center circle
//     canvas.drawCircle(Offset(centerX, centerY), 15.0, centerPaint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }
