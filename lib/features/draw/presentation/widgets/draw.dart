import 'package:comicsstudio/features/draw/providers/function.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:provider/provider.dart';

class Draw extends StatefulWidget {
  @override
  State<Draw> createState() => _DrawState();
}

class _DrawState extends State<Draw> {
  get functionDraw => functionDraw;
  
  get paths => null;
  
  get currentTool => null;
  
  get undonePaths => null;
  
  get strokeWidth => null;
  
  get currentColor => null;

  // List<ui.Path> _paths = [];
  // List<ui.Path> _undonePaths = [];
  // Color _currentColor = Colors.black;
  // double _strokeWidth = 5.0;
  // DrawingTool _currentTool = DrawingTool.pen;
  
  // // Контролируемая сетка
  // bool _isGridEnabled = false;
  // int _gridSize = 4; // 4x4 сетка по умолчанию
  
  // // Добавление шаблонов
  // final List<Widget> _comicCells = [];

  @override
  Widget build(BuildContext context) {

    Provider.of<FunctionDraw>(context);

    return Column(
      children: [
        _buildToolBar(),
        Expanded(
          child: Stack(
            children: [
              // _buildGrid(),
              _buildCanvas(),
              // ...comicCells,
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
            onPressed: () => functionDraw.setTool(DrawingTool.pen),
          ),
          IconButton(
            icon: Icon(Icons.create),
            onPressed: () => functionDraw.setTool(DrawingTool.pencil),
          ),
          IconButton(
            icon: Icon(Icons.call),
            onPressed: () => functionDraw.setToo(DrawingTool.fill),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => functionDraw.setToo(DrawingTool.clear),
          ),
          IconButton(
            icon: Icon(Icons.undo),
            onPressed: functionDraw.undo,
          ),
          IconButton(
            icon: Icon(Icons.redo),
            onPressed: functionDraw.redo,
          ),
          IconButton(
            icon: Icon(Icons.grid_on),
            onPressed: functionDraw.toggleGrid,
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
          if (currentTool == DrawingTool.pen || currentTool == DrawingTool.pencil) {
            paths.add(_drawPath(details.localPosition));
          }
        });
      },
      onPanEnd: (details) {
        undonePaths.clear();
      },
      child: CustomPaint(
        size: Size(double.infinity, double.infinity),
        painter: ComicPainter(
          paths: paths,
          strokeWidth: strokeWidth,
          color: currentColor,
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
  // Widget _buildGrid() {
  //   if (!isGridEnabled) return SizedBox.shrink();

  //   double gridWidth = MediaQuery.of(context).size.width;
  //   double gridHeight = MediaQuery.of(context).size.height;

  //   List<Widget> gridLines = [];

  //   for (int i = 0; i < _gridSize; i++) {
  //     gridLines.add(Positioned(
  //       left: gridWidth / _gridSize * i,
  //       top: 0,
  //       child: Container(
  //         width: 1,
  //         height: gridHeight,
  //         color: Colors.grey.withOpacity(0.5),
  //       ),
  //     ));
  //     gridLines.add(Positioned(
  //       top: gridHeight / _gridSize * i,
  //       left: 0,
  //       child: Container(
  //         width: gridWidth,
  //         height: 1,
  //         color: Colors.grey.withOpacity(0.5),
  //       ),
  //     ));
  //   }
  //   return Stack(children: gridLines);
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