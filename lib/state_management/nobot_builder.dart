import 'package:flutter/material.dart';
import 'package:flutter_animations/state_management/inherited_nobot.dart';

import 'nobot.dart';

class NobotBuilder<TNobot extends Nobot<T>, T> extends StatefulWidget {
  const NobotBuilder({super.key, required this.builder});
  final Widget Function(BuildContext context, T state) builder;

  @override
  State<StatefulWidget> createState() => _NobotBuilderState<TNobot, T>();
}

class _NobotBuilderState<TNobot extends Nobot<T>, T>
    extends State<NobotBuilder<TNobot, T>> {
  @override
  Widget build(BuildContext context) {
    var nobotState = InheritedNobot.of<TNobot, T>(context);
    return ValueListenableBuilder<T>(
        valueListenable: nobotState,
        builder: (context, state, _) => widget.builder(context, state));
  }
}
