import 'package:flutter/material.dart';
import 'package:flutter_animations/animations/brick_animation.dart';
import 'package:flutter_animations/animations/leaf_ui/leaf_details.dart';
import 'package:flutter_animations/animations/round_slider.dart';
import 'package:flutter_animations/animations/switch_lock.dart';
import 'package:flutter_animations/animations/text_animation/typing_animation.dart';
import 'package:flutter_animations/animations/text_animation/wave_animation.dart';
import 'package:flutter_animations/clippers/tickets.dart';
import 'package:flutter_animations/custom_paint/cat.dart';
import 'package:flutter_animations/custom_paint/chameleon.dart';
import 'package:flutter_animations/custom_paint/dash_design.dart';
import 'package:flutter_animations/custom_paint/frog_head.dart';
import 'package:flutter_animations/custom_paint/phone_pattern.dart';
import 'package:flutter_animations/custom_paint/pikachu.dart';
import 'package:flutter_animations/loading_animations/spin_loading.dart';
import 'package:flutter_animations/onboarding/onboarding.dart';
import 'package:flutter_animations/state_management/example/color_nobot.dart';
import 'package:flutter_animations/state_management/example/counter_nobot.dart';
import 'package:flutter_animations/state_management/example/counter_view.dart';
import 'package:flutter_animations/state_management/nobot_provider.dart';
import 'package:provider/provider.dart';

import 'animations/leaf_ui/leaf_screen.dart';
import 'animations/zoom_drawer/provider/page_provider.dart';
import 'animations/zoom_drawer/screens/drawer_animation.dart';

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
            home: const LeafScreen(),
          ),
        ));
  }
}
