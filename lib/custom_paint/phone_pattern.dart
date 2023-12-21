import 'package:flutter/material.dart';

class PhoneLockPattern extends StatefulWidget {
  const PhoneLockPattern({super.key});

  @override
  State<PhoneLockPattern> createState() => _PhoneLockPatternState();
}

class _PhoneLockPatternState extends State<PhoneLockPattern> {
  Offset? currentOffset;
  List<int> selectedCirclesIndexes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 36, 36, 36),
      body: SafeArea(
          child: GestureDetector(
        onPanUpdate: (details) {
          final renderBox = context.findRenderObject() as RenderBox;
          final position = renderBox.globalToLocal(details.globalPosition);
          setState(() {
            currentOffset = position - const Offset(0, 50);
          });
          for (var i = 0; i < 9; i++) {
            final circlePosition = getCurrentCirclePosition(
                renderBox.size.width, renderBox.size.height, 3, i);

            final distance = (circlePosition - position).distance;
            if (distance < 40 && !selectedCirclesIndexes.contains(i)) {
              print(distance);
              setState(() {
                selectedCirclesIndexes.add(i);
              });
            }
          }
        },
        onPanEnd: (details) {
          setState(() {
            currentOffset = null;
            selectedCirclesIndexes = [];
          });
        },
        onPanStart: (details) {},
        child: CustomPaint(
          painter: PatternPainter(
            currentOffset: currentOffset,
            selectedCirclesIndexes: selectedCirclesIndexes,
          ),
          size: Size.infinite,
        ),
      )),
    );
  }
}

class PatternPainter extends CustomPainter {
  PatternPainter({
    this.currentOffset,
    required this.selectedCirclesIndexes,
  });
  final Offset? currentOffset;
  final List<int> selectedCirclesIndexes;

  @override
  void paint(Canvas canvas, Size size) {
    var h = size.height;
    var w = size.width;

    for (var i = 0; i < 9; i++) {
      final position = getCurrentCirclePosition(w, h, 3, i);
      canvas.drawCircle(
          position,
          30,
          Paint()
            ..strokeWidth = 3
            ..style = PaintingStyle.stroke
            ..color = Colors.greenAccent);
      if (selectedCirclesIndexes.contains(i)) {
        canvas.drawCircle(
            position,
            10,
            Paint()
              ..color = Colors.greenAccent
              ..style = PaintingStyle.fill);
      }
    }

    if (selectedCirclesIndexes.isNotEmpty) {
      for (var i = 0; i < selectedCirclesIndexes.length - 1; i++) {
        final p1 = getCurrentCirclePosition(w, h, 3, selectedCirclesIndexes[i]);
        final p2 =
            getCurrentCirclePosition(w, h, 3, selectedCirclesIndexes[i + 1]);
        canvas.drawLine(
            p1,
            p2,
            Paint()
              ..color = Colors.greenAccent
              ..strokeWidth = 3
              ..style = PaintingStyle.fill
              ..strokeCap = StrokeCap.round);
      }
    }

    if (currentOffset != null && selectedCirclesIndexes.isNotEmpty) {
      final p1 = getCurrentCirclePosition(w, h, 3, selectedCirclesIndexes.last);
      canvas.drawLine(
          p1,
          currentOffset!,
          Paint()
            ..color = Colors.greenAccent
            ..strokeWidth = 3
            ..strokeCap = StrokeCap.round);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

Offset getCurrentCirclePosition(double w, double h, double n, int i) {
  final x = ((w / 1.2) / n) * (i % n) + (w / n) * 0.7;
  final y = ((h / 2) / n) * (i ~/ n) + (h / n) * 0.9;
  return Offset(x, y);
}
