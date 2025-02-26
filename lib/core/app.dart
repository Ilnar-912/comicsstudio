import 'package:comicsstudio/core/utils/theme_utils.dart';
import 'package:flutter/material.dart';

import 'router/app_router.dart';

class App extends StatelessWidget {
  const App({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationProvider: AppRouter.router.routeInformationProvider,
      routeInformationParser: AppRouter.router.routeInformationParser,
      routerDelegate: AppRouter.router.routerDelegate,
      title: "Comics Studio",
      theme: createTheme(
        context, 
        const Color.fromARGB(255, 128, 128, 225), 
        Brightness.light
      ),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1),
          ),
          child: child ?? const SizedBox(),
        );
      }
    );
  }
}