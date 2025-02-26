import 'package:flutter/material.dart';

Widget _buildImageButton(String imagePath) {
  return ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    child: Image.asset(imagePath, fit: BoxFit.cover),
  );
}
