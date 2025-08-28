import 'package:flutter/material.dart';
import 'package:news/models/sources_responces/source.dart';

class NewsTab extends StatelessWidget {
  NewsTab({required this.source, required this.isSelected});
  Source source;
  bool isSelected;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Text(
      source.name!,
      style: isSelected ? textTheme.titleMedium : textTheme.titleSmall,
    );
  }
}
