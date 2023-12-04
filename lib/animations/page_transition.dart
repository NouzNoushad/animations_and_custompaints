import 'package:flutter/material.dart';

class PageTransition extends StatefulWidget {
  const PageTransition({super.key});

  @override
  State<PageTransition> createState() => _PageTransitionState();
}

class _PageTransitionState extends State<PageTransition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () {
                  Navigator.push(
                      context,
                      CustomPageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: const SecondPageScreen(),
                      ));
                },
                child: const Text(
                  'Right to Left',
                  style: TextStyle(
                    color: Colors.purple,
                  ),
                )),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () {
                  Navigator.push(
                      context,
                      CustomPageTransition(
                        type: PageTransitionType.leftToRight,
                        child: const SecondPageScreen(),
                      ));
                },
                child: const Text(
                  'Left to Right',
                  style: TextStyle(
                    color: Colors.purple,
                  ),
                )),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () {
                  Navigator.push(
                      context,
                      CustomPageTransition(
                        type: PageTransitionType.topToBottom,
                        child: const SecondPageScreen(),
                      ));
                },
                child: const Text(
                  'Top to Bottom',
                  style: TextStyle(
                    color: Colors.purple,
                  ),
                )),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () {
                  Navigator.push(
                      context,
                      CustomPageTransition(
                        type: PageTransitionType.bottomToTop,
                        child: const SecondPageScreen(),
                      ));
                },
                child: const Text(
                  'Bottom to Top',
                  style: TextStyle(
                    color: Colors.purple,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

enum PageTransitionType { rightToLeft, leftToRight, topToBottom, bottomToTop }

class CustomPageTransition extends PageRouteBuilder {
  final Widget child;
  final PageTransitionType type;
  CustomPageTransition({
    required this.child,
    required this.type,
  }) : super(pageBuilder: (context, animation, secondaryAnimation) {
          return child;
        });

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    switch (type) {
      case PageTransitionType.rightToLeft:
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
              .animate(animation),
          child: child,
        );
      case PageTransitionType.leftToRight:
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
              .animate(animation),
          child: child,
        );
      case PageTransitionType.topToBottom:
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
              .animate(animation),
          child: child,
        );
      case PageTransitionType.bottomToTop:
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
              .animate(animation),
          child: child,
        );
    }
  }
}

class SecondPageScreen extends StatelessWidget {
  const SecondPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.pink,
      ),
      body: const Center(
          child: Text(
        'Second Page',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      )),
    );
  }
}
