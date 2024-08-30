import 'package:flutter/material.dart';
import 'package:flutter_animations/animations/water_animation.dart';
import 'package:flutter_animations/animations/water_animation2.dart';
import 'package:flutter_animations/animations/wave_animation.dart';
import 'package:flutter_animations/animations/wave_water_animation.dart';
import 'package:flutter_animations/state_management/example/color_nobot.dart';
import 'package:flutter_animations/state_management/example/counter_nobot.dart';

import 'animations/leaf_ui/leaf_screen.dart';
import 'state_management/nobot_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return NobotProvider<CounterNobot, int>(
        create: (_) => CounterNobot(),
        child: NobotProvider<ColorNobot, Color>(
          create: (_) => ColorNobot(),
          child: MaterialApp(
            theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)),
            debugShowCheckedModeBanner: false,
            home: WaveProgress(
              MediaQuery.of(context).size.height,
              Colors.white,
              Colors.blue,
              30,
            ),
          ),
        ));
  }
}
