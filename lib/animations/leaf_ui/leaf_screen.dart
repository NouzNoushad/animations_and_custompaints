import 'package:flutter/material.dart';
import 'package:flutter_animations/animations/leaf_ui/constants.dart';
import 'package:flutter_animations/animations/leaf_ui/leaf_details.dart';

class LeafScreen extends StatefulWidget {
  const LeafScreen({super.key});

  @override
  State<LeafScreen> createState() => _LeafScreenState();
}

class _LeafScreenState extends State<LeafScreen> {
  static List<Map<String, dynamic>> tabTitles = [
    {'number': 16, 'title': 'All'},
    {'number': 8, 'title': 'Outdoor'},
    {'number': 4, 'title': 'Indoor'},
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(86, 130, 92, 1),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(50),
                    )),
                child: Column(children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'florest',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Icon(
                              Icons.shopping_bag_outlined,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Stack(
                    children: [
                      Align(
                          alignment: Alignment.topRight,
                          child: Image.asset('assets/leaf3.png')),
                      Container(
                        width: 150,
                        alignment: Alignment.bottomCenter,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 40),
                        child: const Text(
                          'Top Picks',
                          style: TextStyle(
                              color: Color.fromRGBO(229, 220, 165, 1),
                              fontSize: 55,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )),
                ]),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      height: 70,
                      width: double.infinity,
                      color: Colors.transparent,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: tabTitles.length,
                        itemBuilder: (context, index) {
                          var tab = tabTitles[index];
                          return Transform(
                            transform: Matrix4.translationValues(0, -10, 0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 13,
                                    backgroundColor: selectedIndex == index
                                        ? Colors.black
                                        : Colors.grey,
                                    child: Text(
                                      tab['number'].toString(),
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    tab['title'],
                                    style: TextStyle(
                                        color: selectedIndex == index
                                            ? Colors.black
                                            : Colors.grey,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            width: 50,
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 15),
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var plant = plants[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => LeafDetailsScreen(
                                          selectedIndex: index,
                                        )));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    height: 140,
                                    margin: const EdgeInsets.only(left: 70),
                                    decoration: const BoxDecoration(
                                        color: Color.fromRGBO(86, 130, 92, 1),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                        )),
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 15, 20, 15),
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 50),
                                        Expanded(
                                          child: Column(children: [
                                            const Text(
                                              'Maku rela Vera',
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromRGBO(
                                                    229, 220, 165, 1),
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    border: Border.all(
                                                        width: 1.5,
                                                        color: Colors.white54),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: Image.asset(
                                                    'assets/drop.png',
                                                    width: 18,
                                                    color: Colors.white54,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    border: Border.all(
                                                        width: 1.5,
                                                        color: Colors.white54),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: Image.asset(
                                                    'assets/temperature.png',
                                                    width: 18,
                                                    color: Colors.white54,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    border: Border.all(
                                                        width: 1.5,
                                                        color: Colors.white54),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: Image.asset(
                                                    'assets/sun.png',
                                                    width: 18,
                                                    color: Colors.white54,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ]),
                                        ),
                                        const SizedBox(
                                          width: 25,
                                        ),
                                        Container(
                                          height: 70,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                          ),
                                          child: const Icon(
                                            Icons.add,
                                            size: 40,
                                            color:
                                                Color.fromRGBO(86, 130, 92, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 10,
                                    left: 10,
                                    child: Image.asset(
                                      'assets/$plant.png',
                                      height: 120,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 15,
                            );
                          },
                          itemCount: plants.length),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
