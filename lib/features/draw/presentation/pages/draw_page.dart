import 'package:comicsstudio/core/router/app_router.dart';
import 'package:flutter/material.dart';
// import 'dart:ui' as ui;

import 'package:provider/provider.dart';

import '../../providers/function.dart';

class DrawPage extends StatelessWidget {
const DrawPage({ super.key });

  get addPage => null;
  
  get saveComic => null;

  @override
  Widget build(BuildContext context){

  Provider.of<FunctionDraw>(context);

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
            onPressed: addPage,
          ),
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: saveComic,
          ),
        ],
      ),
    );
  }
}