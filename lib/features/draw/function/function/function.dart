

import 'package:flutter/material.dart';

import '../../presentation/widgets/draw.dart';

class FunctionDraw extends StatefulWidget {
  const FunctionDraw({ super.key });

  @override
  State<FunctionDraw> createState() => _FunctionState();
}

class _FunctionState extends State<FunctionDraw> {
  
  void _setTool(DrawingTool tool) {
    setState(() {
      _currentTool = tool;
    });
  }

  void _toggleGrid() {
    setState(() {
      _isGridEnabled = !_isGridEnabled;
    });
  }

  void _undo() {
    setState(() {
      if (_paths.isNotEmpty) {
        _undonePaths.add(_paths.removeLast());
      }
    });
  }

  void _redo() {
    setState(() {
      if (_undonePaths.isNotEmpty) {
        _paths.add(_undonePaths.removeLast());
      }
    });
  }

  void _addPage() {
    setState(() {
      // Добавляем новую страницу
      _comicCells.add(Positioned(
        left: 50.0,
        top: 50.0,
        child: GestureDetector(
          onPanUpdate: (details) {
            // Для перетаскивания ячеек
            setState(() {
              // Логика для перетаскивания
            });
          },
          child: Container(
            width: 150,
            height: 150,
            color: Colors.blue.withOpacity(0.3),
            child: Center(child: Text('Page')),
          ),
        ),
      ));
    });
  }

  void _saveComic() {
    // Логика для сохранения комикса (например, в локальное хранилище или на сервер)
    print("Comic saved!");

    @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
