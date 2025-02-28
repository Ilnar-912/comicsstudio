import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'core/router/app_router.dart';
import 'features/drawing/domain/models/color_adapter.dart';
import 'features/drawing/domain/models/drawing_point.dart';
import 'features/drawing/domain/models/offset_adapter.dart';
import 'features/home/domain/models/comic.dart';
import 'features/home/providers/comic_provider.dart';
import 'core/app.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppRouter.initialize();

  await Hive.initFlutter();
  Hive.registerAdapter(ComicAdapter());
  Hive.registerAdapter(DrawingPointAdapter());
  Hive.registerAdapter(OffsetAdapter());
  Hive.registerAdapter(ColorAdapter()); 
  
  runApp(
    MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (context) => ComicProvider()),
      ],
      child: const App(),
    )
  );
}