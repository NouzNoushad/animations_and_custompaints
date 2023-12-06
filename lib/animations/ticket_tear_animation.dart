import 'package:flutter/material.dart';
import 'package:ticket_clippers/ticket_clippers.dart';

class TicketTearAnimation extends StatefulWidget {
  const TicketTearAnimation({super.key});

  @override
  State<TicketTearAnimation> createState() => _TicketTearAnimationState();
}

class _TicketTearAnimationState extends State<TicketTearAnimation> {
  double yPosition = 480.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: 280,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipPath(
              clipper: RoundedEdgeClipper(),
              child: Container(
                height: 200,
                width: 280,
                color: Colors.red,
              ),
            ),
            Positioned(
              top: yPosition,
              child: ClipPath(
                clipper: RoundedEdgeClipper(edge: Edge.top),
                child: SizedBox(
                  height: 100,
                  width: 280,
                  child: GestureDetector(
                    onVerticalDragStart: (details) {
                      print('////////////// start: $details');
                    },
                    onVerticalDragEnd: (details) {
                      print('////////////// end: ');
                      setState(() {
                        yPosition = MediaQuery.of(context).size.height;
                      });
                    },
                    onVerticalDragUpdate: (details) {
                      setState(() {
                        yPosition = details.globalPosition.dy;
                        print('/////////////////// position: $yPosition');
                      });
                    },
                    child: Container(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
