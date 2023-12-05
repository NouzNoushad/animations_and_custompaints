import 'dart:math';

import 'package:flutter/material.dart';

class ListViewScroll extends StatefulWidget {
  const ListViewScroll({super.key});

  @override
  State<ListViewScroll> createState() => _ListViewScrollState();
}

class _ListViewScrollState extends State<ListViewScroll>
    with SingleTickerProviderStateMixin {
  static List<Color> colors = [
    Colors.purple,
    Colors.pink,
    Colors.teal,
    Colors.amber,
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.lime,
    Colors.brown,
    Colors.black
  ];
  late ScrollController scrollController;
  late TabController tabController;
  double scrollPosition = 0.0;

  @override
  void initState() {
    scrollController = ScrollController();
    tabController = TabController(length: 10, vsync: this);
    scrollController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Expanded(
            flex: 1,
            child: TabBar(
              controller: tabController,
              isScrollable: true,
              tabs: colors.map((e) {
                return Container(
                  padding: const EdgeInsets.all(8),
                  color: e,
                  child: const Text('Button'),
                );
              }).toList(),
              onTap: (index) {
                /// scroll position of list view (reference)
                print('////////////// index: ${scrollController.position}');
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  scrollController.animateTo(scrollPosition,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
                });
              },
            ),
            // ListView.separated(
            //     padding: const EdgeInsets.all(8),
            //     separatorBuilder: (context, index) => const SizedBox(
            //           width: 8,
            //         ),
            //     scrollDirection: Axis.horizontal,
            //     itemCount: colors.length,
            //     itemBuilder: (context, index) {
            //       return ElevatedButton(
            //         onPressed: () {
            //           /// scroll position of list view (reference)
            //           print(
            //               '////////////// index: ${scrollController.position}');
            //           scrollController.animateTo(scrollPosition,
            //               duration: const Duration(seconds: 1),
            //               curve: Curves.linear);
            //         },
            //         style: ElevatedButton.styleFrom(
            //           backgroundColor: colors[index],
            //         ),
            //         child: const Text('button'),
            //       );
            //     }),
          ),
          Expanded(
            flex: 12,
            child: TabBarView(controller: tabController, children: [
              ListView.separated(
                  controller: scrollController,
                  padding: const EdgeInsets.all(8),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 8,
                      ),
                  itemCount: colors.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        print(
                            '//////////// ${scrollController.position.pixels}');
                        setState(() {
                          scrollPosition = scrollController.position.pixels;
                        });
                      },
                      child: Container(
                        height: 100,
                        color: colors[index],
                      ),
                    );
                  }),
              const Center(
                child: Text('Tabs'),
              ),
              const Center(
                child: Text('Tabs'),
              ),
              const Center(
                child: Text('Tabs'),
              ),
              const Center(
                child: Text('Tabs'),
              ),
              const Center(
                child: Text('Tabs'),
              ),
              const Center(
                child: Text('Tabs'),
              ),
              const Center(
                child: Text('Tabs'),
              ),
              const Center(
                child: Text('Tabs'),
              ),
              const Center(
                child: Text('Tabs'),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _animationController;
  late Animation<double> _wingAnimation;
  late Animation<double> _singingAnimation;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _wingAnimation =
        Tween<double>(begin: 0, end: pi / 6).animate(_animationController);

    _singingAnimation =
        Tween<double>(begin: 0, end: pi / 12).animate(_animationController);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Singing Bird'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            CustomTab(text: 'Tab 1'),
            CustomTab(text: 'Tab 2'),
            CustomTab(text: 'Tab 3'),
          ],
          indicator: CustomTabIndicator(
            wingAnimation: _wingAnimation,
            singingAnimation: _singingAnimation,
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Container(color: Colors.red),
          Container(color: Colors.green),
          Container(color: Colors.blue),
        ],
      ),
    );
  }
}

class CustomTab extends StatelessWidget {
  final String text;

  const CustomTab({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Align(
        alignment: Alignment.center,
        child: Text(text),
      ),
    );
  }
}

class CustomTabIndicator extends Decoration {
  final Animation<double> wingAnimation;
  final Animation<double> singingAnimation;

  const CustomTabIndicator({
    required this.wingAnimation,
    required this.singingAnimation,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomTabIndicatorPainter(
        this, onChanged, wingAnimation, singingAnimation);
  }
}

class _CustomTabIndicatorPainter extends BoxPainter {
  final CustomTabIndicator decoration;
  final Animation<double> wingAnimation;
  final Animation<double> singingAnimation;

  _CustomTabIndicatorPainter(
    this.decoration,
    VoidCallback? onChanged,
    this.wingAnimation,
    this.singingAnimation,
  ) : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect rect = offset & configuration.size!;
    final Paint paint = Paint();
    paint.color = Colors.green; // Set the background color to green

    final Path path = Path();
    path.addRect(rect);
    canvas.drawPath(path, paint);

    // Draw a singing bird on the tab indicator with animated wing and singing animation
    final Paint birdPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    const double birdSize = 20.0;
    final double birdX = rect.center.dx - birdSize / 2;
    final double birdY = rect.center.dy - birdSize / 2;

    // Body
    canvas.drawCircle(Offset(birdX + birdSize / 2, birdY + birdSize / 2),
        birdSize / 3, birdPaint);

    // Head
    canvas.drawCircle(Offset(birdX + birdSize / 2, birdY + birdSize / 6),
        birdSize / 6, birdPaint);

    // Beak
    final Path beakPath = Path()
      ..moveTo(birdX + birdSize / 2, birdY + birdSize / 3)
      ..lineTo(birdX + birdSize * 2 / 3, birdY + birdSize / 2)
      ..lineTo(birdX + birdSize / 2, birdY + birdSize * 2 / 3);
    canvas.drawPath(beakPath, birdPaint);

    // Animated Wing
    const double wingLength = birdSize / 2;
    final double wingX = birdX + birdSize / 2 - wingLength / 2;
    final double wingY = birdY + birdSize / 3;

    final double wingRotation = wingAnimation.value;

    final Path wingPath = Path()
      ..moveTo(wingX, wingY)
      ..lineTo(wingX + wingLength, wingY - wingLength / 2);

    final Matrix4 wingTransform = Matrix4.identity()
      ..translate(wingX, wingY)
      ..rotateZ(wingRotation)
      ..translate(-wingX, -wingY);

    wingPath.transform(wingTransform.storage);
    canvas.drawPath(wingPath, birdPaint);

    // Singing Animation
    final double beakRotation = singingAnimation.value;
    final Path singingBeakPath = Path()
      ..moveTo(birdX + birdSize / 2, birdY + birdSize / 3)
      ..lineTo(birdX + birdSize * 2 / 3, birdY + birdSize / 2)
      ..lineTo(birdX + birdSize / 2, birdY + birdSize * 2 / 3);

    final Matrix4 beakTransform = Matrix4.identity()
      ..translate(birdX + birdSize / 2, birdY + birdSize / 3)
      ..rotateZ(beakRotation)
      ..translate(-(birdX + birdSize / 2), -(birdY + birdSize / 3));

    singingBeakPath.transform(beakTransform.storage);
    canvas.drawPath(singingBeakPath, birdPaint);
  }
}
