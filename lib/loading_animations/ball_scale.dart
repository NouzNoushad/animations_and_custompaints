import 'package:flutter/material.dart';

class BallScale extends StatefulWidget {
  const BallScale({super.key});

  @override
  State<BallScale> createState() => _BallScaleState();
}

class _BallScaleState extends State<BallScale>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _scaleAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    _opacityAnimation = ReverseAnimation(_scaleAnimation);
    _animationController.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        opacity: _opacityAnimation,
        child: ScaleTransition(
            scale: _scaleAnimation,
            child: const CircleAvatar(
              backgroundColor: Colors.amber,
            )));
  }
}
