import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animations/animated_prompt.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const AnimatedPrompt(),
    );
  }
}

enum CircleSide { right, left }

extension ToPath on CircleSide {
  Path toPath(Size size) {
    final path = Path();

    late Offset offset;
    late bool clockwise;

    switch (this) {
      case CircleSide.left:
        path.moveTo(size.width, 0);
        offset = Offset(size.width, size.height);
        clockwise = false;
        break;
      case CircleSide.right:
        offset = Offset(0, size.height);
        clockwise = true;
        break;
    }
    path.arcToPoint(offset,
        radius: Radius.elliptical(size.width / 2, size.height / 2),
        clockwise: clockwise);
    path.close();
    return path;
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween<double>(begin: 0, end: -pi / 2)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.bounceOut));
    _flipController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _flipAnimation = Tween<double>(begin: 0, end: pi).animate(
        CurvedAnimation(parent: _flipController, curve: Curves.bounceOut));
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _flipAnimation = Tween<double>(
                begin: _flipAnimation.value, end: _flipAnimation.value + pi)
            .animate(CurvedAnimation(
                parent: _flipController, curve: Curves.bounceOut));
        _flipController
          ..reset()
          ..forward();
      }
    });
    _flipController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animation = Tween<double>(
                begin: _animation.value, end: _animation.value + -(pi / 2))
            .animate(
                CurvedAnimation(parent: _controller, curve: Curves.bounceOut));
        _controller
          ..reset()
          ..forward();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      _controller
        ..reset()
        ..forward();
    });

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..rotateZ(
                      _animation.value,
                    ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedBuilder(
                          animation: _flipAnimation,
                          builder: (context, child) {
                            return Transform(
                              alignment: Alignment.centerRight,
                              transform: Matrix4.identity()
                                ..rotateY(
                                  _flipAnimation.value,
                                ),
                              child: ClipPath(
                                clipper:
                                    HalfCircleClipper(side: CircleSide.left),
                                child: Container(
                                  height: 150,
                                  width: 150,
                                  color: Colors.indigo,
                                ),
                              ),
                            );
                          }),
                      AnimatedBuilder(
                          animation: _flipAnimation,
                          builder: (context, child) {
                            return Transform(
                              alignment: Alignment.centerLeft,
                              transform: Matrix4.identity()
                                ..rotateY(
                                  _flipAnimation.value,
                                ),
                              child: ClipPath(
                                clipper:
                                    HalfCircleClipper(side: CircleSide.right),
                                child: Container(
                                  height: 150,
                                  width: 150,
                                  color: Colors.amber,
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}

class HalfCircleClipper extends CustomClipper<Path> {
  final CircleSide side;

  HalfCircleClipper({required this.side});
  @override
  Path getClip(Size size) => side.toPath(size);

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
