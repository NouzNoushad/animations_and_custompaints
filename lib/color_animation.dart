import 'dart:math';

import 'package:flutter/material.dart';

class ColorAnimation extends StatefulWidget {
  const ColorAnimation({super.key});

  @override
  State<ColorAnimation> createState() => _ColorAnimationState();
}

Color getRandomColor() => Color(
      0xFF000000 + Random().nextInt(0x00FFFFFF),
    );

class _ColorAnimationState extends State<ColorAnimation> {
  var _color = getRandomColor();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipPath(
          clipper: CircleClipper(),
          child: TweenAnimationBuilder(
            duration: const Duration(seconds: 1),
            tween: ColorTween(
              begin: getRandomColor(),
              end: _color,
            ),
            onEnd: () {
              setState(() {
                _color = getRandomColor();
              });
            },
            builder: (context, color, child) => ColorFiltered(
                colorFilter: ColorFilter.mode(color!, BlendMode.srcATop),
                child: child),
            child: Container(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              color: Colors.red,
            ),
          ),
        ),
      )),
    );
  }
}

class CircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    var w = size.width;
    var h = size.height;

    final rect = Rect.fromCircle(center: Offset(w / 2, h / 2), radius: w / 2);
    path.addOval(rect);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
