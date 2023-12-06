import 'dart:math';

import 'package:flutter/material.dart';

class ProgressPainting extends StatefulWidget {
  const ProgressPainting({super.key});

  @override
  State<ProgressPainting> createState() => _ProgressPaintingState();
}

class _ProgressPaintingState extends State<ProgressPainting>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> progressAnimation;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2500));
    progressAnimation = Tween<double>(begin: 300, end: 0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.linear));
    controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (controller.isCompleted) {
              controller.reset();
            } else {
              controller.reset();
              controller.forward();
            }
          },
          label: const Text('Start')),
      body: Center(
        child: Container(
          height: 300,
          width: 300,
          color: Colors.transparent,
          child: AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return CustomPaint(
                  painter: RectangleLoader(
                    value: progressAnimation.value,
                    // maxValue: 10.0,
                  ),
                );
              }),
        ),
      ),
    );
  }
}

class RectangleLoader extends CustomPainter {
  RectangleLoader({
    required this.value,
  });

  final double value;
  @override
  void paint(Canvas canvas, Size size) {
    var h = size.height;
    var w = size.width;
    var centerX = w / 2;
    var centerY = h / 2;
    var radius = min(centerX, centerY);
    var offset = Offset(centerX, centerY);

    final paint = Paint()
      ..shader = const SweepGradient(
              colors: [Colors.purple, Colors.orange, Colors.pink],
              startAngle: pi / 2,
              endAngle: 2 * pi / 2,
              tileMode: TileMode.clamp,
              stops: [0.1, 0.6, 0.1])
          .createShader(Rect.fromCircle(center: offset, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    final path = Path()
      ..moveTo(0, value)
      ..lineTo(w, value)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class CustomCircularIndicator extends CustomPainter {
  CustomCircularIndicator({
    required this.value,
    required this.maxValue,
  });

  final double value;
  final double maxValue;

  @override
  void paint(Canvas canvas, Size size) {
    var h = size.height;
    var w = size.width;
    var centerX = w / 2;
    var centerY = h / 2;
    var radius = min(centerX, centerY);
    var strokeWidth = 10.0;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..shader = const SweepGradient(
              colors: [Colors.purple, Colors.green, Colors.blue, Colors.pink],
              startAngle: -pi / 2,
              endAngle: 3 * pi / 2,
              tileMode: TileMode.mirror)
          .createShader(Rect.fromCircle(
              center: Offset(centerX, centerY), radius: radius));
    canvas.drawCircle(
        Offset(centerX, centerY),
        radius,
        Paint()
          ..strokeWidth = strokeWidth
          ..color = Colors.grey.shade200
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke);
    canvas.drawArc(
        Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
        -pi / 2,
        2 * pi * value / maxValue,
        false,
        paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
