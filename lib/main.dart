import 'dart:math';
import 'package:flutter/material.dart';
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
      home: const ThermometerDesign(),
    );
  }
}
