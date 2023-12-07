import 'package:flutter/material.dart';

class DelayedAnimation extends StatefulWidget {
  const DelayedAnimation({super.key});

  @override
  State<DelayedAnimation> createState() => _DelayedAnimationState();
}

class _DelayedAnimationState extends State<DelayedAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> slideAnimation;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    slideAnimation = Tween<double>(begin: 20, end: 0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.decelerate));
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
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (controller.isCompleted) {
              controller.reverse();
            } else {
              controller.forward();
            }
          },
          label: const Text('Start')),
      body: Center(
        child: AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return FadeTransition(
                opacity:
                    Tween<double>(begin: 0.0, end: 1.0).animate(controller),
                child: Transform(
                  transform:
                      Matrix4.translationValues(0, slideAnimation.value, 0),
                  child: Container(
                    height: 200,
                    width: 200,
                    color: Colors.purple,
                  ),
                ),
              );
            }),
      ),
    );
  }
}
