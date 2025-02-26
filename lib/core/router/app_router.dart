import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/draw/presentation/pages/draw_page.dart';
import '../../features/draw/presentation/widgets/draw.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../constants/not_found_page.dart';
import 'widgets/navbar.dart';


class AppRouter {
  static late GoRouter _router;
  static GoRouter get router => _router;



  static Future<void> initialize() async {
    GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
  
    _router = GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: '/home',
      routes: [
        ShellRoute(
          builder: (context, state, child) {
            return NavBar(
              child: child
            );
          },
          routes: [
            GoRoute(
              path: '/home',
              pageBuilder: (context, state) {
                return const NoTransitionPage(child: HomePage());
              },
            ),
            GoRoute(
              path: '/notes',
              pageBuilder: (context, state) {
                return const NoTransitionPage(child: DrawPage());
              },
            ),
          ]
        ),

        // GoRoute(
        //   name: 'home',
        //   path: '/home',
        //   pageBuilder: (context, state) {
        //     return const NoTransitionPage(
        //       child: HomePage()
        //     );
        //   },
        // ),
      ],
      errorBuilder: (_, __) => const NotFoundPage(),
    );
  }
}