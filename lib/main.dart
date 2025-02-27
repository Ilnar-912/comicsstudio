import 'package:comicsstudio/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'core/app.dart';
import 'package:provider/provider.dart';

import 'features/draw/providers/function.dart';

void main() async {
  await AppRouter.initialize();
  runApp(
    MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (context) => FunctionDraw()),
      ],
      child: const App(),
    )
  );
}