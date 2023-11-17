import 'package:flutter/material.dart';
import 'package:flutter_animations/coffee_animation.dart';

class TreatItem {
  final String id;
  final String name;
  final String description;
  final String colories;
  final String image;
  final double price;

  TreatItem(
      {required this.id,
      required this.name,
      required this.colories,
      required this.description,
      required this.image,
      required this.price});
}

class TreatAnimation extends StatefulWidget {
  const TreatAnimation({super.key});

  @override
  State<TreatAnimation> createState() => _TreatAnimationState();
}

class _TreatAnimationState extends State<TreatAnimation> {
  static List<TreatItem> mockItems = [
    TreatItem(
        id: '1',
        name: 'New York Cheesecake',
        description:
            'One of the creamiest cheesecakes you\'ll ever taste with a crumbly biscuit base.',
        image: 'assets/TREAT_0.png',
        colories: '2195 kJ',
        price: 6.34),
    TreatItem(
        id: '2',
        name: 'Strawberry Jam Filled Donut',
        description:
            'A traditional soft and tasy donut, iced with strawberry glaze and filled with strawberry jam. ',
        image: 'assets/TREAT_1.png',
        colories: '1292 kJ',
        price: 4.23),
    TreatItem(
        id: '3',
        name: 'Chocolate Jam Filled Donut',
        description:
            'A traditional soft and tasy donut, iced with chocolate glaze and filled with strawberry jam.',
        image: 'assets/TREAT_2.png',
        colories: '1207 kJ',
        price: 3.23),
    TreatItem(
        id: '4',
        name: 'Galaxy Donut',
        description:
            'A traditional soft and delicious donut iced with either pink or blue galaxy style glaze.',
        image: 'assets/TREAT_3.png',
        colories: '1252 kJ',
        price: 5.38),
    TreatItem(
        id: '5',
        name: 'Chocolate Raspberry Mudcake',
        description:
            'A dense and decadently rich flourless chocolate cake made completely from plant-based ingredients',
        image: 'assets/TREAT_4.png',
        colories: '2916 kJ',
        price: 6.69),
    TreatItem(
        id: '6',
        name: 'Donut Cookie',
        description:
            'Colourful shortbread cookies in fun, novelty shapes of donuts.',
        image: 'assets/TREAT_5.png',
        colories: '705 kJ',
        price: 3.13),
    TreatItem(
      id: '7',
      name: 'Chocolate Chip Cookie',
      description:
          'Baked to perfection by one of Melbourne’s best small-batch bakehouses with generous chunks of milk chocolate. So soft, so chewy, so snackable!',
      image: 'assets/TREAT_6.png',
      colories: '978 kJ',
      price: 5.13,
    ),
  ];

  late final PageController _treatsController;
  late final PageController _headingController;

  late double _currentPosition;
  late int _currentHeading;

  void _navigationListener() {
    setState(() {
      _currentPosition = _treatsController.page!;
      if (_currentPosition.round() != _currentHeading) {
        _currentHeading = _currentPosition.round();
        _headingController.animateToPage(_currentHeading,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut);
      }
    });
  }

  @override
  void initState() {
    _treatsController = PageController(viewportFraction: 0.4, initialPage: 2);
    _headingController = PageController(viewportFraction: 1, initialPage: 2);
    _currentPosition = _treatsController.initialPage.toDouble();
    _currentHeading = _headingController.initialPage;
    _treatsController.addListener(_navigationListener);
    super.initState();
  }

  @override
  void dispose() {
    _treatsController.removeListener(_navigationListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: SizedBox(
              height: 80,
              child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _headingController,
                  itemCount: mockItems.length,
                  scrollBehavior: WindowsScrollBehaviour(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        index != 6 ? mockItems[index + 1].name : "",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          height: 1,
                          color: Colors.black,
                        ),
                      ),
                    );
                  }),
            ),
          ),
          Transform.scale(
            alignment: Alignment.bottomCenter,
            scale: 2,
            child: PageView.builder(
                controller: _treatsController,
                scrollDirection: Axis.vertical,
                scrollBehavior: WindowsScrollBehaviour(),
                itemCount: mockItems.length,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return const SizedBox.shrink();
                  }
                  final double distance = (_currentPosition - index + 1).abs();
                  final isNotOnScreen = (_currentPosition - index + 1) > 0;
                  final double scale = 1 - distance * 0.38;
                  final double translateY = (1 - scale).abs() *
                          MediaQuery.of(context).size.height /
                          1.5 +
                      25 * (distance - 1).clamp(0.0, 1);
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.1),
                    child: Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..translate(0.0, !isNotOnScreen ? 0 : translateY)
                        ..scale(scale),
                      alignment: Alignment.bottomRight,
                      child: Hero(
                        tag: 'treat_${mockItems[index].id}',
                        child: Image.asset(
                          mockItems[index].image,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
