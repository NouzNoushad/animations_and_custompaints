import 'dart:math';

import 'package:flutter/material.dart';

class ExpansionAnimation extends StatefulWidget {
  const ExpansionAnimation({super.key});

  @override
  State<ExpansionAnimation> createState() => _ExpansionAnimationState();
}

class _ExpansionAnimationState extends State<ExpansionAnimation> {
  bool expand = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: SizedBox(
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              HeaderContainer(
                onTap: () {
                  setState(() {
                    expand = !expand;
                  });
                },
              ),
              ExpandedContainer(
                expand: expand,
                child: Container(
                  height: 100,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class ExpandedContainer extends StatefulWidget {
  const ExpandedContainer(
      {super.key, required this.child, required this.expand});
  final Widget child;
  final bool expand;

  @override
  State<ExpandedContainer> createState() => _ExpandedContainerState();
}

class _ExpandedContainerState extends State<ExpandedContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
    // checkExpansion();
    super.initState();
  }

  checkExpansion() {
    if (widget.expand) {
      controller.forward();
    } else {
      controller.reverse();
    }
  }

  @override
  void didUpdateWidget(covariant ExpandedContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    checkExpansion();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        // axisAlignment: 1.0,
        sizeFactor: animation,
        child: widget.child);
  }
}

class HeaderContainer extends StatelessWidget {
  final void Function()? onTap;
  const HeaderContainer({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.purple,
        height: 100,
      ),
    );
  }
}

// flip and lift animation
class FlipAndLiftAnimation extends StatefulWidget {
  const FlipAndLiftAnimation({Key? key}) : super(key: key);

  @override
  _FlipAndLiftAnimationState createState() => _FlipAndLiftAnimationState();
}

class _FlipAndLiftAnimationState extends State<FlipAndLiftAnimation>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  late Animation<double> animation;

  double boxSize = 100;
  double initialSize = 100;
  double expandedSize = 300;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    animation = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween(begin: 0.0, end: 2 * pi)
              .chain(CurveTween(curve: Curves.linear)),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(pi * 2),
          weight: 50.0,
        ),
      ],
    ).animate(animationController);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(164, 117, 81, 1),
        child: Center(
          child: GestureDetector(
            onTap: () async {
              animationController.isCompleted
                  ? animationController.reverse()
                  : animationController.forward();
              setState(() {
                boxSize = expandedSize;
              });
              await Future.delayed(const Duration(milliseconds: 500), () {
                setState(() {
                  boxSize = initialSize;
                });
              });
            },
            child: AnimatedBuilder(
              animation: animationController,
              child: AnimatedContainer(
                margin: const EdgeInsets.all(50),
                height: boxSize,
                width: boxSize,
                color: Colors.red,
                duration: const Duration(milliseconds: 300),
              ),
              builder: (context, child) {
                Matrix4 transform = Matrix4.identity();
                transform.setEntry(3, 2, 0.001);
                transform.rotateY(animation.value);
                transform.scale(1.0, 1.0, 10);
                return Transform(
                  transform: transform,
                  alignment: Alignment.center,
                  child: child,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
