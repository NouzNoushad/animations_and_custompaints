import 'package:flutter/material.dart';

class PageProvider extends ChangeNotifier {
  int selectedIndex = 0;

  changePageScreen(index) {
    selectedIndex = index;
    notifyListeners();
  }
}
