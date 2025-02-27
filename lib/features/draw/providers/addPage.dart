import 'package:flutter/material.dart';

class addPage with ChangeNotifier {
  
  final List<Widget> _comicCells = [];
  List get comicCells => _comicCells;
  
  addpage() {
    comicCells.add(Positioned(
      left: 50.0,
      top: 50.0,
      child: GestureDetector(
        onPanUpdate: (details) {
          notifyListeners();
          // Логика для перетаскивания
        },
        child: Container(
          width: 150,
          height: 150,
          color: Colors.blue,
          child: const Center(child: Text('Page')),
        ),
      ),
    ));
    return 0;
  }
}