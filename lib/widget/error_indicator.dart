import 'package:flutter/material.dart';
import 'package:news/uitls/colorsapp.dart';

class ErrorIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Something want worring!',
        style: TextStyle(color: Colorsapp.white),
      ),
    );
  }
}
