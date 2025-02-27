import 'package:comicsstudio/core/router/app_router.dart';
import 'package:comicsstudio/features/draw/providers/addPage.dart';
import 'package:comicsstudio/features/draw/providers/saveComic.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:provider/provider.dart';
import '../../providers/addPage.dart';

class DrawPage extends StatelessWidget {
const DrawPage({ super.key });

  @override
  Widget build(BuildContext context){

  final add = Provider.of<addPage>(context);

  final save = Provider.of<Savecomic>(context);
  
    return Scaffold(
      appBar: AppBar(
        leading: IconButton
        (onPressed: () {
          AppRouter.router.go('/home');
        }, 
        icon: const Icon(Icons.arrow_back_ios_new)
        ),
        title: const Text("Comic Creator"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: add.addpage,
          ),
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: save.saveComic,
          ),
        ],
      ),
    );
  }
}