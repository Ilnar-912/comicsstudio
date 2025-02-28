import 'package:flutter/material.dart';

class Bubble {
  final ImageProvider image;
  final Offset position;
  final double width;
  final double height;
  String? text;

  Bubble({
    required this.image,
    required this.position,
    required this.width,
    required this.height,
    this.text,
  });
}