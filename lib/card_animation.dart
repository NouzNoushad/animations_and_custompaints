import 'package:flutter/material.dart';

class CreditCardPicker extends StatefulWidget {
  const CreditCardPicker({super.key});

  @override
  State<CreditCardPicker> createState() => _CreditCardPickerState();
}

class _CreditCardPickerState extends State<CreditCardPicker> {
  List<List<Color>> colors = [
    [Colors.red, Colors.red.shade800],
    [Colors.purple, Colors.purple.shade800],
    [Colors.blue, Colors.blue.shade800],
    [Colors.orange, Colors.orange.shade800],
    [Colors.pink, Colors.pink.shade800]
  ];

  int? selectedCardIndex = 0;
  // double height = 230;
  double space = 25;
  double cardSpace = 32;
  double topSpace = 320;

  // double totalHeight() {
  // if (selectedCardIndex == null) {
  //   final cardLength = colors.length;
  //   return 25.0 * (cardLength + 1) + 230 * cardLength;
  // } else {
  // return topSpace + height + colors.length * cardSpace
  // + space
  // ;
  // }
  // }

  int toUnselectedCardPosition(int index) {
    // if (selectedCardIndex != null) {
    if (index < selectedCardIndex!) {
      return index;
    } else {
      return index - 1;
    }
    // }
    // return 0;
  }

  double getCardTopPosition(int index, selected) {
    // if (selectedCardIndex != null) {
    if (selected) {
      return space;
    } else {
      return topSpace + toUnselectedCardPosition(index) * cardSpace;
    }
    // } else {
    //   return 25.0 + index * 230 + index * 25.0;
    // }
  }

  double getCardScale(index, selected) {
    // if (selectedCardIndex != null) {
    if (selected) {
      return 1.0;
    } else {
      int unSelectedCard = colors.length - 1;
      return 1.0 -
          (unSelectedCard - toUnselectedCardPosition(index) - 1) * 0.05;
    }
    // } else {
    //   return 1.0;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 39, 39, 39),
        body: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
              for (int i = 0; i < colors.length; i++)
                AnimatedPositioned(
                  top: getCardTopPosition(i, i == selectedCardIndex),
                  duration: const Duration(milliseconds: 300),
                  child: AnimatedScale(
                    scale: getCardScale(i, i == selectedCardIndex),
                    duration: const Duration(milliseconds: 300),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCardIndex = i;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        height: 230,
                        width: MediaQuery.of(context).size.width - 20,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            // color: colors[i],
                            gradient: LinearGradient(colors: [
                              colors[i][0],
                              colors[i][1],
                            ])),
                        padding: const EdgeInsets.all(15),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Acmebank',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Image.asset(
                                'assets/chip_image.png',
                                height: 70,
                              ),
                              Text(
                                '1234  1234  1234  1234',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    letterSpacing: 2,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '12/12',
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.5),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Visa'.toUpperCase(),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ]),
                      ),
                    ),
                  ),
                ),
              // if (selectedCardIndex != null)
              //   Positioned.fill(
              //       child: GestureDetector(
              //     onVerticalDragEnd: (_) {
              //       // setState(() {
              //       //   selectedCardIndex = null;
              //       // });
              //     },
              //     onVerticalDragStart: (_) {
              //       // setState(() {
              //       //   selectedCardIndex = null;
              //       // });
              //     },
              //   ))
            ],
          ),
        ));
  }
}
