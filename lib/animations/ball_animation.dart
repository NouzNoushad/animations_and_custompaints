import 'dart:math';

import 'package:flutter/material.dart';

class BallBouncingAnimation extends StatefulWidget {
  const BallBouncingAnimation({super.key});

  @override
  State<BallBouncingAnimation> createState() => _BallBouncingAnimationState();
}

class _BallBouncingAnimationState extends State<BallBouncingAnimation>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController longPressController;
  late Animation<double> fallAnimation;
  late Animation<double> bounceUpAnimation;
  late Animation<double> rotationAnimation;
  late Animation<double> throwXUpAnimation;
  late Animation<double> throwYUpAnimation;
  late Animation<double> throwRotationAnimation;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    fallAnimation = Tween<double>(begin: 0, end: 250).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0.14, 0.5, curve: Curves.bounceInOut)));

    bounceUpAnimation = Tween<double>(begin: 0, end: 250).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.5, 0.9, curve: Curves.bounceInOut)));
    rotationAnimation = Tween<double>(begin: 0, end: pi).animate(
        CurvedAnimation(parent: controller, curve: Curves.bounceInOut));
    controller.addListener(() {
      setState(() {});
    });

    longPressController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    throwXUpAnimation = Tween<double>(begin: 0, end: 300).animate(
        CurvedAnimation(parent: longPressController, curve: Curves.easeOut));

    throwYUpAnimation = Tween<double>(begin: 0, end: -300).animate(
        CurvedAnimation(parent: longPressController, curve: Curves.easeOut));
    throwRotationAnimation = Tween<double>(begin: 0, end: pi).animate(
        CurvedAnimation(
            parent: longPressController, curve: Curves.bounceInOut));

    longPressController.addListener(() {
      setState(() {});
    });
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange.shade700,
        onPressed: () {
          controller.reset();
          longPressController.reset();
        },
        child: const Icon(Icons.replay),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            controller.reset();
            controller.forward();
          },
          onLongPress: () {
            longPressController.reset();
            longPressController.forward();
          },
          child: Transform(
            transform: Matrix4.identity()
              ..translate(throwXUpAnimation.value, throwYUpAnimation.value),
            child: Transform(
              transform: Matrix4.identity()
                ..translate(0.0, fallAnimation.value)
                ..translate(0.0, -bounceUpAnimation.value),
              child: Transform.rotate(
                angle: throwRotationAnimation.value,
                child: Transform.rotate(
                  angle: rotationAnimation.value,
                  child: CustomPaint(
                    painter: BallPainter(),
                    child: Container(
                      height: 100,
                      width: 100,
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BallPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var h = size.height;
    var w = size.width;
    var centerX = w / 2;
    var centerY = h / 2;
    var radius = min(centerX, centerY);
    var offset = Offset(centerX, centerY);
    canvas.drawCircle(offset, radius, Paint()..color = Colors.orange.shade600);
    canvas.drawCircle(
        offset,
        radius,
        Paint()
          ..color = Colors.black
          ..strokeWidth = 1
          ..style = PaintingStyle.stroke);
    canvas.drawLine(
        const Offset(50, 0),
        const Offset(50, 100),
        Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3);
    canvas.drawArc(
        Rect.fromCircle(center: const Offset(50, 140), radius: 100),
        4.2,
        1.05,
        false,
        Paint()
          ..color = Colors.black
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke);
    canvas.drawArc(
        Rect.fromCircle(center: const Offset(0, 50), radius: 30),
        5,
        2.5,
        false,
        Paint()
          ..color = Colors.black
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke);
    canvas.drawArc(
        Rect.fromCircle(center: const Offset(100, 50), radius: 30),
        1.9,
        2.5,
        false,
        Paint()
          ..color = Colors.black
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke);
  }

  // -x left, x right, y bottom, -y top
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
