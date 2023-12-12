import 'package:flutter_animations/state_management/nobot.dart';

class CounterNobot extends Nobot<int> {
  CounterNobot() : super(0);
  String tracker = '';

  void increment() => emit(value + 1);
  // void decrement() => emit(value - 1);

  // String counterTracker(newValue) {
  //   if (newValue == 0) {
  //     tracker = 'Lets Start';
  //   } else if (newValue > 0 && newValue < 5) {
  //     tracker = 'Keep going';
  //   } else if (newValue == 5) {
  //     tracker = 'Almost there';
  //   } else if (newValue > 5 && newValue < 10) {
  //     tracker = 'Never quit';
  //   } else if (newValue == 10) {
  //     tracker = 'Goal achieved';
  //   }
  //   return tracker;
  // }
}
