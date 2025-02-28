import 'package:flutter/material.dart';

import '../../domain/models/drawing_point.dart';

class DrawingPainter extends CustomPainter {
  final List<DrawingPoint?> points;

  DrawingPainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        paint.color = points[i]!.color;
        paint.strokeWidth = points[i]!.strokeWidth;

        switch (points[i]!.brushType) {
          case 'pen':
            paint.strokeCap = StrokeCap.round;
            break;
          case 'pencil':
            paint.strokeWidth = points[i]!.strokeWidth / 2;
            paint.strokeCap = StrokeCap.square;
            break;
          case 'thick':
            paint.strokeWidth = points[i]!.strokeWidth * 2;
            break;
        }

        canvas.drawLine(points[i]!.point, points[i + 1]!.point, paint);
      }
    }
  }

  @override
  bool shouldRepaint(DrawingPainter oldDelegate) => true;
}


