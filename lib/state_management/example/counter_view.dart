import 'package:flutter/material.dart';
import 'package:flutter_animations/state_management/example/color_nobot.dart';
import 'package:flutter_animations/state_management/example/counter_nobot.dart';
import 'package:flutter_animations/state_management/extension.dart';
import 'package:flutter_animations/state_management/nobot_builder.dart';

class CounterWidget extends StatelessWidget {
  const CounterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text('My Own State management'),
      ),
      body: NobotBuilder<ColorNobot, Color>(builder: (context, color) {
        return Material(
          color: color,
          child: NobotBuilder<CounterNobot, int>(builder: (context, state) {
            return Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$state',
                  style: const TextStyle(
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                // Text(
                //   context.of<CounterNobot, int>().counterTracker(state),
                //   style: const TextStyle(
                //     fontSize: 20,
                //     fontWeight: FontWeight.bold,
                //     color: Colors.white,
                //   ),
                // ),
              ],
            ));
          }),
        );
      }),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.indigo,
            onPressed: () {
              context.of<CounterNobot, int>().increment();
              context.of<ColorNobot, Color>().changeColor();
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(
            width: 10,
          ),
          // FloatingActionButton(
          //   backgroundColor: Colors.indigo,
          //   onPressed: () => context.of<CounterNobot, int>().decrement(),
          //   child: const Icon(Icons.remove),
          // ),
        ],
      ),
    );
  }
}
