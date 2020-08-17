import 'package:flutter/material.dart';
import 'package:todays_news/config/dims.dart';
import 'package:todays_news/model/news.dart';
import 'package:todays_news/screen/news_screen.dart';
import 'package:todays_news/widget/news_list_tile.dart';

class NewsList extends StatelessWidget {
  final List<News> newses;
  final ScrollController scrollController;
  final VoidCallback onListEndScroll;

  NewsList({this.newses, this.scrollController, this.onListEndScroll})
      : assert(newses != null);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          onListEndScroll();
        }
        return false;
      },
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: Dims.small,
          vertical: Dims.medium,
        ),
        itemCount: newses.length,
        itemBuilder: (context, index) => NewsListTile(
          news: newses[index],
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => NewsScreen(
                  news: newses[index],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
