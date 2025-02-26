import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
const ErrorScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      color: Colors.red,
      child: const Text('Error'),
    );
  }
}