import 'package:flutter/material.dart';

import '../presentation/widgets/draw.dart';

class Tools with ChangeNotifier {
  
  double _strokeWidth = 5.0;
  double get strokeWidth => _strokeWidth;

  Color _currentColor = Colors.black;
  Color get currentColor => _currentColor;


  DrawingTool _currentTool = DrawingTool.pen;
  DrawingTool get currentTool => _currentTool;

  void setTool(DrawingTool tool) {
    _currentTool = tool;
    notifyListeners();
  }
}