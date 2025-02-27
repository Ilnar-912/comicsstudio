import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class UndoRedo with ChangeNotifier {

  final List<ui.Path> _paths = [];
  List<ui.Path> get paths => _paths;

  List<ui.Path> undonePaths = [];
  List get _undonePaths => undonePaths;
  ui.Path? _currentPath;

  void startNewPath(Offset start) {
    _currentPath = ui.Path()..moveTo(start.dx, start.dy);
    _paths.add(_currentPath!);
    notifyListeners();
  }

  void updateCurrentPath(Offset point) {
    if (_currentPath != null) {
      _currentPath!.lineTo(point.dx, point.dy);
      notifyListeners();
    }
  }
   void finishCurrentPath() {
    _currentPath = null;
  }

  void addPath(ui.Path path) {
    _paths.add(path);
    _undonePaths.clear(); // Очистка отмененных путей при новом рисовании
    notifyListeners();
  }

  void clearUndonePaths() {
    _undonePaths.clear();
    notifyListeners();
  }

  void undo() {
    if (paths.isNotEmpty) {
      _undonePaths.add(paths.removeLast());
    }
  }

  void redo() {
    if (undonePaths.isNotEmpty) {
      paths.add(_undonePaths.removeLast());
    }
  }  
}