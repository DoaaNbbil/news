import 'package:flutter/material.dart';
import 'package:news/models/source_models.dart';

class NewsTab extends StatelessWidget {
  NewsTab({required this.source, required this.isSelected});
  SourceModels source;
  bool isSelected;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Text(
      '${source.name}',
      style: isSelected ? textTheme.titleMedium : textTheme.titleSmall,
    );
  }
}
