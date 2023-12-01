import 'package:flutter/material.dart';

class ThermometerDesign extends StatelessWidget {
  const ThermometerDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomPaint(
          painter: ThermometerPainter(
            borderColor: Colors.black,
            innerColor: Colors.green,
            indicatorColor: Colors.red,
            textColor: Colors.black,
            stemWidth: 15.0,
            indicatorBulbWidth: 30.0,
            indicatorStemWidth: 7.0,
            temperature: 60.0,
          ),
          child: const SizedBox(
            height: 300,
            width: 50,
          ),
        ),
      ),
    );
  }
}

class ThermometerPainter extends CustomPainter {
  ThermometerPainter({
    this.borderColor,
    this.innerColor,
    this.indicatorColor,
    this.textColor,
    this.stemWidth,
    this.temperature,
    this.indicatorBulbWidth,
    this.indicatorStemWidth,
  }) {
    borderPaint = Paint()
      ..color = borderColor!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    innerPaint = Paint()
      ..color = innerColor!
      ..style = PaintingStyle.fill;
    indicatorPaint = Paint()
      ..color = indicatorColor!
      ..style = PaintingStyle.fill;
    textPainter = TextPainter()
      ..textDirection = TextDirection.ltr
      ..textAlign = TextAlign.center;
  }

  final Color? borderColor;
  final Color? innerColor;
  final Color? indicatorColor;
  final Color? textColor;

  double? stemWidth;
  double? temperature;
  double? bulbRadius;
  double? indicatorBulbWidth;
  double? indicatorStemWidth;
  double? minTempHeight;
  double? maxTempHeight;
  double? inset;
  double? tempHeight;

  TextPainter? textPainter;
  TextStyle? textStyle;

  Paint? borderPaint;
  Paint? innerPaint;
  Paint? indicatorPaint;

  static const double graduationTickLength = 5.0;

  @override
  void paint(Canvas canvas, Size size) {
    bulbRadius = size.width / 2;
    minTempHeight = bulbRadius;
    maxTempHeight = 0.9 * size.height;
    inset = (size.width - stemWidth!) / 2;
    tempHeight = temperature! / 100 * (maxTempHeight! - size.width);
    drawThermometerShape(canvas, size);
    drawIndicatorAndText(canvas, size);
    drawGraduations(canvas, size);
  }

  drawGraduations(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(inset! + stemWidth!, size.height - size.width);
    int markPoint = 0;
    for (int i = 1; i <= 5; i++) {
      canvas.drawLine(
          Offset.zero, const Offset(graduationTickLength, 0.0), borderPaint!);
      canvas.save();
      canvas.translate(graduationTickLength, 0.0);
      textStyle =
          TextStyle(color: borderColor, fontSize: indicatorBulbWidth! / 3);
      textPainter!.text = TextSpan(text: '$markPoint', style: textStyle);
      textPainter!.layout();
      textPainter!.paint(canvas, Offset(0.0, -(textPainter!.height / 2)));
      canvas.restore();
      canvas.translate(0.0, -0.25 * (maxTempHeight! - size.width));
      markPoint += 25;
    }
    canvas.restore();
  }

  void drawIndicatorAndText(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(size.width / 2, size.height - bulbRadius!),
        indicatorBulbWidth! / 2, indicatorPaint!);
    canvas.save();
    canvas.translate(bulbRadius!, size.height - bulbRadius!);
    canvas.drawLine(Offset.zero, Offset(0.0, -(minTempHeight! + tempHeight!)),
        indicatorPaint!);
    textStyle = TextStyle(
        color: textColor,
        fontWeight: FontWeight.bold,
        fontSize: indicatorBulbWidth! / 2);
    textPainter!.text =
        TextSpan(text: '${temperature!.toInt()}', style: textStyle);
    textPainter!.layout();
    textPainter!.paint(
        canvas, Offset(-(textPainter!.width / 2), -(textPainter!.height / 2)));
    canvas.restore();
  }

  void drawThermometerShape(Canvas canvas, Size size) {
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(inset!, 0.0, stemWidth!, size.height),
            const Radius.circular(10.0)),
        borderPaint!);
    canvas.drawCircle(Offset(size.width / 2, size.height - bulbRadius!),
        bulbRadius!, borderPaint!);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(inset!, 0.0, stemWidth!, size.height),
            const Radius.circular(10.0)),
        innerPaint!);
    canvas.drawCircle(Offset(size.width / 2, size.height - bulbRadius!),
        bulbRadius!, innerPaint!);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
