import 'package:comicsstudio/features/draw/providers/grid.dart';
import 'package:comicsstudio/features/draw/providers/undo_redo.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:provider/provider.dart';

import '../../providers/tools.dart';
import '../../providers/addPage.dart';

class Draw extends StatefulWidget {
  const Draw({ super.key });

  @override
  _DrawState createState() => _DrawState();
}

class _DrawState extends State<Draw> {
  @override
  Widget build(BuildContext context) {
  final comicCells = Provider.of<addPage>(context).comicCells;

  return Column(
    children: [
      _buildToolBar(context),
      Expanded(
        child: Stack(
          children: [
            _buildCanvas(context),
            ...comicCells,
          ],
        ),
      ),
    ],
  );
}

  // Панель инструментов
  Widget _buildToolBar(BuildContext context) {
    final tools = Provider.of<Tools>(context, listen: false);
    final undoRedo = Provider.of<UndoRedo>(context, listen: false);
    final grid = Provider.of<Grid>(context, listen: false);

    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.brush),
            onPressed: () => tools.setTool(DrawingTool.pen),
          ),
          IconButton(
            icon: const Icon(Icons.create),
            onPressed: () => tools.setTool(DrawingTool.pencil),
          ),
          IconButton(
            icon: const Icon(Icons.format_paint),
            onPressed: () => tools.setTool(DrawingTool.fill),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => tools.setTool(DrawingTool.clear),
          ),
          IconButton(
            icon: const Icon(Icons.undo),
            onPressed: undoRedo.undo,
          ),
          IconButton(
            icon: const Icon(Icons.redo),
            onPressed: undoRedo.redo,
          ),
          IconButton(
            icon: const Icon(Icons.grid_on),
            onPressed: grid.toggleGrid,
          ),
        ],
      ),
    );
  }

  // Область рисования
  Widget _buildCanvas(BuildContext context) {
    final undoRedo = Provider.of<UndoRedo>(context);
    final tools = Provider.of<Tools>(context);

    final strokeWidth = tools.strokeWidth;
    final currentColor = tools.currentColor;

    return GestureDetector(
      onPanStart: (details) {
        undoRedo.startNewPath(details.localPosition);
      },
      onPanUpdate: (details) {
        if (tools.currentTool == DrawingTool.pen ||
            tools.currentTool == DrawingTool.pencil) {
          undoRedo.updateCurrentPath(details.localPosition);
        }
      },
      onPanEnd: (details) {
        undoRedo.finishCurrentPath();
      },
      child: CustomPaint(
        size: const Size(double.infinity, double.infinity),
        painter: ComicPainter(
          paths: undoRedo.paths, // Здесь уже корректный тип List<ui.Path>
          strokeWidth: strokeWidth,
          color: currentColor,
        ),
      ),
    );
  }

  

  // @override
  // Widget build(BuildContext context) {
  //   final comicCells = Provider.of<addPage>(context).comicCells;

  //   return Column(
  //     children: [
  //       _buildToolBar(context),
  //       Expanded(
  //         child: Stack(
  //           children: [
  //             _buildCanvas(context),
  //             ...comicCells,
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // // Панель инструментов
  // Widget _buildToolBar(BuildContext context) {
  //   final tools = Provider.of<Tools>(context, listen: false);
  //   final undoRedo = Provider.of<UndoRedo>(context, listen: false);
  //   final grid = Provider.of<Grid>(context, listen: false);

  //   return Container(
  //     color: Colors.grey[200],
  //     padding: const EdgeInsets.symmetric(vertical: 10),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //       children: [
  //         IconButton(
  //           icon: const Icon(Icons.brush),
  //           onPressed: () => tools.setTool(DrawingTool.pen),
  //         ),
  //         IconButton(
  //           icon: const Icon(Icons.create),
  //           onPressed: () => tools.setTool(DrawingTool.pencil),
  //         ),
  //         IconButton(
  //           icon: const Icon(Icons.format_paint),
  //           onPressed: () => tools.setTool(DrawingTool.fill),
  //         ),
  //         IconButton(
  //           icon: const Icon(Icons.delete),
  //           onPressed: () => tools.setTool(DrawingTool.clear),
  //         ),
  //         IconButton(
  //           icon: const Icon(Icons.undo),
  //           onPressed: undoRedo.undo,
  //         ),
  //         IconButton(
  //           icon: const Icon(Icons.redo),
  //           onPressed: undoRedo.redo,
  //         ),
  //         IconButton(
  //           icon: const Icon(Icons.grid_on),
  //           onPressed: grid.toggleGrid,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // // Область рисования
  // Widget _buildCanvas(BuildContext context) {
  //   final undoRedo = Provider.of<UndoRedo>(context);
  //   final tools = Provider.of<Tools>(context);

  //   final strokeWidth = tools.strokeWidth;
  //   final currentColor = tools.currentColor;

  //   return GestureDetector(
  //     onPanStart: (details) {
  //       undoRedo.startNewPath(details.localPosition);
  //     },
  //     onPanUpdate: (details) {
  //       if (tools.currentTool == DrawingTool.pen ||
  //           tools.currentTool == DrawingTool.pencil) {
  //         undoRedo.updateCurrentPath(details.localPosition);
  //       }
  //     },
  //     onPanEnd: (details) {
  //       undoRedo.finishCurrentPath();
  //     },
  //     child: CustomPaint(
  //       size: const Size(double.infinity, double.infinity),
  //       painter: ComicPainter(
  //         paths: undoRedo.paths, // Здесь уже корректный тип List<ui.Path>
  //         strokeWidth: strokeWidth,
  //         color: currentColor,
  //       ),
  //     ),
  //   );
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
