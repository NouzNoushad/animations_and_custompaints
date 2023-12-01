import 'dart:math';

import 'package:flutter/material.dart';

class ThreeDimensionAnimation extends StatefulWidget {
  const ThreeDimensionAnimation({super.key});

  @override
  State<ThreeDimensionAnimation> createState() =>
      _ThreeDimensionAnimationState();
}

const double widthAndHeight = 100;

class _ThreeDimensionAnimationState extends State<ThreeDimensionAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late AnimationController _controller3;

  late Tween<double> _animation;

  @override
  void initState() {
    _controller1 =
        AnimationController(vsync: this, duration: const Duration(seconds: 10));
    _controller2 =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));
    _controller3 =
        AnimationController(vsync: this, duration: const Duration(seconds: 30));
    _animation = Tween<double>(begin: 0, end: pi * 2);
    super.initState();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller1
      ..reset()
      ..repeat();
    _controller2
      ..reset()
      ..repeat();
    _controller3
      ..reset()
      ..repeat();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            AnimatedBuilder(
                animation: Listenable.merge(
                    [_controller1, _controller2, _controller3]),
                builder: (context, child) {
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..rotateX(_animation.evaluate(_controller1))
                      ..rotateY(_animation.evaluate(_controller2))
                      ..rotateZ(_animation.evaluate(_controller3)),
                    child: Stack(
                      children: [
                        //back
                        Transform(
                          alignment: Alignment.center,
                          transform:
                              Matrix4.translationValues(0, 0, -widthAndHeight),
                          child: Container(
                            color: Colors.purple,
                            width: widthAndHeight,
                            height: widthAndHeight,
                          ),
                        ),
                        //left
                        Transform(
                          alignment: Alignment.centerLeft,
                          transform: Matrix4.identity()..rotateY(pi / 2),
                          child: Container(
                            color: Colors.red,
                            width: widthAndHeight,
                            height: widthAndHeight,
                          ),
                        ),
                        //right
                        Transform(
                          alignment: Alignment.centerRight,
                          transform: Matrix4.identity()..rotateY(-pi / 2),
                          child: Container(
                            color: Colors.blue,
                            width: widthAndHeight,
                            height: widthAndHeight,
                          ),
                        ),
                        //front
                        Container(
                          color: Colors.green,
                          width: widthAndHeight,
                          height: widthAndHeight,
                        ),
                        //top
                        Transform(
                          alignment: Alignment.topCenter,
                          transform: Matrix4.identity()..rotateX(-pi / 2),
                          child: Container(
                            color: Colors.orange,
                            width: widthAndHeight,
                            height: widthAndHeight,
                          ),
                        ),
                        //bottom
                        Transform(
                          alignment: Alignment.bottomCenter,
                          transform: Matrix4.identity()..rotateX(pi / 2),
                          child: Container(
                            color: Colors.yellow,
                            width: widthAndHeight,
                            height: widthAndHeight,
                          ),
                        ),
                      ],
                    ),
                  );
                })
          ]),
        ),
      ),
    );
  }
}
