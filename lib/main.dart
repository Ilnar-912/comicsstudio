import 'package:comicsstudio/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'core/app.dart';

void main() async {
  await AppRouter.initialize();
  runApp(const App());
}