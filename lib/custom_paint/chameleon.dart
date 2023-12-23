import 'package:flutter/material.dart';

class ChameleonDesign extends StatefulWidget {
  const ChameleonDesign({super.key});

  @override
  State<ChameleonDesign> createState() => _ChameleonDesignState();
}

class _ChameleonDesignState extends State<ChameleonDesign> {
  Color? selectedColor;
  double? selectedValue;

  @override
  void initState() {
    selectedColor = Colors.primaries[0];
    selectedValue = 0.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 153, 250, 203),
      body: Stack(
        children: [
          Center(
            child: Container(
              height: 300,
              width: 300,
              color: Colors.transparent,
              child: CustomPaint(
                painter: ChameleonPainter(selectedColor: selectedColor!),
              ),
            ),
          ),
          Positioned(
              bottom: 150,
              left: 10,
              child: SizedBox(
                  width: 400,
                  child: Slider(
                      activeColor: Colors.greenAccent.shade400,
                      inactiveColor: Colors.white,
                      value: selectedValue!,
                      onChanged: (value) {
                        var newValue = (selectedValue! * 10).floor();

                        setState(() {
                          selectedValue = value;
                          selectedColor = Colors.primaries[newValue];
                        });
                      })))
        ],
      ),
    );
  }
}

class ChameleonPainter extends CustomPainter {
  ChameleonPainter({required this.selectedColor});

