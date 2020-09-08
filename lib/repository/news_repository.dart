import 'dart:convert';

import 'package:api_keys/api_keys.dart';
import 'package:http/http.dart' as http;
import 'package:todays_news/model/news.dart';

///
/// Represent class to retrieve the newses from the API
///
class NewsRepository {
  /// News base url
  final _newsBaseUrl = "https://api.currentsapi.services/v1/latest-news";

  /// Search news base url
  final _searchBaseUrl = "https://api.currentsapi.services/v1/search";

  /// API key reference
  final _key = ApiKeys().getNewsApiKey();

  Future<List<News>> fetchNews({String language}) async {
    try {
      var response =
          await http.get("$_newsBaseUrl?language=$language&apiKey=$_key");

      return _decodeNews(response);
    } catch (e) {
      print(e);
    }

    return Future.value();
  }

  Future<List<News>> searchNews({String query, String language}) async {
    try {
      var response = await http.get(
          "$_searchBaseUrl?keywords=$query&language=$language&apiKey=$_key");

      return _decodeNews(response);
    } catch (e) {
      print(e);
    }

    return Future.value();
  }

  List<News> _decodeNews(http.Response response) {
    List<News> newses = [];

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body)["news"] as List;

      newses = result.map((news) => News.fromJson(news)).toList();
    } else {
      print(response.statusCode);
    }
    return newses;
  }
}
