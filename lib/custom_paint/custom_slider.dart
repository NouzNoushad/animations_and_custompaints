import 'package:flutter/material.dart';

class CustomSliderScreen extends StatefulWidget {
  const CustomSliderScreen({super.key});

  @override
  State<CustomSliderScreen> createState() => _CustomSliderScreenState();
}

class _CustomSliderScreenState extends State<CustomSliderScreen> {
  double positionX = 10.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onHorizontalDragStart: (details) {
          print('start: $details');
        },
        onHorizontalDragEnd: (details) {
          print('end: $details');
        },
        onHorizontalDragUpdate: (details) {
          setState(() {
            positionX = details.globalPosition.dx + 10;
            if (positionX >= 300) {
              positionX = 300;
            } else if (positionX < 300) {
              positionX = details.globalPosition.dx + 10;
            }
          });
        },
        child: Align(
          alignment: Alignment.center,
          child: IntrinsicHeight(
            child: Stack(
              children: [
                Center(
                  child: Container(
                    height: 25,
                    width: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          width: 2,
                          color: Colors.black,
                        )),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 20,
                        width: positionX,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ),
                Transform(
                  transform: Matrix4.translationValues(positionX + 30, 0, 0),
                  child: const CircleAvatar(
                    radius: 23,
                    backgroundColor: Colors.black,
                    child: CircleAvatar(
                      backgroundColor: Colors.pink,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
