import 'dart:math';

import 'package:flutter/material.dart';

class TextWaveAnimation extends StatefulWidget {
  const TextWaveAnimation({super.key});

  @override
  State<TextWaveAnimation> createState() => _TextWaveAnimationState();
}

class _TextWaveAnimationState extends State<TextWaveAnimation>
    with TickerProviderStateMixin {
  late AnimationController waveController, loadController;
  late Animation loadValue;
  late double boxHeight, boxWidth;
  late Color backgroundColor, waveColor;
  late Duration waveDuration, loadDuration;
  late TextStyle textStyle;
  late GlobalKey textKey;

  @override
  void initState() {
    textKey = GlobalKey();
    boxHeight = 250;
    boxWidth = 400;
    waveDuration = const Duration(milliseconds: 2000);
    loadDuration = const Duration(milliseconds: 6000);
    waveController = AnimationController(vsync: this, duration: waveDuration);
    loadController = AnimationController(vsync: this, duration: loadDuration);
    loadValue = Tween<double>(begin: 0.0, end: 100.0).animate(loadController);
    backgroundColor = Colors.white;
    waveColor = Colors.blueAccent;
    waveController.repeat();
    loadController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.arrow_forward_ios),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: boxHeight,
            width: boxWidth,
            child: AnimatedBuilder(
              animation: waveController,
              builder: (context, child) {
                return CustomPaint(
                  painter: WavePainter(
                      waveAnimation: waveController,
                      percentValue: loadValue.value,
                      boxHeight: boxHeight,
                      waveColor: waveColor,
                      textKey: textKey),
                );
              },
            ),
          ),
          SizedBox(
            height: boxHeight,
            width: boxWidth,
            child: ShaderMask(
              blendMode: BlendMode.srcOut,
              shaderCallback: (bounds) =>
                  LinearGradient(colors: [backgroundColor], stops: const [0.0])
                      .createShader(bounds),
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Text(
                    'wave',
                    key: textKey,
                    style: const TextStyle(
                      fontSize: 150,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  WavePainter({
    required this.waveAnimation,
    required this.percentValue,
    required this.boxHeight,
    required this.waveColor,
    required this.textKey,
  });

  Animation<double> waveAnimation;
  double percentValue;
  double boxHeight;
  Color waveColor;
  GlobalKey textKey;

  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width;
    double height = size.height;
    var textBox = textKey.currentContext!.findRenderObject() as RenderBox;

    double textHeight = textBox.size.height;
    double percent = percentValue / 100.0;
    double baseHeight =
        (boxHeight / 2) + (textHeight / 2) - (percent * textHeight);
    Path path = Path();
    path.moveTo(0.0, baseHeight);
    for (double i = 0.0; i < width; i++) {
      path.lineTo(
          i,
          baseHeight +
              sin((i / width * 2 * pi) + (waveAnimation.value * 2 * pi)) * 8);
    }
    path.lineTo(width, height);
    path.lineTo(0.0, height);
    path.close();
    canvas.drawPath(path, Paint()..color = waveColor);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
