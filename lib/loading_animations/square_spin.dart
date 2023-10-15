import 'dart:math';

import 'package:flutter/material.dart';

class SquareSpin extends StatefulWidget {
  const SquareSpin({super.key});

  @override
  State<SquareSpin> createState() => _SquareSpinState();
}

class _SquareSpinState extends State<SquareSpin>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _x1Animation;
  late Animation<double> _y1Animation;
  late Animation<double> _x2Animation;
  late Animation<double> _y2Animation;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));
    _x1Animation = Tween<double>(begin: 0, end: pi).animate(CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0, 0.25, curve: Curves.easeIn)));
    _y1Animation = Tween<double>(begin: 0, end: pi).animate(CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.25, 0.5, curve: Curves.easeIn)));
    _x2Animation = Tween<double>(begin: pi, end: 0).animate(CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 0.75, curve: Curves.easeIn)));
    _y2Animation = Tween<double>(begin: pi, end: 2 * pi).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.75, 1, curve: Curves.easeIn)));
    _animationController.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          late double x, y;
          if (_animationController.value < 0.5) {
            x = _x1Animation.value;
            y = _y1Animation.value;
          } else if (_animationController.value < 1) {
            x = _x2Animation.value;
            y = _y2Animation.value;
          }
          return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.006)
                ..rotateX(x)
                ..rotateY(y),
              child: Center(
                child: Container(
                  height: 100,
                  width: 100,
                  color: Colors.purple,
                ),
              ));
        });
  }
}
