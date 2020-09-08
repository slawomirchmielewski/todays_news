import 'package:flutter/material.dart';
import 'package:todays_news/config/dims.dart';
import 'package:todays_news/model/news.dart';
import 'package:todays_news/screen/news_screen.dart';
import 'package:todays_news/widget/news_card.dart';

///
/// Representing news list view
///
class NewsList extends StatelessWidget {
  /// List of newses
  final List<News> newses;

  /// List scroll controller
  final ScrollController scrollController;

  NewsList({
    this.newses,
    this.scrollController,
  }) : assert(newses != null);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(
        horizontal: Dims.small,
        vertical: Dims.small,
      ),
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
    );
  }
}
