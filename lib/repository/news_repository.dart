import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todays_news/model/news.dart';

class NewsRepository {
  final _newsBaseUrl = "https://api.currentsapi.services/v1/latest-news";
  final _searchBaseUrl = "https://api.currentsapi.services/v1/search";
  final _key = "Nkf5Nf49H3cqu0NMrprQAxSZb1aqwi0l6GdfDdAAMLLf6NfX";

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
