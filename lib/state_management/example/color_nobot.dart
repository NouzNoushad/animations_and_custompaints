import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animations/state_management/nobot.dart';

class ColorNobot extends Nobot<Color> {
  ColorNobot() : super(const Color.fromARGB(255, 37, 37, 37));

  void changeColor() {
    emit(Colors.primaries[Random().nextInt(Colors.primaries.length)]);
  }
}
