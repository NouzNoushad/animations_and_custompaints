import 'dart:math';

import 'package:flutter/material.dart';

class DotsLoading extends StatefulWidget {
  const DotsLoading({super.key});

  @override
  State<DotsLoading> createState() => _DotsLoadingState();
}

class _DotsLoadingState extends State<DotsLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> rotation;
  late Animation<double> circularLine;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    rotation = Tween<double>(begin: 0, end: 2 * pi)
        .animate(CurvedAnimation(parent: controller, curve: Curves.linear));
    circularLine = Tween<double>(begin: 0, end: 2 * pi)
        .animate(CurvedAnimation(parent: controller, curve: Curves.linear));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (controller.isCompleted) {
              controller.reverse();
            } else {
              controller.forward();
            }
          },
          label: const Text('Start')),
      body: Center(
        child: AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationZ(rotation.value),
                child: Container(
                  height: 200,
                  width: 200,
                  color: Colors.transparent,
                  child: CustomPaint(
                    painter: DotPainter(rotation: rotation.value),
                  ),
                ),
              );
            }),
      ),
    );
  }
}

class DotPainter extends CustomPainter {
  DotPainter({required this.rotation});
  double rotation;
  @override
  void paint(Canvas canvas, Size size) {
    var h = size.height;
    var w = size.width;
    var centerX = w / 2;
    var centerY = h / 2;
    var offset = Offset(centerX, centerY);

    canvas.drawArc(
        Rect.fromCircle(center: offset, radius: 60),
        -pi / 2,
        -rotation,
        false,
        Paint()
          ..style = PaintingStyle.stroke
          ..color = Colors.black
          ..strokeWidth = 2);
    canvas.drawCircle(
        Offset(w * 0.5, h * 0.2), 10, Paint()..color = Colors.purple);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
