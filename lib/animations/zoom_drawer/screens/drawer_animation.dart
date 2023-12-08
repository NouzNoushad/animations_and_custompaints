import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/page_provider.dart';
import 'selected_screen.dart';
import 'main_screen.dart';
import 'menu_screen.dart';

class DrawerAnimation extends StatefulWidget {
  const DrawerAnimation({super.key});

  @override
  State<DrawerAnimation> createState() => _DrawerAnimationState();
}

class _DrawerAnimationState extends State<DrawerAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  late Animation<double> slideAnimation;
  late Animation<double> rotationAnimation;
  late Animation<double> borderAnimation;
  double drawerEnd = 220;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    scaleAnimation = Tween<double>(begin: 1, end: 0.8)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));
    rotationAnimation = Tween<double>(begin: 0, end: -0.15)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));
    slideAnimation = Tween<double>(begin: 0, end: drawerEnd)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));
    borderAnimation = Tween<double>(begin: 0, end: 30)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));
    super.initState();
  }

  buildScreens(int selectedIndex, AnimationController controller) {
    switch (selectedIndex) {
      case 0:
        return SelectedScreen(
          controller: controller,
          text: 'Home Screen',
        );
      case 1:
        return SelectedScreen(
          controller: controller,
          text: 'Favorite Screen',
        );
      case 2:
        return SelectedScreen(
          controller: controller,
          text: 'Settings Screen',
        );
      case 3:
        return SelectedScreen(
          controller: controller,
          text: 'Profile Screen',
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          MenuScreen(
            drawerEnd: drawerEnd,
          ),
          AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return Transform(
                  alignment: const Alignment(0, -0.1),
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..scale(scaleAnimation.value)
                    ..translate(slideAnimation.value)
                    ..rotateZ(rotationAnimation.value),
                  child: MainScreen(
                    borderRadius: borderAnimation.value,
                    child: Consumer<PageProvider>(
                        builder: (context, state, child) {
                      return Container(
                        color: Colors.white,
                        child: buildScreens(state.selectedIndex, controller),
                      );
                    }),
                  ),
                );
              }),
        ]),
      ),
    );
  }
}
