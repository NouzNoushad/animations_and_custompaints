import 'package:flutter/material.dart';

class AnimatedPrompt extends StatefulWidget {
  const AnimatedPrompt({super.key});

  @override
  State<AnimatedPrompt> createState() => _AnimatedPromptState();
}

class _AnimatedPromptState extends State<AnimatedPrompt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Icons'),
        centerTitle: true,
      ),
      body: const Center(
        child: AnimatedWidget(
            subTitle: 'Your order will be delivered in 2 days. Enjoy!',
            title: 'Thank you for your order!',
            child: Icon(Icons.check)),
      ),
    );
  }
}

class AnimatedWidget extends StatefulWidget {
  final String title;
  final String subTitle;
  final Widget child;
  const AnimatedWidget(
      {super.key,
      required this.child,
      required this.subTitle,
      required this.title});

  @override
  State<AnimatedWidget> createState() => _AnimatedWidgetState();
}

class _AnimatedWidgetState extends State<AnimatedWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _iconScaleAnimation;
  late Animation<double> _containerScaleAnimation;
  late Animation<Offset> _yAnimation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _yAnimation = Tween<Offset>(
            begin: const Offset(0, 0), end: const Offset(0, -0.23))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _iconScaleAnimation = Tween<double>(begin: 7, end: 6)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _containerScaleAnimation = Tween<double>(begin: 2.0, end: 0.4)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.bounceOut));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller
      ..reset()
      ..forward();
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              )
            ]),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 100,
            minHeight: 100,
            maxHeight: MediaQuery.of(context).size.height * 0.8,
            maxWidth: MediaQuery.of(context).size.width * 0.8,
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const SizedBox(
                    height: 160,
                  ),
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.subTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ]),
              ),
              Positioned.fill(
                  child: SlideTransition(
                position: _yAnimation,
                child: ScaleTransition(
                  scale: _containerScaleAnimation,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                    child: ScaleTransition(
                      scale: _iconScaleAnimation,
                      child: widget.child,
                    ),
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
