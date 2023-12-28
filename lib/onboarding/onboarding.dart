import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animations/onboarding/onboarding_model.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController pageController;
  int pageIndex = 0;
  Timer? timer;

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      changeScreen();
    });
    super.initState();
  }

  changeScreen() {
    if (pageIndex < 3) {
      pageIndex++;
    } else {
      pageIndex = 0;
    }
    pageController.animateToPage(pageIndex,
        duration: const Duration(milliseconds: 350), curve: Curves.easeIn);
  }

  @override
  void dispose() {
    pageController.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff1f005c),
                  Color(0xff5b0060),
                  Color(0xff870160),
                  Color(0xffac255e),
                  Color(0xffca485c),
                  Color(0xffe16b5c),
                  Color(0xfff39060),
                  Color(0xffffb56b),
                ],
                tileMode: TileMode.mirror)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Expanded(
              child: PageView.builder(
                  controller: pageController,
                  onPageChanged: (index) {
                    setState(() {
                      pageIndex = index;
                    });
                  },
                  itemCount: demoData.length,
                  itemBuilder: (context, index) => OnBoardContent(
                        title: demoData[index].title,
                        description: demoData[index].description,
                      ))),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const NewScreen()));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: const ShapeDecoration(
                        color: Color(0xffac255e), shape: StadiumBorder()),
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(
                        demoData.length,
                        (index) => Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: DotIndicator(isActive: index == pageIndex),
                            ))
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    if (pageIndex == 3) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const NewScreen()));
                    } else {
                      changeScreen();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: const ShapeDecoration(
                        color: Color(0xffac255e), shape: StadiumBorder()),
                    child: Text(
                      pageIndex == 3 ? 'Done' : 'Next',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({super.key, required this.isActive});
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 10,
      width: isActive ? 24 : 10,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xff5b0060) : Colors.white,
        border: isActive
            ? null
            : Border.all(
                width: 1.5,
                color: const Color(0xff5b0060),
              ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}

class OnBoardContent extends StatelessWidget {
  const OnBoardContent(
      {super.key, required this.title, required this.description});
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 15,
            height: 1.8,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        const Spacer(),
      ],
    );
  }
}

class NewScreen extends StatelessWidget {
  const NewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff1f005c),
          title: const Text('New Screen'),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff1f005c),
                    Color(0xff5b0060),
                    Color(0xff870160),
                    Color(0xffac255e),
                    Color(0xffca485c),
                    Color(0xffe16b5c),
                    Color(0xfff39060),
                    Color(0xffffb56b),
                  ],
                  tileMode: TileMode.mirror)),
        ));
  }
}
