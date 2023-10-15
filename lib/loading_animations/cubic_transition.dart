import 'dart:math';

import 'package:flutter/material.dart';

class CubicTransition extends StatefulWidget {
  const CubicTransition({super.key});

  @override
  State<CubicTransition> createState() => _CubicTransitionState();
}

class _CubicTransitionState extends State<CubicTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Size?> _translateAnimation;
  late Animation<double> _rotateAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1600));
    _translateAnimation = TweenSequence([
      TweenSequenceItem(
          tween:
              SizeTween(begin: const Size(0.0, 0.0), end: const Size(1.0, 0.0)),
          weight: 1),
      TweenSequenceItem(
          tween:
              SizeTween(begin: const Size(1.0, 0.0), end: const Size(1.0, 1.0)),
          weight: 1),
      TweenSequenceItem(
          tween:
              SizeTween(begin: const Size(1.0, 1.0), end: const Size(0.0, 1.0)),
          weight: 1),
      TweenSequenceItem(
          tween:
              SizeTween(begin: const Size(0.0, 1.0), end: const Size(0.0, 0.0)),
          weight: 1),
    ]).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.linear));
    _rotateAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -pi / 2), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -pi / 2, end: -pi), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -pi, end: -pi * 1.5), weight: 1),
      TweenSequenceItem(
          tween: Tween(begin: -pi * 1.5, end: -pi * 2), weight: 1),
    ]).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    _scaleAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.5), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 0.5, end: 1.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.5), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 0.5, end: 1.0), weight: 1),
    ]).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    _animationController.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      final squareSize = constraint.maxWidth / 5;
      final deltaX = constraint.maxWidth - squareSize;
      final deltaY = constraint.maxHeight - squareSize;

      return SafeArea(
        child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Stack(
                children: [
                  Positioned.fromRect(
                      rect: Rect.fromLTWH(0, 0, squareSize, squareSize),
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..translate(_translateAnimation.value!.width * deltaX,
                              _translateAnimation.value!.height * deltaY)
                          ..rotateZ(_rotateAnimation.value)
                          ..scale(_scaleAnimation.value),
                        child: Container(
                          height: 100,
                          width: 100,
                          color: Colors.red,
                        ),
                      )),
                  Positioned.fromRect(
                      rect: Rect.fromLTWH(
                          constraint.maxWidth - squareSize,
                          constraint.maxHeight - squareSize,
                          squareSize,
                          squareSize),
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..translate(
                              -_translateAnimation.value!.width * deltaX,
                              -_translateAnimation.value!.height * deltaY)
                          ..rotateZ(_rotateAnimation.value)
                          ..scale(_scaleAnimation.value),
                        child: Container(
                          height: 100,
                          width: 100,
                          color: Colors.orange,
                        ),
                      )),
                ],
              );
            }),
      );
    });
  }
}
