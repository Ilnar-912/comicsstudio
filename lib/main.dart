import 'package:comicsstudio/core/router/app_router.dart';
import 'package:comicsstudio/features/draw/providers/addPage.dart';
import 'package:comicsstudio/features/draw/providers/grid.dart';
import 'package:comicsstudio/features/draw/providers/saveComic.dart';
import 'package:comicsstudio/features/draw/providers/tools.dart';
import 'package:comicsstudio/features/draw/providers/undo_redo.dart';
import 'package:flutter/material.dart';
import 'core/app.dart';
import 'package:provider/provider.dart';



void main() async {
  await AppRouter.initialize();
  runApp(
    MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (context) => addPage()),
        ChangeNotifierProvider(create: (context) => Grid()),
        ChangeNotifierProvider(create: (context) => Savecomic()),
        ChangeNotifierProvider(create: (context) => Tools()),
        ChangeNotifierProvider(create: (context) => UndoRedo()),
      ],
      child: const App(),
    )
  );
}