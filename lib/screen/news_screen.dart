import 'package:flutter/material.dart';
import 'package:share/share.dart';
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
        title: Text(
          widget.news.url,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        centerTitle: false,
        actions: [
          IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                Share.share(widget.news.url);
              })
        ],
      ),
      body: Column(
        children: [
          if (_isLoading)
            LinearProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          Expanded(
            child: WebView(
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
          ),
        ],
      ),
    );
  }
}
