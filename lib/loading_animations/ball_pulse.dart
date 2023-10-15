import 'package:flutter/material.dart';

class BallPulseAnimation extends StatefulWidget {
  const BallPulseAnimation({super.key});

  @override
  State<BallPulseAnimation> createState() => _BallPulseAnimationState();
}

class _BallPulseAnimationState extends State<BallPulseAnimation>
    with TickerProviderStateMixin {
  final List<AnimationController> _animationControllers = [];
  final List<Animation<double>> _scaleAnimations = [];
  final List<Animation<double>> _opacityAnimations = [];
  static const _delayInMills = [120, 240, 360, 480, 120, 240, 360, 480, 120];
  static const _durationInMills = 750;

  @override
  void initState() {
    for (int i = 0; i < 9; i++) {
      _animationControllers.add(AnimationController(
          vsync: this,
          value: _delayInMills[i] / _durationInMills,
          duration: const Duration(milliseconds: _durationInMills)));
      _scaleAnimations.add(TweenSequence([
        TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.5), weight: 1),
        TweenSequenceItem(tween: Tween(begin: 0.5, end: 1.0), weight: 1),
      ]).animate(CurvedAnimation(
          parent: _animationControllers[i], curve: Curves.easeIn)));
      _opacityAnimations.add(TweenSequence([
        TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.7), weight: 1),
        TweenSequenceItem(tween: Tween(begin: 0.7, end: 1.0), weight: 1),
      ]).animate(CurvedAnimation(
          parent: _animationControllers[i], curve: Curves.easeIn)));
      _animationControllers[i].repeat();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final widgets = List<Widget>.filled(9, Container());
    for (int i = 0; i < 9; i++) {
      widgets[i] = FadeTransition(
        opacity: _opacityAnimations[i],
        child: ScaleTransition(
          scale: _scaleAnimations[i],
          child: Container(
            color: Colors.purple,
          ),
        ),
      );
    }
    return Center(
      child: GridView.count(
          mainAxisSpacing: 2,
          crossAxisCount: 3,
          crossAxisSpacing: 2,
          children: widgets),
    );
  }
}
