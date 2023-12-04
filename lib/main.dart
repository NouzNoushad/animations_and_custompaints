import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animations/animations/ball_animation.dart';
import 'package:flutter_animations/animations/bird_clock.dart';
import 'package:flutter_animations/animations/bird_clock_pendulum.dart';
import 'package:flutter_animations/animations/fab_animation.dart';
import 'package:flutter_animations/custom_paint/apple.dart';
import 'package:flutter_animations/custom_paint/clock_design.dart';
import 'package:flutter_animations/custom_paint/custom_clock.dart';
import 'package:flutter_animations/custom_paint/custom_slider.dart';
import 'package:flutter_animations/custom_paint/thermometer.dart';
import 'package:flutter_animations/render_object/speedometer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:
          ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)),
      debugShowCheckedModeBanner: false,
      home: const FABAnimation(),
    );
  }
}
