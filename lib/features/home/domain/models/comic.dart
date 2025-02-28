import 'package:hive/hive.dart';

import '../../../drawing/domain/models/drawing_point.dart';

part 'comic.g.dart';

@HiveType(typeId: 0)
class Comic {
  @HiveField(0)
  String title;

  @HiveField(1)
  String coverImage;

  @HiveField(2)
  int pageCount;

  @HiveField(3)
  List<List<DrawingPoint?>> drawingPages;

  Comic({
    required this.title,
    this.coverImage = '',
    this.pageCount = 0,
    List<List<DrawingPoint?>>? drawingPages,
  }) : drawingPages = drawingPages ?? [];

  void savePages(String? pageImage, List<List<DrawingPoint?>> pages) {
    pageImage = pageImage;
    pageCount = pages.length;
    drawingPages = pages;
  }
}
