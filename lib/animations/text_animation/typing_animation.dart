import 'package:flutter/material.dart';

class TypingAnimation extends StatefulWidget {
  const TypingAnimation({super.key});

  @override
  State<TypingAnimation> createState() => _TypingAnimationState();
}

class _TypingAnimationState extends State<TypingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  Animation<int>? characterCount;
  String text =
      'Developed a comprehensive mobile learning application designed to provide users with a seamless educational experience. The app features a robust video player and an innovative offline download capability, allowing users to access course content even without an internet connection.';

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 7));
    characterCount = StepTween(begin: 0, end: text.length)
        .animate(CurvedAnimation(parent: controller, curve: Curves.linear));
    controller.addListener(() {
      setState(() {});
    });
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (controller.isCompleted) {
            controller.reset();
          }
          controller.forward();
        },
        child: const Icon(Icons.navigate_next),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            String newText = text.substring(0, characterCount?.value);
            return Center(
              child: Text(
                newText,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            );
          },
        ),
      ),
    );
  }
}
