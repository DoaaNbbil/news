import 'package:flutter/material.dart';
import 'package:news/categories/category_items.dart';
import 'package:news/models/category_models.dart';

class CategoryView extends StatelessWidget {
  CategoryView({required this.onSelectedCategroy});
  void Function(CategoryModels) onSelectedCategroy;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16, right: 16, left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Good Morning\nHere is Some News For You',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.only(top: 16),
              itemBuilder: (_, index) => GestureDetector(
                onTap: () {
                  onSelectedCategroy(CategoryModels.categories[index]);
                },
                child: CategoryItems(CategoryModels.categories[index]),
              ),
              separatorBuilder: (_, _) => SizedBox(height: 16),
              itemCount: CategoryModels.categories.length,
            ),
          ),
        ],
      ),
    );
  }
}
