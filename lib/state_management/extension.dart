import 'package:flutter/material.dart';

import 'inherited_nobot.dart';
import 'nobot.dart';

extension BuildContextExt on BuildContext {
  TNobot of<TNobot extends Nobot<T>, T>() {
    return dependOnInheritedWidgetOfExactType<InheritedNobot<TNobot, T>>()!
        .notifier!;
  }
}
