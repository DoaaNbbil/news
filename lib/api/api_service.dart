import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/api/api_constant.dart';
import 'package:news/models/news_responces/news_response.dart';
import 'package:news/models/sources_responces/source_respons.dart';

class ApiService {
  static Future<SourceRespons> getSources(String categroyId) async {
    Uri uri = Uri.https(ApiConstant.baseUrl, ApiConstant.sourceEndPoint, {
      'apiKey': ApiConstant.apiKey,
      'category': categroyId,
    });
    http.Response response = await http.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    return SourceRespons.fromJson(json);
  }

  static Future<NewsResponse> getNews(
    String sourceId, {
    required int page,
  }) async {
    Uri uri = Uri.https(ApiConstant.baseUrl, ApiConstant.newsEndPoint, {
      'apiKey': ApiConstant.apiKey,
      'sources': sourceId,
    });
    http.Response response = await http.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    return NewsResponse.fromJson(json);
  }

  static Future<NewsResponse> searchNews(String query, {int page = 1}) async {
    Uri uri = Uri.https(ApiConstant.baseUrl, ApiConstant.newsEndPoint, {
      'apiKey': ApiConstant.apiKey,
      'q': query,
      'page': page.toString(),
      'pageSize': '20',
    });

    final response = await http.get(uri);
    final json = jsonDecode(response.body);
    return NewsResponse.fromJson(json);
  }
}
