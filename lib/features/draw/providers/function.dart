import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../presentation/widgets/draw.dart';


class FunctionDraw with ChangeNotifier {

  List<ui.Path> _paths = [];
  List get paths => _paths;
  
  List<ui.Path> _undonePaths = [];
  List get undonePaths => _undonePaths;

  Color _currentColor = Colors.black;
  Color get currentColor => _currentColor;

  double _strokeWidth = 5.0;
  double get strokeWidth => _strokeWidth;

  DrawingTool _currentTool = DrawingTool.pen;
  DrawingTool get currentTool => _currentTool;
  
  // Контролируемая сетка
  bool isGridEnabled = false;
  int gridSize = 4; // 4x4 сетка по умолчанию
  
  // Добавление шаблонов
  final List<Widget> comicCells = [];
  
  void setTool(DrawingTool tool) {
    _currentTool = tool;
    notifyListeners();
  }

  void toggleGrid() {
   isGridEnabled = !isGridEnabled;
    notifyListeners();
  }

  void undo() {
    if (paths.isNotEmpty) {
      undonePaths.add(paths.removeLast());
    }
  }

  void redo() {
    if (undonePaths.isNotEmpty) {
      paths.add(undonePaths.removeLast());
    }
  }

  void addPage() {
    // Добавляем новую страницу
    comicCells.add(Positioned(
      left: 50.0,
      top: 50.0,
      child: GestureDetector(
        onPanUpdate: (details) {
          // Для перетаскивания ячеек
          notifyListeners();
            // Логика для перетаскивания
        },
        child: Container(
          width: 150,
          height: 150,
          color: Colors.blue,
          child: const Center(child: Text('Page')),
        ),
      ),
    ));
  }

  void saveComic() {
    // Логика для сохранения комикса (например, в локальное хранилище или на сервер)
    print("Comic saved!");
  }
}