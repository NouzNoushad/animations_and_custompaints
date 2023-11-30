import 'dart:math';

import 'package:flutter/material.dart';

class TrashAnimation extends StatefulWidget {
  const TrashAnimation({super.key});

  @override
  State<TrashAnimation> createState() => _TrashAnimationState();
}

class _TrashAnimationState extends State<TrashAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  late Animation<double> micTranslateTop;
  late Animation<double> micTranslateBottom;
  late Animation<double> micTranslateLeft;
  late Animation<double> micTranslateRight;
  late Animation<double> micFirstRotation;
  late Animation<double> micSecondRotation;
  late Animation<double> micInsideTrashTranslate;

  late Animation<double> trashAlongCoverTranslateTop;
  late Animation<double> trashAlongCoverTranslateBottom;
  late Animation<double> trashCoverTranslateLeft;
  late Animation<double> trashCoverTranslateRight;
  late Animation<double> trashCoverFirstRotation;
  late Animation<double> trashCoverSecondRotation;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2500));

    micTranslateTop = Tween(begin: 0.0, end: -150.0).animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOut)));
    micTranslateBottom = Tween(begin: 0.0, end: 150.0).animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.45, 0.79, curve: Curves.easeInOut)));
    micTranslateLeft = Tween(begin: 0.0, end: -13.0).animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.1, 0.2, curve: Curves.easeOut)));
    micTranslateRight = Tween(begin: 0.0, end: 13.0).animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.1, curve: Curves.easeOut)));
    micFirstRotation = Tween(begin: 0.0, end: pi).animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.2, curve: Curves.easeOut)));
    micSecondRotation = Tween(begin: 0.0, end: pi).animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.2, 0.45, curve: Curves.easeOut)));
    micInsideTrashTranslate = Tween(begin: 0.0, end: 55.0).animate(
        CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.95, 1.0, curve: Curves.easeInOut)));
    // trash
    trashAlongCoverTranslateTop = Tween(begin: 30.0, end: -25.0).animate(
        CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.45, 0.6, curve: Curves.easeInOut)));
    trashAlongCoverTranslateBottom = Tween(begin: 0.0, end: 55.0).animate(
        CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.95, 1.0, curve: Curves.easeInOut)));
    trashCoverTranslateLeft = Tween(begin: 0.0, end: -18.0).animate(
        CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.6, 0.7, curve: Curves.easeInOut)));
    trashCoverTranslateRight = Tween(begin: 0.0, end: 18.0).animate(
        CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.8, 0.9, curve: Curves.easeInOut)));
    trashCoverFirstRotation = Tween(begin: 0.0, end: -pi / 3).animate(
        CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.6, 0.7, curve: Curves.easeInOut)));
    trashCoverSecondRotation = Tween(begin: 0.0, end: pi / 3).animate(
        CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.8, 0.9, curve: Curves.easeInOut)));
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AnimatedBuilder(
                          animation: animationController,
                          builder: (context, child) {
                            return Transform(
                              transform: Matrix4.identity()
                                ..translate(0.0, 10)
                                ..translate(micTranslateRight.value)
                                ..translate(micTranslateLeft.value)
                                ..translate(0.0, micTranslateTop.value)
                                ..translate(0.0, micTranslateBottom.value)
                                ..translate(0.0, micInsideTrashTranslate.value),
                              child: Transform.rotate(
                                angle: micFirstRotation.value,
                                child: Transform.rotate(
                                  angle: micSecondRotation.value,
                                  child: const Icon(
                                    Icons.mic,
                                    size: 20,
                                  ),
                                ),
                              ),
                            );
                          }),
                      Row(
                        children: [
                          TextButton(
                              onPressed: () {
                                animationController.forward();
                              },
                              child: const Text('Play')),
                          TextButton(
                              onPressed: () {
                                animationController.reset();
                              },
                              child: const Text('Reset')),
                        ],
                      ),
                    ],
                  ),
                  AnimatedBuilder(
                      animation: animationController,
                      builder: (context, child) {
                        return Transform(
                          transform: Matrix4.identity()
                            ..translate(0.0, trashAlongCoverTranslateTop.value)
                            ..translate(
                                0.0, trashAlongCoverTranslateBottom.value),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AnimatedBuilder(
                                  animation: animationController,
                                  builder: (context, child) {
                                    return Transform(
                                      transform: Matrix4.identity()
                                        ..translate(
                                            trashCoverTranslateLeft.value)
                                        ..translate(
                                            trashCoverTranslateRight.value),
                                      child: Transform.rotate(
                                        angle: trashCoverSecondRotation.value,
                                        child: Transform.rotate(
                                          angle: trashCoverFirstRotation.value,
                                          child: Image.asset(
                                            'assets/trash_cover.png',
                                            width: 30,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                              Padding(
                                padding: const EdgeInsets.only(top: 1.5),
                                child: Image.asset(
                                  'assets/trash_container.png',
                                  width: 30,
                                ),
                              )
                            ],
                          ),
                        );
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
