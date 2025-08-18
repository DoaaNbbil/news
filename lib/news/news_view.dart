import 'package:flutter/material.dart';
import 'package:news/colorsapp.dart';
import 'package:news/models/source_models.dart';
import 'package:news/news/news_items.dart';
import 'package:news/news/news_tab.dart';

class NewsView extends StatefulWidget {
  NewsView({super.key});

  @override
  State<NewsView> createState() => _NewsViewState();
}

List<SourceModels> sources = List.generate(
  10,
  (index) => SourceModels(id: '$index', name: 'Source $index'),
);
int currentIndex = 0;

class _NewsViewState extends State<NewsView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultTabController(
          length: sources.length,
          child: TabBar(
            tabAlignment: TabAlignment.start,
            labelPadding: EdgeInsetsDirectional.only(start: 16),
            dividerColor: Colors.transparent,
            indicatorColor: Colorsapp.white,
            isScrollable: true,
            tabs: sources
                .map(
                  (source) => NewsTab(
                    source: source,
                    isSelected: currentIndex == sources.indexOf(source),
                  ),
                )
                .toList(),
            onTap: (index) {
              if (currentIndex == index) return;
              currentIndex = index;
              setState(() {});
            },
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.only(top: 16, right: 16, left: 16),
            itemBuilder: (_, index) => NewsItems(),
            separatorBuilder: (_, _) => SizedBox(height: 16),
            itemCount: 10,
          ),
        ),
      ],
    );
  }
}
