import 'package:flutter/material.dart';
import 'package:todays_news/config/dims.dart';
import 'package:todays_news/model/news.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsScreen extends StatefulWidget {
  final News news;

  NewsScreen({@required this.news}) : assert(news != null);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.news.title),
        actions: [
          if (_isLoading == true)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: Dims.medium),
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(strokeWidth: Dims.tiny / 2),
                ),
              ],
            )
        ],
      ),
      body: WebView(
        initialUrl: widget.news.url,
        onPageStarted: (String url) {
          print('Page started loading: $url');
          setState(() {
            _isLoading = true;
          });
        },
        onPageFinished: (String url) {
          print('Page finished loading: $url');
          setState(() {
            _isLoading = false;
          });
        },
      ),
    );
  }
}
