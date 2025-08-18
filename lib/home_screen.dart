import 'package:flutter/material.dart';
import 'package:news/categories/category_view.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  static const homeRoute = '/home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: CategoryView(),
    );
  }
}
