import 'package:flutter/material.dart';
import 'package:ticket_clippers/ticket_clippers.dart';

class TicketDesigns extends StatelessWidget {
  const TicketDesigns({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 37, 22),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ticketDesign(),
              couponDesign(),
              stampDesign(),
            ],
          ),
        ),
      ),
    );
  }

  Widget ticketDesign() => Align(
        alignment: Alignment.center,
        child: ClipPath(
          clipper: TicketRoundedEdgeClipper(
              edge: Edge.vertical, position: 0, radius: 30),
          child: ClipPath(
            clipper: TicketRoundedEdgeClipper(
                edge: Edge.vertical, position: 360, radius: 30),
            child: ClipPath(
              clipper: TicketRoundedEdgeClipper(
                  edge: Edge.vertical, position: 285, radius: 30),
              child: SizedBox(
                height: 150,
                width: 360,
                child: Row(
                  children: [
                    Expanded(
                        flex: 4,
                        child: ColoredBox(
                          color: Colors.white,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                            child: Column(children: [
                              Expanded(
                                  flex: 4,
                                  child: Container(
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        ),
                                        color: Colors.blue),
                                    child: const Center(
                                      child: Text(
                                        '70%',
                                        style: TextStyle(
                                          fontSize: 90,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )),
                              const SizedBox(
                                height: 3,
                              ),
                              Expanded(
                                  child: Container(
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                    color: Colors.pink),
                                child: Center(
                                  child: Text(
                                    'Special Discount'.toUpperCase(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        letterSpacing: 2,
                                        color: Colors.white),
                                  ),
                                ),
                              )),
                            ]),
                          ),
                        )),
                    Expanded(
                        child: Container(
                      color: Colors.blue,
                    )),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Widget couponDesign() => ClipPath(
        clipper: RoundedEdgeClipper(
          edge: Edge.horizontal,
          points: 10,
        ),
        child: ClipPath(
          clipper: TicketRoundedEdgeClipper(
              radius: 30, position: 75, edge: Edge.vertical),
          child: Container(
            height: 150,
            width: 360,
            color: const Color.fromARGB(255, 253, 31, 31),
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                )),
                Expanded(
                    flex: 4,
                    child: Container(
                        height: double.infinity,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(width: 1.5, color: Colors.white)),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Coupon'.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 45,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Market Discount'.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ))),
              ],
            ),
          ),
        ),
      );

  Widget stampDesign() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Align(
            child: ClipPath(
              clipper: RoundedEdgeClipper(
                edge: Edge.all,
              ),
              child: Container(
                height: 150,
                width: 150,
                decoration: const BoxDecoration(
                  color: Colors.lightGreen,
                ),
                child: Container(
                  margin: const EdgeInsets.all(15),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 1.5, color: Colors.white)),
                  child: Image.asset('assets/banana.png'),
                ),
              ),
            ),
          ),
          Align(
            child: ClipPath(
              clipper: RoundedEdgeClipper(
                edge: Edge.all,
              ),
              child: Container(
                height: 150,
                width: 150,
                decoration: const BoxDecoration(
                  color: Colors.orange,
                ),
                child: Container(
                  margin: const EdgeInsets.all(15),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 1.5, color: Colors.white)),
                  child: Image.asset('assets/apple.png'),
                ),
              ),
            ),
          ),
        ],
      );
}
