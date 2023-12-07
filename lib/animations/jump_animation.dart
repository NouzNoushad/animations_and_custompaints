import 'dart:math';

import 'package:flutter/material.dart';

class JumpAnimation extends StatefulWidget {
  const JumpAnimation({super.key});

  @override
  State<JumpAnimation> createState() => _JumpAnimationState();
}

class _JumpAnimationState extends State<JumpAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> jumpAnimation;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    jumpAnimation = Tween<double>(begin: 0, end: pi)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.bottomCenter,
        child: AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationZ(jumpAnimation.value),
                child: Container(
                  height: 60,
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  width: 300,
                  alignment: Alignment.centerLeft,
                  color: Colors.transparent,
                  child: GestureDetector(
                    onTap: () {
                      if (controller.isCompleted) {
                        controller.reverse();
                      } else {
                        controller.forward();
                      }
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
