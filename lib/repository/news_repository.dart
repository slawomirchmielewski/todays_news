import 'package:http/http.dart' as http;

class NewsRepository {
  final baseUrl = "https://newsapi.org/v2/everything?q=bitcoin";

  Future<http.Response> fetchNews({String page, String q, String data}) {
    return http.get(
        "https://newsapi.org/v2/everything?q=$q&page=$page&from=$data&to=$data&sortBy=popularity&language=en&apiKey=60081237c6554a58b073e2ffc8310c90");
  }
}
