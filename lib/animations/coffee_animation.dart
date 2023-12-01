import 'dart:ui';

import 'package:flutter/material.dart';

class WindowsScrollBehaviour extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}

class CoffeeItem {
  final String id;
  final String name;
  final String image;
  final double price;

  CoffeeItem(
      {required this.id,
      required this.name,
      required this.image,
      required this.price});
}

class CoffeeAnimation extends StatefulWidget {
  const CoffeeAnimation({super.key});

  @override
  State<CoffeeAnimation> createState() => _CoffeeAnimationState();
}

class _CoffeeAnimationState extends State<CoffeeAnimation> {
  List<CoffeeItem> mockItems = [
    CoffeeItem(
        id: '0',
        name: 'Chocolate Excess Cake',
        image: 'chocolate_excess.png',
        price: 8.0),

    CoffeeItem(
        id: '2', name: 'Hazelnut Cake', image: 'hazelnut_cake.png', price: 6.0),

    CoffeeItem(
        id: '0',
        name: 'Blueberry Cake',
        image: 'blueberry_cake.png',
        price: 6.0),
    CoffeeItem(
        id: '0',
        name: 'Cappuccino Cake',
        image: 'cappuccino_cake.png',
        price: 8.0),
    CoffeeItem(
        id: '1', name: 'Fruit Cake', image: 'fruit_cake.png', price: 5.0),
    CoffeeItem(
        id: '0',
        name: 'Chocolate Cake',
        image: 'chocolate_cake.png',
        price: 10.0),
    CoffeeItem(
        id: '5',
        name: 'Red Velvet Cake',
        image: 'redvelvet_cake.png',
        price: 7.0),
    CoffeeItem(
        id: '3', name: 'Mongo Cake', image: 'mongo_cake.png', price: 3.0),
    CoffeeItem(
        id: '4', name: 'Praline Cake', image: 'praline_cake.png', price: 5.0),
    CoffeeItem(
        id: '0',
        name: 'Chocolate Excess Cake',
        image: 'chocolate_excess.png',
        price: 8.0),
    // CoffeeItem(
    //     id: '6',
    //     name: 'Cappuccino',
    //     description:
    //         'To make it properly requires much skill and attentiveness. Arguably the most important part is frothing the foam to velvety perfection as the milk steams - something our baristas take great care to achieve. The milky moustache that clings to your upper lip is proof we\'ve made yours right. And may we say, you wear it well.',
    //     image: 'GLASS-5.png',
    //     price: 7.0),
    // CoffeeItem(
    //     id: '7',
    //     name: 'Strawberries Frappuccino',
    //     description:
    //         'Inspired by the classic, country-style treat of strawberries and cream, we\'ve created a refreshing beverage that sweetens any summer activity.',
    //     image: 'GLASS-6.png',
    //     price: 8.0),
    // CoffeeItem(
    //     id: '8',
    //     name: 'Java Chip Frappuccino',
    //     description:
    //         'We created this wondrously decadent beverage for those who love the taste of chocolate - and lots of it -  with their iced coffee. Rich, chocolatey chips punctuate a cool, refreshing blend of coffee and mocha flavours.',
    //     image: 'GLASS-7.png',
    //     price: 2.0),
  ];

  late final PageController _coffeeController;
  late final PageController _headingController;
  late double _currentPosition;
  late int _currentHeading;

  void _navigationListener() {
    setState(() {
      _currentPosition = _coffeeController.page!;
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
    _coffeeController = PageController(viewportFraction: 0.4, initialPage: 8);
    _headingController = PageController(viewportFraction: 1, initialPage: 8);
    _currentPosition = _coffeeController.initialPage.toDouble();
    _currentHeading = _headingController.initialPage;
    _coffeeController.addListener(_navigationListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(children: [
          ..._buildBackground(),
          Transform.scale(
            alignment: Alignment.bottomCenter,
            scale: 2.1,
            child: PageView.builder(
                controller: _coffeeController,
                clipBehavior: Clip.none,
                itemCount: mockItems.length,
                scrollBehavior: WindowsScrollBehaviour(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return const SizedBox.shrink();
                  }
                  final double distance = (_currentPosition - index + 1).abs();
                  final isNotOnScreen = (_currentPosition - index + 1) > 0;
                  final double scale =
                      1 - distance * 0.345 * (isNotOnScreen ? 1 : -1);
                  final double translateY = (1 - scale).abs() *
                          MediaQuery.of(context).size.height /
                          1.5 +
                      20 * (distance - 1).clamp(0.0, 1);
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.1,
                    ),
                    child: Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..translate(0.0, !isNotOnScreen ? 0.0 : translateY)
                        ..scale(scale),
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        'assets/${mockItems[index].image}',
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  );
                }),
          ),
          Container(
            height: 180,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [.6, 1],
                    colors: [Colors.white, Colors.white.withOpacity(0.0)])),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 70,
                    child: PageView.builder(
                        controller: _headingController,
                        itemCount: mockItems.length,
                        scrollBehavior: WindowsScrollBehaviour(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          // final CoffeeItem item = mockItems[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 80),
                            child: Center(
                                child: Text(
                              index != 9 ? mockItems[index + 1].name : "",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                height: 1,
                                color: Color.fromARGB(255, 53, 37, 31),
                              ),
                            )),
                          );
                        }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      _currentHeading != 9
                          ? "\$${mockItems[_currentHeading + 1].price.toStringAsFixed(2)}"
                          : "",
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        height: 1,
                        color: Color.fromARGB(255, 53, 37, 31),
                      ),
                    ),
                  )
                ]),
          ),
          // ..._buildOverlays(),
        ]),
      ),
    );
  }

  // List<Widget> _buildOverlays() {
  //   return [
  //     Align(
  //       alignment: Alignment.bottomCenter,
  //       child: Container(
  //         height: 115,
  //         width: double.infinity,
  //         decoration: BoxDecoration(
  //           gradient: LinearGradient(
  //               begin: Alignment.bottomCenter,
  //               end: Alignment.topCenter,
  //               colors: [
  //                 Color.fromRGBO(rgb(233,189,234), g, b, opacity).withOpacity(.6),
  //                 Color.fromRGBO(rgb(233,189,234), g, b, opacity).withOpacity(0.0),
  //               ]),
  //         ),
  //       ),
  //     )
  //   ];
  // }

  List<Widget> _buildBackground() {
    return [
      Align(
        alignment: Alignment.bottomCenter + const Alignment(0, 0.7),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(233, 189, 234, 1),
              blurRadius: 90,
              spreadRadius: 90,
              offset: Offset.zero,
            )
          ], shape: BoxShape.circle),
        ),
      ),
      Align(
        alignment: Alignment.centerLeft + const Alignment(-0.35, -0.5),
        child: Container(
          width: 60,
          height: 200,
          decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(233, 189, 234, 1),
                  blurRadius: 50,
                  spreadRadius: 20,
                  offset: Offset(5, 0),
                )
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              )),
        ),
      ),
      Align(
        alignment: Alignment.centerLeft + const Alignment(5.8, -0.45),
        child: Container(
          width: 350,
          height: 350,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color.fromRGBO(233, 189, 234, 1).withOpacity(0.4),
                blurRadius: 60,
                spreadRadius: 20,
                offset: const Offset(5, 0),
              )
            ],
            shape: BoxShape.circle,
          ),
        ),
      ),
    ];
  }
}
