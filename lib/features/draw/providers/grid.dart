import 'package:flutter/material.dart';

class Grid with ChangeNotifier {
  
  bool isGridEnabled = false;
  int gridSize = 4; // 4x4 сетка по умолчанию
  
  void toggleGrid() {
    isGridEnabled = !isGridEnabled;
    notifyListeners();
  }
}