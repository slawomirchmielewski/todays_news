import 'package:flutter/material.dart';
import 'package:todays_news/config/dims.dart';
import 'package:todays_news/model/news.dart';
import 'package:todays_news/screen/news_screen.dart';
import 'package:todays_news/widget/news_card.dart';

class NewsList extends StatelessWidget {
  final List<News> newses;
  final ScrollController scrollController;
  final VoidCallback onListEndScroll;
  final bool scrollable;

  NewsList({
    this.newses,
    this.scrollController,
    this.onListEndScroll,
    this.scrollable = true,
  }) : assert(newses != null);

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
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(
          horizontal: Dims.small,
          vertical: Dims.small,
        ),
        physics: scrollable == true
            ? AlwaysScrollableScrollPhysics()
            : NeverScrollableScrollPhysics(),
        itemCount: newses.length,
        itemBuilder: (context, index) => NewsCard(
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
