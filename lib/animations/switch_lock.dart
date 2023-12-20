import 'dart:math';

import 'package:flutter/material.dart';

class SwitchLock extends StatefulWidget {
  const SwitchLock({super.key});

  @override
  State<SwitchLock> createState() => _SwitchLockState();
}

class _SwitchLockState extends State<SwitchLock>
    with SingleTickerProviderStateMixin {
  bool isLocked = true;
  late AnimationController controller;
  late Animation<double> rotation;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300))
      ..reverse();
    rotation = Tween<double>(begin: -pi, end: -pi / 2).animate(
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 37, 37),
      body: Stack(
        children: [
          Positioned.fill(
              child: CustomPaint(
            painter: LockPainter(isLocked: isLocked, rotation: rotation),
          )),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isLocked ? 'Locked' : 'Unlock',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Switch.adaptive(
                    value: isLocked,
                    activeColor: Colors.green,
                    onChanged: (value) {
                      setState(() {
                        isLocked = !isLocked;
                      });
                      if (isLocked) {
                        controller.reverse();
                      } else {
                        controller.forward();
                      }
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
}

class LockPainter extends CustomPainter {
  LockPainter({required this.isLocked, required this.rotation});

  bool isLocked;
  Animation<double> rotation;
  @override
  void paint(Canvas canvas, Size size) {
    var h = size.height;
    var w = size.width;
    var paint = Paint()
      ..strokeWidth = 5
      ..color = isLocked ? Colors.white : Colors.green
      ..style = PaintingStyle.stroke;

    var path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
              center: size.center(Offset.zero), width: w / 2, height: h / 2),
          const Radius.circular(20),
        ),
      );
      
    var lockPaint = Paint()
      ..strokeWidth = 20
      ..shader
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..color = isLocked ? Colors.white : Colors.green;

    canvas.drawArc(
        Rect.fromCircle(center: size.center(const Offset(0, -180)), radius: 70),
        (isLocked ? 0 : 30) * pi / 180,
        rotation.value,
        false,
        lockPaint);

    canvas.drawPath(path, Paint()..color = Colors.black);
    if (!isLocked) {
      canvas.drawShadow(path, Colors.green.withOpacity(0.5), 3, true);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
