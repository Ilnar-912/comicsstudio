import 'package:flutter/material.dart';

import '../widgets/home.dart';

class HomePage extends StatelessWidget {
const HomePage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comics Studio'),
      ),
      body: const Home()
    );
  }
}