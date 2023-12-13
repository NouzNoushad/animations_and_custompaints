import 'dart:math';

import 'package:flutter/material.dart';

class BrickAnimation extends StatefulWidget {
  const BrickAnimation({super.key});

  @override
  State<BrickAnimation> createState() => _BrickAnimationState();
}

class _BrickAnimationState extends State<BrickAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation1;
  late Animation<double> _rotationAnimation2;
  late Animation<double> _rotationAnimation3;
  late Animation<double> _rotationAnimation4;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _rotationAnimation1 = Tween<double>(begin: 0, end: pi).animate(
        CurvedAnimation(
            parent: _controller,
            curve: const Interval(0, 0.25, curve: Curves.linear)));
    _rotationAnimation2 = Tween<double>(begin: 0, end: -pi).animate(
        CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.25, 0.5, curve: Curves.linear)));
    _rotationAnimation3 = Tween<double>(begin: 0, end: pi).animate(
        CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.5, 0.75, curve: Curves.linear)));
    _rotationAnimation4 = Tween<double>(begin: 0, end: -pi).animate(
        CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.75, 1, curve: Curves.linear)));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () {
          if (_controller.isCompleted) {
            _controller.reverse();
          } else {
            _controller.forward();
          }
        },
        child: const Icon(Icons.play_arrow),
      ),
      body: Center(
        child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 50),
                    child: Brick(
                      rotationAnimation: _rotationAnimation1,
                      alignment: Alignment.centerRight,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 50),
                    child: Brick(
                      rotationAnimation: _rotationAnimation2,
                      alignment: Alignment.centerRight,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 50),
                    child: Brick(
                      rotationAnimation: _rotationAnimation3,
                      alignment: Alignment.centerRight,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 50),
                    child: Brick(
                      rotationAnimation: _rotationAnimation4,
                      alignment: Alignment.centerRight,
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}

class Brick extends StatelessWidget {
  const Brick(
      {super.key, required this.rotationAnimation, required this.alignment});
  final Animation<double> rotationAnimation;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()..rotateZ(rotationAnimation.value),
      alignment: alignment,
      child: Container(
        height: 10,
        width: 50,
        decoration: BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
