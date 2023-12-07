import 'package:flutter/material.dart';

class FrogDesign extends StatefulWidget {
  const FrogDesign({super.key});

  @override
  State<FrogDesign> createState() => _FrogDesignState();
}

class _FrogDesignState extends State<FrogDesign> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100,
        width: 100,
        color: Colors.yellow,
        child: CustomPaint(
          painter: FrogPainter(),
        ),
      ),
    );
  }
}

class FrogPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var h = size.height;
    var w = size.width;
    var centerX = w / 2;
    var centerY = h / 2;
    var offset = Offset(centerX, centerY);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
