import 'package:flutter/material.dart';
import 'package:flutter_animations/state_management/nobot.dart';

class InheritedNobot<TNobot extends Nobot<T>, T>
    extends InheritedNotifier<TNobot> {
  const InheritedNobot({
    required Widget child,
    required TNobot nobotNotifier,
    Key? key,
  }) : super(key: key, child: child, notifier: nobotNotifier);

  static TNobot of<TNobot extends Nobot<T>, T>(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<InheritedNobot<TNobot, T>>()!
        .notifier!;
  }
}
