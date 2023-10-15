import 'dart:math';

import 'package:flutter/material.dart';

class BallRotate extends StatefulWidget {
  const BallRotate({super.key});

  @override
  State<BallRotate> createState() => _BallRotateState();
}

class _BallRotateState extends State<BallRotate>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 750));
    _scaleAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.6), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 6.0, end: 1.0), weight: 1),
    ]).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.linear));
    _rotateAnimation = Tween<double>(begin: 0.0, end: 2 * pi).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.linear));
    _animationController.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..scale(_scaleAnimation.value)
                  ..rotateZ(_rotateAnimation.value),
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      border: Border.all(width: 4, color: Colors.white),
                      color: Colors.pink,
                      shape: BoxShape.rectangle),
                ));
          }),
    );
  }
}
