import 'news.dart';

class NewsResponse {
  final String status;
  final int totalResults;
  final List<News> newsList;

  NewsResponse({
    required this.status,
    required this.totalResults,
    required this.newsList,
  });

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    return NewsResponse(
      status: json['status'],
      totalResults: json['totalResults'],
      newsList: (json['articles'] as List)
          .map((e) => News.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'totalResults': totalResults,
      'articles': newsList.map((e) => e.toJson()).toList(),
    };
  }
}
