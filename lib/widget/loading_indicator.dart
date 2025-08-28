import 'package:flutter/material.dart';
import 'package:news/uitls/colorsapp.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: Colorsapp.white));
  }
}
