import 'dart:ui';
import 'package:hive/hive.dart';

part 'drawing_point.g.dart';

@HiveType(typeId: 1)
class DrawingPoint {
  @HiveField(0)
  Offset point; 

  @HiveField(1)
  Color color;

  @HiveField(2)
  double strokeWidth;

  @HiveField(3)
  String brushType;

  DrawingPoint({
    required this.point,
    required this.color,
    required this.strokeWidth,
    required this.brushType,
  });
}
