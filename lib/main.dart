import 'package:flutter/material.dart';
import 'package:news/home_screen.dart';
import 'package:news/news/news_search.dart';
import 'package:news/uitls/apptheme.dart';

void main() {
  runApp(NewsApp());
}

class NewsApp extends StatelessWidget {
  NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        NewsSearch.nameRoute: (context) => NewsSearch(),
        HomeScreen.homeRoute: (context) => HomeScreen(),
      },
      initialRoute: HomeScreen.homeRoute,
      theme: Apptheme.lightTheme,
      darkTheme: Apptheme.darkTheme,
      themeMode: ThemeMode.dark,
    );
  }
}
