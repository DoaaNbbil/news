import 'package:flutter/material.dart';
import 'package:news/api/api_service.dart';
import 'package:news/models/news_responces/news.dart';
import 'package:news/news/news_items.dart';
import 'package:news/uitls/colorsapp.dart';
import 'package:news/widget/loading_indicator.dart';
import 'package:news/widget/error_indicator.dart';

class NewsSearch extends StatefulWidget {
  @override
  _NewsSearchState createState() => _NewsSearchState();
  static const String nameRoute = '/search';
}

class _NewsSearchState extends State<NewsSearch> {
  TextEditingController _searchController = TextEditingController();
  List<News> _searchResults = [];
  bool _isLoading = false;
  bool _hasError = false;
  bool _isLoadingMore = false;
  String _lastQuery = "";
  int _currentPage = 1;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMoreNews();
    }
  }

  Future<void> _searchNews(String query) async {
    setState(() {
      _isLoading = true;
      _hasError = false;
      _searchResults.clear();
      _currentPage = 1;
    });

    try {
      final response = await ApiService.searchNews(query, page: _currentPage);
      if (response.status == "ok") {
        setState(() {
          _searchResults = response.newsList;
          _lastQuery = query;
        });
      } else {
        setState(() {
          _hasError = true;
        });
      }
    } catch (e) {
      setState(() {
        _hasError = true;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadMoreNews() async {
    if (_isLoadingMore || _lastQuery.isEmpty) return;

    setState(() {
      _isLoadingMore = true;
    });

    _currentPage += 1;

    try {
      final response = await ApiService.searchNews(
        _lastQuery,
        page: _currentPage,
      );
      if (response.status == "ok" && response.newsList.isNotEmpty) {
        setState(() {
          _searchResults.addAll(response.newsList);
        });
      }
    } catch (_) {}

    setState(() {
      _isLoadingMore = false;
    });
  }

  Future<void> _refreshNews() async {
    if (_lastQuery.isNotEmpty) {
      await _searchNews(_lastQuery);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("The news has been updated✅")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                autofocus: true,
                textInputAction: TextInputAction.search,
                style: const TextStyle(color: Colorsapp.white),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, color: Colorsapp.grey),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colorsapp.grey),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _searchResults.clear();
                              _lastQuery = "";
                            });
                          },
                        )
                      : null,
                  hintText: "Search",
                  hintStyle: const TextStyle(color: Colorsapp.grey),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colorsapp.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colorsapp.white),
                  ),
                ),
                onSubmitted: (query) {
                  if (query.isNotEmpty) _searchNews(query);
                },
              ),
              const SizedBox(height: 12),

              Expanded(
                child: _isLoading
                    ? LoadingIndicator()
                    : _hasError
                    ? ErrorIndicator()
                    : _searchResults.isEmpty
                    ? const Center(
                        child: Text(
                          "No results found",
                          style: const TextStyle(color: Colorsapp.white),
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: _refreshNews,
                        child: ListView.separated(
                          controller: _scrollController,
                          padding: const EdgeInsets.all(16),
                          itemBuilder: (_, index) {
                            if (index < _searchResults.length) {
                              return NewsItems(_searchResults[index]);
                            } else {
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                          },
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 16),
                          itemCount:
                              _searchResults.length + (_isLoadingMore ? 1 : 0),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
