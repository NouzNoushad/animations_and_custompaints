import 'package:flutter/material.dart';

class SelectedScreen extends StatelessWidget {
  const SelectedScreen(
      {super.key, required this.controller, required this.text});
  final AnimationController controller;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 55,
            color: Colors.pink,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () {
                if (controller.isCompleted) {
                  controller.reverse();
                } else {
                  controller.forward();
                }
              },
              icon: const Icon(Icons.menu),
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
