import 'package:flutter/material.dart';
import 'package:ticket_clippers/ticket_clippers.dart';

class TicketClipperScreen extends StatelessWidget {
  const TicketClipperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticket Clippers'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: GridView(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipPath(
                clipper: TicketRoundedEdgeClipper(
                    edge: Edge.horizontal, position: 80, radius: 20),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.red,
                    ),
                    padding: const EdgeInsets.all(10),
                    child: const Center(
                        child: Text(
                      'Ticket Rounded Edge Clipper \nEdge.horizontal',
                      textAlign: TextAlign.center,
                    )),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipPath(
                clipper: TicketRoundedEdgeClipper(
                    edge: Edge.left, position: 80, radius: 20),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.purple,
                    ),
                    padding: const EdgeInsets.all(10),
                    child: const Center(
                        child: Text(
                      'Ticket Rounded Edge Clipper \nEdge.left',
                      textAlign: TextAlign.center,
                    )),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipPath(
                clipper: RoundedEdgeClipper(
                  edge: Edge.horizontal,
                  depth: 20,
                  points: 10,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                    ),
                    padding: const EdgeInsets.all(10),
                    child: const Center(
                        child: Text(
                      'Rounded Edge Clipper \nEdge.horizontal',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    )),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipPath(
                clipper: RoundedEdgeClipper(
                  edge: Edge.right,
                  depth: 20,
                  points: 15,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: const BoxDecoration(
                      color: Colors.indigo,
                    ),
                    padding: const EdgeInsets.all(10),
                    child: const Center(
                        child: Text(
                      'Rounded Edge Clipper \nEdge.right',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    )),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipPath(
                clipper: PointedEdgeClipper(
                  points: 30,
                  edge: Edge.horizontal,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                    ),
                    padding: const EdgeInsets.all(10),
                    child: const Center(
                        child: Text(
                      'Pointed Edge Clipper \nEdge.horizontal',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    )),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipPath(
                clipper: PointedEdgeClipper(
                  points: 20,
                  edge: Edge.left,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                    ),
                    padding: const EdgeInsets.all(10),
                    child: const Center(
                        child: Text(
                      'Pointed Edge Clipper \nEdge.left',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
