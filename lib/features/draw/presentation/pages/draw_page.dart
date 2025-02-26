import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class DrawPage extends StatelessWidget {
const DrawPage({ super.key });

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: IconButton
        (onPressed: () {}, 
        icon: const Icon(Icons.arrow_back_ios_new)
        ),
        title: const Text("Comic Creator"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addPage,
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveComic,
          ),
        ],
      ),
    );
  }
}