import 'dart:math';

import 'package:flutter/material.dart';

class FABAnimation extends StatefulWidget {
  const FABAnimation({super.key});

  @override
  State<FABAnimation> createState() => _FABAnimationState();
}

class _FABAnimationState extends State<FABAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> rotationAnimation;
  late Animation<double> translationAnimation;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    rotationAnimation = Tween<double>(begin: pi, end: 0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    translationAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: 120), weight: 75),
      TweenSequenceItem(tween: Tween<double>(begin: 120, end: 100), weight: 25),
    ]).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    animationController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          height: 150,
          width: 150,
          color: Colors.transparent,
          padding: const EdgeInsets.all(10),
          child: AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                return Stack(alignment: Alignment.bottomRight, children: [
                  Transform.translate(
                      offset: Offset.fromDirection(
                          -pi / 2, translationAnimation.value),
                      child: Transform(
                          alignment: Alignment.center,
                          transform:
                              Matrix4.rotationZ(translationAnimation.value),
                          child: customFab(Icons.home, Colors.teal, () {}))),
                  Transform.translate(
                      offset: Offset.fromDirection(
                          -(3 * pi) / 4, translationAnimation.value),
                      child: Transform(
                          alignment: Alignment.center,
                          transform:
                              Matrix4.rotationZ(translationAnimation.value),
                          child: customFab(
                              Icons.camera_alt, Colors.deepOrange, () {}))),
                  Transform.translate(
                      offset:
                          Offset.fromDirection(pi, translationAnimation.value),
                      child: Transform(
                          alignment: Alignment.center,
                          transform:
                              Matrix4.rotationZ(translationAnimation.value),
                          child: customFab(Icons.person, Colors.pink, () {}))),
                  Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationZ(rotationAnimation.value),
                      child: customFab(Icons.menu, Colors.purple, () {
                        if (animationController.isCompleted) {
                          animationController.reverse();
                        } else {
                          animationController.forward();
                        }
                      })),
                ]);
              }),
        ),
      ),
    );
  }

  Widget customFab(IconData icon, Color color, void Function()? onPressed) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: color,
      child: IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            color: Colors.white,
          )),
    );
  }
}
