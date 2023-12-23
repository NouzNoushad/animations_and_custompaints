import 'dart:math';

import 'package:flutter/material.dart';

class SpinLoading extends StatefulWidget {
  const SpinLoading({super.key});

  @override
  State<SpinLoading> createState() => _SpinLoadingState();
}

class _SpinLoadingState extends State<SpinLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacityAnimation;
  late Animation<double> rotationAnimation;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4))
          ..repeat();
    opacityAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 0.0, end: 1.0), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 0.0), weight: 1),
    ]).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
    rotationAnimation = Tween<double>(begin: 0.0, end: 2 * pi)
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
      body: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Center(
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationZ(rotationAnimation.value),
                child: SizedBox(
                  height: 300,
                  width: 300,
                  // color: Colors.yellow,
                  child: FadeTransition(
                    opacity: opacityAnimation,
                    child: CustomPaint(
                      painter: SpinPainter(opacity: opacityAnimation),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}

class SpinPainter extends CustomPainter {
  SpinPainter({required this.opacity});
  Animation<double> opacity;
  @override
  void paint(Canvas canvas, Size size) {
    var h = size.height;
    var w = size.width;
    var centerX = w / 2;
    var centerY = h / 2;
    var radius = min(centerX, centerY);
    var innerRadius = radius - 30;
    var paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 30
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i <= 360; i += 30) {
      var x = centerX + radius * cos(i * pi / 180);
      var y = centerY + radius * sin(i * pi / 180);
      var x1 = centerX + innerRadius * cos(i * pi / 180);
      var y1 = centerY + innerRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x, y), Offset(x1, y1), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
