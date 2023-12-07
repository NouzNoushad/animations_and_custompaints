import 'dart:math';

import 'package:flutter/material.dart';

class FoldingAnimation extends StatefulWidget {
  const FoldingAnimation({super.key});

  @override
  State<FoldingAnimation> createState() => _FoldingAnimationState();
}

class _FoldingAnimationState extends State<FoldingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> rotation1Animation;
  late Animation<double> rotation2Animation;
  late Animation<double> rotation3Animation;
  late Animation<double> rotation4Animation;
  bool hide = false;
  Color frontColor = Colors.teal;
  Color backColor = Colors.teal.shade800;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    rotation1Animation = Tween<double>(begin: 0, end: -pi / 2).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.0, 0.25, curve: Curves.linear)));
    rotation2Animation = Tween<double>(begin: -pi / 2, end: -pi).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.25, 0.5, curve: Curves.linear)));
    rotation3Animation = Tween<double>(begin: 0, end: -pi / 2).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.5, 0.75, curve: Curves.linear)));
    rotation4Animation = Tween<double>(begin: -pi / 2, end: -pi).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.75, 1.0, curve: Curves.linear)));
    controller.addListener(() {
      if (controller.value >= 0.5) {
        setState(() {
          hide = true;
        });
      } else {
        setState(() {
          hide = false;
        });
      }
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
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 300,
            child: AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  return GestureDetector(
                    onTap: () {
                      if (controller.isCompleted) {
                        controller.reverse();
                      } else {
                        controller.forward();
                      }
                    },
                    child: Column(children: [
                      Container(
                        height: 200,
                        color: frontColor,
                      ),
                      Stack(
                        children: [
                          Transform(
                            alignment: Alignment.topCenter,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..rotateX(rotation4Animation.value),
                            child: Container(
                              height: 200,
                              width: double.infinity,
                              color: backColor,
                            ),
                          ),
                          Transform(
                            alignment: Alignment.topCenter,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..rotateX(rotation3Animation.value),
                            child: hide
                                ? Container(
                                    height: 200,
                                    width: double.infinity,
                                    color: backColor)
                                : Container(
                                    height: 200,
                                    width: double.infinity,
                                    color: frontColor),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Transform(
                            alignment: Alignment.topCenter,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..rotateX(rotation2Animation.value),
                            child: hide
                                ? const SizedBox()
                                : Container(
                                    height: 200,
                                    width: double.infinity,
                                    color: backColor),
                          ),
                          Transform(
                            alignment: Alignment.topCenter,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..rotateX(rotation1Animation.value),
                            child: Container(
                                height: 200,
                                width: double.infinity,
                                color: frontColor),
                          ),
                        ],
                      ),
                    ]),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
