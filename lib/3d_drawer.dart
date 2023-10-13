import 'dart:math';

import 'package:flutter/material.dart';

class ThreeDimensionDrawer extends StatefulWidget {
  const ThreeDimensionDrawer({super.key});

  @override
  State<ThreeDimensionDrawer> createState() => _ThreeDimensionDrawerState();
}

class _ThreeDimensionDrawerState extends State<ThreeDimensionDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      drawer: Material(
        child: Container(
          color: const Color(0xff24283b),
          child: ListView.builder(
              itemCount: 20,
              padding: const EdgeInsets.only(left: 80, top: 100),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Item $index'),
                );
              }),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Drawer'),
        ),
      ),
    );
  }
}

class Drawer extends StatefulWidget {
  final Widget child;
  final Widget drawer;
  const Drawer({super.key, required this.child, required this.drawer});

  @override
  State<Drawer> createState() => _DrawerState();
}

class _DrawerState extends State<Drawer> with TickerProviderStateMixin {
  late AnimationController _xController;
  late Animation<double> _yRotation;
  late AnimationController _xControllerForDrawer;
  late Animation<double> _yRotationForDrawer;

  @override
  void initState() {
    _xController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _yRotation = Tween<double>(begin: 0, end: -pi / 2).animate(_xController);
    _xControllerForDrawer = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _yRotationForDrawer =
        Tween<double>(begin: pi / 2.7, end: 0).animate(_xControllerForDrawer);
    super.initState();
  }

  @override
  void dispose() {
    _xController.dispose();
    _xControllerForDrawer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final maxDrag = screenWidth * 0.8;
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        _xController.value += details.delta.dx / maxDrag;
        _xControllerForDrawer.value += details.delta.dx / maxDrag;
      },
      onHorizontalDragEnd: (details) {
        if (_xController.value < 0.5) {
          _xController.reverse();
          _xControllerForDrawer.reverse();
        } else {
          _xController.forward();
          _xControllerForDrawer.forward();
        }
      },
      child: AnimatedBuilder(
          animation: Listenable.merge([_xController, _xControllerForDrawer]),
          builder: (context, child) {
            return Stack(
              children: [
                Container(
                  color: const Color(0xFF1a1b26),
                ),
                Transform(
                    alignment: Alignment.centerLeft,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..translate(_xController.value * maxDrag)
                      ..rotateY(_yRotation.value),
                    child: widget.child),
                Transform(
                    alignment: Alignment.centerRight,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..translate(
                          -screenWidth + _xControllerForDrawer.value * maxDrag)
                      ..rotateY(_yRotationForDrawer.value),
                    child: widget.drawer),
              ],
            );
          }),
    );
  }
}
