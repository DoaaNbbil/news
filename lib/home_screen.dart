import 'package:flutter/material.dart';
import 'package:news/categories/category_view.dart';
import 'package:news/drawer/drawer_home.dart';
import 'package:news/models/category_models.dart';
import 'package:news/news/news_search.dart';
import 'package:news/news/news_view.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  static const homeRoute = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CategoryModels? seclectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          seclectedCategory == null ? 'Home' : seclectedCategory!.name,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, size: 24),
            onPressed: () {
              Navigator.of(context).pushNamed(NewsSearch.nameRoute);
            },
          ),
        ],
      ),
      drawer: DrawerHome(onGoToHomeClicked: resetSelectedCategory),
      body: seclectedCategory == null
          ? CategoryView(onSelectedCategroy: onSelectedCategroy)
          : NewsView(idCategory: seclectedCategory!.id),
    );
  }

  void onSelectedCategroy(CategoryModels category) {
    seclectedCategory = category;
    setState(() {});
  }

  void resetSelectedCategory() {
    if (seclectedCategory == null) return;
    seclectedCategory = null;
    setState(() {});
  }
}
