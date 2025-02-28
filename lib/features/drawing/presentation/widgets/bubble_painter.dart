import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../domain/models/bubble.dart';

class BubblePainter extends CustomPainter {
  final Bubble bubble;
  late ui.Image _image;

  BubblePainter({required this.bubble});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    
    _loadImage(bubble.image).then((image) {
      _image = image;

      final Rect rect = Rect.fromLTWH(0, 0, bubble.width, bubble.height);
      canvas.drawImageRect(_image, Rect.fromLTRB(0, 0, _image.width.toDouble(), _image.height.toDouble()), rect, paint);

      if (bubble.text != null) {
        final TextSpan span = TextSpan(
          text: bubble.text,
          style: const TextStyle(color: Colors.black, fontSize: 14),
        );
        final TextPainter textPainter = TextPainter(
          text: span,
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        textPainter.paint(canvas, const Offset(10, 10));
      }
    });
  }

  Future<ui.Image> _loadImage(ImageProvider imageProvider) async {
    final Completer<ui.Image> completer = Completer();
    final ImageStreamListener listener = ImageStreamListener((imageInfo, _) {
      completer.complete(imageInfo.image);
    });
    imageProvider.resolve(const ImageConfiguration()).addListener(listener);
    return completer.future;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
