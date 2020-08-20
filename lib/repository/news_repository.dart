import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todays_news/model/news.dart';

class NewsRepository {
  final baseUrl = "https://newsapi.org/v2/everything?q=bitcoin";

  Future<List<News>> fetchNews({String page, String q, String data}) async {
    try {
      var response = await http.get(
          "https://newsapi.org/v2/everything?q=$q&page=$page&from=$data&to=$data&sortBy=popularity&language=en&apiKey=60081237c6554a58b073e2ffc8310c90");

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body)["articles"] as List;

        List<News> newses = result.map((e) => News.fromJson(e)).toList();
        return newses;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }

    return Future.value();
  }
}
