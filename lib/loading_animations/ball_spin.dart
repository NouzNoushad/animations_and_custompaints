import 'package:flutter/material.dart';

class BallSpin extends StatefulWidget {
  const BallSpin({super.key});

  @override
  State<BallSpin> createState() => _BallSpinState();
}

class _BallSpinState extends State<BallSpin>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _scaleAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.6), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 0.6, end: 1.0), weight: 1),
    ]).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.linear));
    _rotateAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.linear));
    _animationController.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
        turns: _rotateAnimation,
        child: ScaleTransition(
            scale: _scaleAnimation,
            child: Row(
              children: [
                Expanded(child: _buildSingleCircle(0.8, 0)),
                Expanded(child: _buildSingleCircle(1.0, 1)),
                Expanded(child: _buildSingleCircle(0.8, 2)),
              ],
            )));
  }

  _buildSingleCircle(double opacity, int index) {
    return Opacity(
      opacity: opacity,
      child: const CircleAvatar(
        backgroundColor: Colors.amber,
      ),
    );
  }
}
