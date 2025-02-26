import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class Draw extends StatefulWidget {
  @override
  State<Draw> createState() => _DrawState();
}

class _DrawState extends State<Draw> {
  List<ui.Path> _paths = [];
  List<ui.Path> _undonePaths = [];
  Color _currentColor = Colors.black;
  double _strokeWidth = 5.0;
  DrawingTool _currentTool = DrawingTool.pen;
  
  // Контролируемая сетка
  bool _isGridEnabled = false;
  int _gridSize = 4; // 4x4 сетка по умолчанию
  
  // Добавление шаблонов
  final List<Widget> _comicCells = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildToolBar(),
        Expanded(
          child: Stack(
            children: [
              _buildGrid(),
              _buildCanvas(),
              ..._comicCells,
            ],
          ),
        ),
      ]
    );
  }

  // Панель инструментов
  Widget _buildToolBar() {
    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.brush),
            onPressed: () => _setTool(DrawingTool.pen),
          ),
          IconButton(
            icon: Icon(Icons.create),
            onPressed: () => _setTool(DrawingTool.pencil),
          ),
          IconButton(
            icon: Icon(Icons.call),
            onPressed: () => _setTool(DrawingTool.fill),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _setTool(DrawingTool.clear),
          ),
          IconButton(
            icon: Icon(Icons.undo),
            onPressed: _undo,
          ),
          IconButton(
            icon: Icon(Icons.redo),
            onPressed: _redo,
          ),
          IconButton(
            icon: Icon(Icons.grid_on),
            onPressed: _toggleGrid,
          ),
        ],
      ),
    );
  }

  // Область рисования
  Widget _buildCanvas() {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          if (_currentTool == DrawingTool.pen || _currentTool == DrawingTool.pencil) {
            _paths.add(_drawPath(details.localPosition));
          }
        });
      },
      onPanEnd: (details) {
        _undonePaths.clear();
      },
      child: CustomPaint(
        size: Size(double.infinity, double.infinity),
        painter: ComicPainter(
          paths: _paths,
          strokeWidth: _strokeWidth,
          color: _currentColor,
        ),
      ),
    );
  }

  // Рисование пути
  ui.Path _drawPath(Offset position) {
    ui.Path path = ui.Path();
    path.moveTo(position.dx, position.dy);
    path.lineTo(position.dx + 1, position.dy + 1);
    return path;
  }

  // Сетка
  Widget _buildGrid() {
    if (!_isGridEnabled) return SizedBox.shrink();

    double gridWidth = MediaQuery.of(context).size.width;
    double gridHeight = MediaQuery.of(context).size.height;

    List<Widget> gridLines = [];

    for (int i = 0; i < _gridSize; i++) {
      gridLines.add(Positioned(
        left: gridWidth / _gridSize * i,
        top: 0,
        child: Container(
          width: 1,
          height: gridHeight,
          color: Colors.grey.withOpacity(0.5),
        ),
      ));
      gridLines.add(Positioned(
        top: gridHeight / _gridSize * i,
        left: 0,
        child: Container(
          width: gridWidth,
          height: 1,
          color: Colors.grey.withOpacity(0.5),
        ),
      ));
    }
    return Stack(children: gridLines);
  }

  // Функции для действий
  // void _setTool(DrawingTool tool) {
  //   setState(() {
  //     _currentTool = tool;
  //   });
  // }

  // void _toggleGrid() {
  //   setState(() {
  //     _isGridEnabled = !_isGridEnabled;
  //   });
  // }

  // void _undo() {
  //   setState(() {
  //     if (_paths.isNotEmpty) {
  //       _undonePaths.add(_paths.removeLast());
  //     }
  //   });
  // }

  // void _redo() {
  //   setState(() {
  //     if (_undonePaths.isNotEmpty) {
  //       _paths.add(_undonePaths.removeLast());
  //     }
  //   });
  // }

  // void _addPage() {
  //   setState(() {
  //     // Добавляем новую страницу
  //     _comicCells.add(Positioned(
  //       left: 50.0,
  //       top: 50.0,
  //       child: GestureDetector(
  //         onPanUpdate: (details) {
  //           // Для перетаскивания ячеек
  //           setState(() {
  //             // Логика для перетаскивания
  //           });
  //         },
  //         child: Container(
  //           width: 150,
  //           height: 150,
  //           color: Colors.blue.withOpacity(0.3),
  //           child: Center(child: Text('Page')),
  //         ),
  //       ),
  //     ));
  //   });
  // }

  // void _saveComic() {
  //   // Логика для сохранения комикса (например, в локальное хранилище или на сервер)
  //   print("Comic saved!");
  // }
}

class ComicPainter extends CustomPainter {
  final List<ui.Path> paths;
  final double strokeWidth;
  final Color color;

  ComicPainter({required this.paths, required this.strokeWidth, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    for (var path in paths) {
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

enum DrawingTool { pen, pencil, fill, eraser, clear }