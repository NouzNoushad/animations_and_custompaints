import 'package:flutter/material.dart';
import 'package:flutter_animations/state_management/inherited_nobot.dart';
import 'package:flutter_animations/state_management/nobot.dart';

class NobotProvider<TNobot extends Nobot<T>, T> extends StatefulWidget {
  const NobotProvider({super.key, required this.child, required this.create});
  final Widget child;
  final TNobot Function(BuildContext context) create;

  @override
  State<StatefulWidget> createState() => _NobotProviderState<TNobot, T>();
}

class _NobotProviderState<TNobot extends Nobot<T>, T>
    extends State<NobotProvider<TNobot, T>> {
  @override
  Widget build(BuildContext context) {
    return InheritedNobot<TNobot, T>(
        nobotNotifier: widget.create(context), child: widget.child);
  }
}
