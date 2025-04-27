import 'package:flutter/material.dart';

class NavProvider with ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void setIndex(int idx) {
    if (idx != _currentIndex) {
      _currentIndex = idx;
      notifyListeners();
    }
  }
}
