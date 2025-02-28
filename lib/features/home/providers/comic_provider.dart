import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import '../../drawing/domain/models/drawing_point.dart';
import '../domain/models/comic.dart';

class ComicProvider with ChangeNotifier {
  Box<Comic>? _comicBox;

  List<Comic> get comics {
    if (_comicBox == null) {
      return [];
    }
    return _comicBox!.values.toList();
  }

  Future<void> loadComics() async {
    _comicBox ??= await Hive.openBox<Comic>('comics');
    notifyListeners();
  }

  // Добавление нового комикса
  Future<void> addComic(String title) async {
    final newComic = Comic(title: title);
    await _comicBox?.add(newComic);
    notifyListeners();
  }

  // Удаление комикса
  Future<void> removeComic(int index) async {
    await _comicBox?.deleteAt(index);
    notifyListeners();
  }

  // Изменение названия комикса
  Future<void> updateComicTitle(int index, String newTitle) async {
    final comic = _comicBox?.getAt(index);
    if (comic != null) {
      comic.title = newTitle;
      await _comicBox?.putAt(index, comic);
      notifyListeners();
    }
  }

  // Обновление обложки
  Future<void> updateComicCover(int index, String newCoverImage) async {
    final comic = _comicBox?.getAt(index);
    if (comic != null) {
      comic.coverImage = newCoverImage;
      await _comicBox?.putAt(index, comic);
      notifyListeners();
    }
  }

  // Сохранение изменений в страницах комикса
  Future<void> saveComic(int index, List<List<DrawingPoint?>> pages) async {
    final comic = _comicBox?.getAt(index);
    if (comic != null) {
      comic.savePages(null, pages);
      await _comicBox?.putAt(index, comic);
      notifyListeners();
    }
  }

  // Закрытие коробки
  Future<void> closeBox() async {
    if (_comicBox != null) {
      await _comicBox!.close();
      _comicBox = null;
    }
  }
}
