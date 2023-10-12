import 'package:flutter/material.dart';

class ImplicitAnimations extends StatefulWidget {
  const ImplicitAnimations({super.key});

  @override
  State<ImplicitAnimations> createState() => _ImplicitAnimationsState();
}

const defaultWidth = 100.0;

class _ImplicitAnimationsState extends State<ImplicitAnimations> {
  bool _isZoomedIn = false;
  String _buttonTitle = "Zoom INN";
  double _width = defaultWidth;
  var _curve = Curves.bounceOut;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 370),
            width: _width,
            curve: _curve,
            child: Image.asset(
              'assets/leaf.jpg',
            ),
          ),
          TextButton(
              onPressed: () {
                setState(() {
                  _isZoomedIn = !_isZoomedIn;
                  _buttonTitle = _isZoomedIn ? "Zoom OUT" : "Zoom INN";
                  _width = _isZoomedIn
                      ? MediaQuery.of(context).size.width
                      : defaultWidth;
                  _curve = _isZoomedIn ? Curves.bounceInOut : Curves.bounceOut;
                });
              },
              child: Text(_buttonTitle))
        ]),
      ),
    );
  }
}
