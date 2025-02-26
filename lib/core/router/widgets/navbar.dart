import 'package:flutter/material.dart';

import '../app_router.dart';

class NavBar extends StatelessWidget {
  const NavBar({ 
    super.key, 
    required this.child
  });

  final Widget child;

  @override
  Widget build(BuildContext context){
    int selectedIndex = AppRouter.router
        .routerDelegate.currentConfiguration.fullPath == "/home" ? 0 : 1;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: child,
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          if(index ==  0) {
            AppRouter.router.go('/home');
          }
          else if(index == 1) {
            AppRouter.router.go('/notes');
          }
        },
        selectedIndex: selectedIndex,
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.home_outlined),
            icon: Icon(Icons.home),
            label: 'Home'
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.architecture_outlined),
            icon: Icon(Icons.architecture), 
            label: "Work",
          ),  
        ],
      ),
    );
  }
}