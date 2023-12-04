import 'package:flutter/material.dart';

class BirdClockPendulum extends StatefulWidget {
  const BirdClockPendulum({super.key});

  @override
  State<BirdClockPendulum> createState() => _BirdClockPendulumState();
}

class _BirdClockPendulumState extends State<BirdClockPendulum>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> pendulumAnimation;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    pendulumAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: 0.5), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 0.5, end: 0), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: -0.5), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: -0.5, end: 0), weight: 1),
    ]).animate(CurvedAnimation(parent: controller, curve: Curves.linear));

    controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool isStarted = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.white,
          onPressed: () {
            setState(() {
              isStarted = !isStarted;
            });
            if (isStarted) {
              controller.repeat();
            } else {
              controller.reverse();
            }
          },
          label: Text(
            (isStarted ? 'stop' : 'start').toUpperCase(),
            style: const TextStyle(color: Colors.black),
          )),
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 200,
            width: 200,
            // color: Colors.yellow,
            child: CustomPaint(
              painter: BirdHouse(),
            ),
          ),
          SizedBox(
            height: 200,
            width: 200,
            // color: Colors.blue,
            child: AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  return Transform(
                    alignment: Alignment.topCenter,
                    transform: Matrix4.rotationZ(pendulumAnimation.value),
                    child: CustomPaint(
                      painter: Pendulum(),
                    ),
                  );
                }),
          ),
        ],
      )),
    );
  }
}

class Pendulum extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var h = size.height;
    var w = size.width;

    var paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    var path = Path()
      ..moveTo(w * 0.5, 0)
      ..lineTo(w * 0.5, h * 0.8)
      ..close();

    canvas.drawPath(path, paint);
    canvas.drawCircle(Offset(w * 0.5, h * 0.85), 10, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class BirdHouse extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var h = size.height;
    var w = size.width;

    var paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    var path = Path()
      ..moveTo(w * 0.5, h * 0.15)
      ..lineTo(0, h * 0.5)
      ..lineTo(w * 0.05, h * 0.5)
      ..lineTo(w * 0.2, h)
      ..lineTo(w * 0.8, h)
      ..lineTo(w * 0.95, h * 0.5)
      ..lineTo(w, h * 0.5)
      ..lineTo(w * 0.5, h * 0.15)
      ..close();
    canvas.drawPath(path, paint);

    canvas.drawCircle(Offset(w * 0.5, h * 0.6), 45, paint);
    canvas.drawCircle(Offset(w * 0.5, h * 0.6), 10, paint);
    canvas.drawCircle(Offset(w * 0.5, h * 0.74), 15, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
