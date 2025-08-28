import 'package:flutter/material.dart';
import 'package:news/api/api_service.dart';
import 'package:news/models/news_responces/news.dart';
import 'package:news/models/sources_responces/source.dart';
import 'package:news/models/sources_responces/source_respons.dart';
import 'package:news/news/nwes_tabe.dart';
import 'package:news/uitls/colorsapp.dart';
import 'package:news/news/news_items.dart';
import 'package:news/widget/error_indicator.dart';
import 'package:news/widget/loading_indicator.dart';

class NewsView extends StatefulWidget {
  NewsView({required this.idCategory});
  String idCategory;

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  int currentIndex = 0;
  List<News> newsList = [];
  int _page = 1;
  bool _isLoadingMore = false;
  final ScrollController _scrollController = ScrollController();

  late Future<SourceRespons> getSourceFuture = ApiService.getSources(
    widget.idCategory,
  );

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !_isLoadingMore) {
        _loadMoreNews();
      }
    });
  }

  Future<void> _fetchNews(String sourceId, {bool reset = false}) async {
    try {
      if (reset) {
        _page = 1;
        newsList.clear();
      }
      final response = await ApiService.getNews(sourceId, page: _page);
      if (response.status == "ok") {
        setState(() {
          newsList.addAll(response.newsList);
          _page++;
        });
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> _loadMoreNews() async {
    if (_isLoadingMore) return;
    setState(() => _isLoadingMore = true);
    await _fetchNews(_currentSourceId());
    setState(() => _isLoadingMore = false);
  }

  Future<void> _refreshNews() async {
    await _fetchNews(_currentSourceId(), reset: true);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("The news has been updated✅ ")));
  }

  String _currentSourceId() {
    return _sources[currentIndex].id!;
  }

  List<Source> _sources = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getSourceFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingIndicator();
        } else if (snapshot.hasError || snapshot.data?.status != 'ok') {
          return ErrorIndicator();
        }
        _sources = snapshot.data?.sources ?? [];

        if (newsList.isEmpty) {
          _fetchNews(_sources[currentIndex].id!, reset: true);
        }

        return Column(
          children: [
            DefaultTabController(
              length: _sources.length,
              child: TabBar(
                tabAlignment: TabAlignment.start,
                labelPadding: EdgeInsetsDirectional.only(start: 16),
                dividerColor: Colors.transparent,
                indicatorColor: Colorsapp.white,
                isScrollable: true,
                tabs: _sources
                    .map(
                      (source) => NewsTab(
                        source: source,
                        isSelected: currentIndex == _sources.indexOf(source),
                      ),
                    )
                    .toList(),
                onTap: (index) {
                  if (currentIndex == index) return;
                  setState(() {
                    currentIndex = index;
                    newsList.clear();
                  });
                  _fetchNews(_sources[currentIndex].id!, reset: true);
                },
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshNews,
                child: ListView.separated(
                  controller: _scrollController,
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.only(top: 16, right: 16, left: 16),
                  itemBuilder: (_, index) {
                    if (index < newsList.length) {
                      return NewsItems(newsList[index]);
                    } else {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  },
                  separatorBuilder: (_, __) => SizedBox(height: 16),
                  itemCount: newsList.length + (_isLoadingMore ? 1 : 0),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
