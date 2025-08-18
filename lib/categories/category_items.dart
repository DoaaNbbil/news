import 'package:flutter/material.dart';
import 'package:news/models/category_models.dart';

class CategoryItems extends StatelessWidget {
  CategoryItems(this.category);
  CategoryModels category;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(16),
      child: Image.asset(
        'assets/images/${category.imageName}.png',
        height: MediaQuery.sizeOf(context).height * 0.25,
        width: double.infinity,
        fit: BoxFit.fill,
      ),
    );
    ;
  }
}