  final Color selectedColor;
  @override
  void paint(Canvas canvas, Size size) {
    double h = size.height;
    double w = size.width;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = Colors.black;
    final colorPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = selectedColor;

    canvas.drawPath(
        Path()
          ..moveTo(w * 0, h * 0.68)
          ..lineTo(w, h * 0.64)
          ..lineTo(w, h * 0.68)
          ..lineTo(w * 0, h * 0.7)
          ..close(),
        Paint()
          ..color = const Color.fromARGB(255, 153, 41, 1)
          ..shader = const LinearGradient(colors: [
            Color.fromARGB(255, 224, 62, 3),
            Color.fromARGB(255, 230, 62, 0)
          ]).createShader(Rect.fromCenter(
              center: Offset(w / 2, h / 2), width: 80, height: 10)));

    canvas.drawLine(Offset(w * 0, h * 0.68), Offset(w, h * 0.64), paint);
    canvas.drawLine(Offset(w * 0, h * 0.7), Offset(w, h * 0.68), paint);

    canvas.drawPath(
        Path()
          ..moveTo(w * 0.65, h * 0.4)
          // back
          ..quadraticBezierTo(w * 0.38, h * 0.15, w * 0.2, h * 0.5)
          ..lineTo(w * 0.15, h * 0.6)
          // tail
          ..cubicTo(w * 0, h * 0.7, w * 0, h * 0.88, w * 0.2, h * 0.9)
          ..cubicTo(w * 0.25, h * 0.9, w * 0.28, h * 0.82, w * 0.22, h * 0.79)
          ..cubicTo(w * 0.15, h * 0.78, w * 0.15, h * 0.88, w * 0.2, h * 0.87)
          ..cubicTo(w * 0.24, h * 0.86, w * 0.2, h * 0.8, w * 0.18, h * 0.84)
          ..lineTo(w * 0.17, h * 0.86)
          ..cubicTo(w * 0.02, h * 0.8, w * 0.1, h * 0.66, w * 0.22, h * 0.6)
          ..lineTo(w * 0.3, h * 0.55)
          ..lineTo(w * 0.4, h * 0.7)
          ..lineTo(w * 0.43, h * 0.7)
          ..lineTo(w * 0.44, h * 0.66)
          ..lineTo(w * 0.4, h * 0.66)
          ..lineTo(w * 0.33, h * 0.5)
          ..lineTo(w * 0.29, h * 0.51)
          ..lineTo(w * 0.25, h * 0.58)
          ..lineTo(w * 0.65, h * 0.55)
          ..lineTo(w * 0.6, h * 0.45)
          ..lineTo(w * 0.5, h * 0.44)
          ..lineTo(w * 0.58, h * 0.65)
          ..lineTo(w * 0.58, h * 0.69)
          ..lineTo(w * 0.62, h * 0.69)
          ..lineTo(w * 0.64, h * 0.65)
          ..lineTo(w * 0.61, h * 0.65)
          ..lineTo(w * 0.55, h * 0.48)
          ..lineTo(w * 0.58, h * 0.49)
          ..lineTo(w * 0.66, h * 0.42)
          ..lineTo(w * 0.62, h * 0.55)
          ..lineTo(w * 0.68, h * 0.65)
          ..lineTo(w * 0.73, h * 0.65)
          ..lineTo(w * 0.7, h * 0.69)
          ..lineTo(w * 0.66, h * 0.69)
          ..lineTo(w * 0.65, h * 0.65)
          ..lineTo(w * 0.58, h * 0.55)
          ..lineTo(w * 0.65, h * 0.55)
          ..quadraticBezierTo(w * 0.75, h * 0.55, w * 0.85, h * 0.5)
          ..quadraticBezierTo(w * 0.82, h * 0.36, w * 0.64, h * 0.37)
          ..lineTo(w * 0.3, h * 0.58)
          ..lineTo(w * 0.24, h * 0.67)
          ..lineTo(w * 0.28, h * 0.67)
          ..lineTo(w * 0.25, h * 0.7)
          ..lineTo(w * 0.2, h * 0.7)
          ..lineTo(w * 0.2, h * 0.67)
          ..lineTo(w * 0.26, h * 0.58)
          ..lineTo(w * 0.85, h * 0.5),
        colorPaint);

    canvas.drawPath(
        Path()
          ..moveTo(w * 0.64, h * 0.4)
          ..lineTo(w * 0.62, h * 0.44)
          ..lineTo(w * 0.58, h * 0.35)
          ..lineTo(w * 0.55, h * 0.42)
          ..lineTo(w * 0.5, h * 0.31)
          ..lineTo(w * 0.45, h * 0.44)
          ..lineTo(w * 0.4, h * 0.3)
          ..lineTo(w * 0.38, h * 0.45)
          ..lineTo(w * 0.3, h * 0.35)
          ..lineTo(w * 0.3, h * 0.48)
          ..lineTo(w * 0.22, h * 0.46)
          ..quadraticBezierTo(
            w * 0.4,
            h * 0.17,
            w * 0.64,
            h * 0.39,
          ),
        Paint()..color = selectedColor.withBlue(1));

    canvas.drawCircle(Offset(w * 0.75, h * 0.44), 10,
        Paint()..color = selectedColor.withBlue(1));

    // border
    canvas.drawPath(
        Path()
          ..moveTo(w * 0.65, h * 0.4)
          ..quadraticBezierTo(w * 0.38, h * 0.15, w * 0.2, h * 0.5)
          ..lineTo(w * 0.15, h * 0.6)
          ..cubicTo(w * 0, h * 0.7, w * 0, h * 0.88, w * 0.2, h * 0.9)
          ..cubicTo(w * 0.25, h * 0.9, w * 0.28, h * 0.82, w * 0.22, h * 0.79)
          ..cubicTo(w * 0.15, h * 0.78, w * 0.15, h * 0.88, w * 0.2, h * 0.87)
          ..cubicTo(w * 0.24, h * 0.86, w * 0.2, h * 0.8, w * 0.18, h * 0.84)
          ..moveTo(w * 0.17, h * 0.86)
          ..cubicTo(w * 0.02, h * 0.8, w * 0.1, h * 0.66, w * 0.22, h * 0.6)
          ..lineTo(w * 0.3, h * 0.55)
          ..lineTo(w * 0.4, h * 0.7)
          ..lineTo(w * 0.43, h * 0.7)
          ..lineTo(w * 0.44, h * 0.66)
          ..lineTo(w * 0.4, h * 0.66)
          ..lineTo(w * 0.33, h * 0.5)
          ..lineTo(w * 0.29, h * 0.51)
          ..moveTo(w * 0.25, h * 0.58)
          ..lineTo(w * 0.65, h * 0.55)
          ..moveTo(w * 0.6, h * 0.45)
          ..lineTo(w * 0.5, h * 0.44)
          ..lineTo(w * 0.58, h * 0.65)
          ..lineTo(w * 0.58, h * 0.69)
          ..lineTo(w * 0.62, h * 0.69)
          ..lineTo(w * 0.64, h * 0.65)
          ..lineTo(w * 0.61, h * 0.65)
          ..lineTo(w * 0.55, h * 0.48)
          ..lineTo(w * 0.58, h * 0.49)
          ..moveTo(w * 0.65, h * 0.55)
          ..quadraticBezierTo(w * 0.75, h * 0.55, w * 0.85, h * 0.5)
          ..quadraticBezierTo(w * 0.82, h * 0.36, w * 0.64, h * 0.37)
          ..lineTo(w * 0.66, h * 0.42)
          // stripe
          ..moveTo(w * 0.64, h * 0.4)
          ..lineTo(w * 0.62, h * 0.44)
          ..lineTo(w * 0.58, h * 0.35)
          ..lineTo(w * 0.55, h * 0.42)
          ..lineTo(w * 0.5, h * 0.31)
          ..lineTo(w * 0.45, h * 0.44)
          ..lineTo(w * 0.4, h * 0.3)
          ..lineTo(w * 0.38, h * 0.45)
          ..lineTo(w * 0.3, h * 0.35)
          ..lineTo(w * 0.3, h * 0.48)
          ..lineTo(w * 0.22, h * 0.45)
          //
          ..moveTo(w * 0.62, h * 0.55)
          ..lineTo(w * 0.68, h * 0.65)
          ..lineTo(w * 0.73, h * 0.65)
          ..lineTo(w * 0.7, h * 0.69)
          ..lineTo(w * 0.66, h * 0.69)
          ..lineTo(w * 0.65, h * 0.65)
          ..lineTo(w * 0.58, h * 0.55)
          ..moveTo(w * 0.3, h * 0.58)
          ..lineTo(w * 0.24, h * 0.67)
          ..lineTo(w * 0.28, h * 0.67)
          ..lineTo(w * 0.25, h * 0.7)
          ..lineTo(w * 0.2, h * 0.7)
          ..lineTo(w * 0.2, h * 0.67)
          ..lineTo(w * 0.26, h * 0.58)
          ..moveTo(w * 0.85, h * 0.5)
          ..quadraticBezierTo(w * 0.8, h * 0.52, w * 0.7, h * 0.48),
        paint);

    canvas.drawCircle(Offset(w * 0.75, h * 0.44), 10, paint);
    canvas.drawCircle(Offset(w * 0.75, h * 0.43), 2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
