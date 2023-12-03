import 'package:flutter/material.dart';

class BirdClock extends StatefulWidget {
  const BirdClock({super.key});

  @override
  State<BirdClock> createState() => _BirdClockState();
}

class _BirdClockState extends State<BirdClock>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> stretchAnimation;
  late Animation<double> stretch2Animation;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    stretchAnimation = Tween<double>(begin: 0, end: 200)
        .animate(CurvedAnimation(parent: controller, curve: Curves.bounceOut));
    stretch2Animation = Tween<double>(begin: 0, end: 200).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.3, 1, curve: Curves.bounceOut)));
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
      backgroundColor: Colors.white,
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
                  return CustomPaint(
                    painter: Pendulum(
                        stretchHeight: stretchAnimation.value,
                        stretch2Height: stretch2Animation.value),
                  );
                }),
          ),
        ],
      )),
    );
  }
}

class Pendulum extends CustomPainter {
  const Pendulum({
    required this.stretchHeight,
    required this.stretch2Height,
  });
  final double stretchHeight;
  final double stretch2Height;
  @override
  void paint(Canvas canvas, Size size) {
    var h = size.height;
    var w = size.width;

    var paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    var path = Path()
      ..moveTo(w * 0.4, 0)
      ..lineTo(w * 0.4, stretchHeight)
      ..close();

    canvas.drawPath(path, paint);
    canvas.drawCircle(Offset(w * 0.4, stretchHeight + 8), 10, paint);

    var path2 = Path()
      ..moveTo(w * 0.6, 0)
      ..lineTo(w * 0.6, stretch2Height)
      ..close();

    canvas.drawPath(path2, paint);
    canvas.drawCircle(Offset(w * 0.6, stretch2Height + 8), 10, paint);
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
