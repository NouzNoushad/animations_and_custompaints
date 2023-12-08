import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen(
      {super.key, required this.child, required this.borderRadius});
  final Widget child;
  final double borderRadius;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: widget.child);
  }
}
