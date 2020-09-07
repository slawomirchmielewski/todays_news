import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:todays_news/config/dims.dart';
import 'package:todays_news/model/news.dart';

class NewsListTile extends StatelessWidget {
  final News news;
  final VoidCallback onPressed;

  NewsListTile({
    @required this.news,
    this.onPressed,
  }) : assert(news != null);

  @override
  Widget build(BuildContext context) {
    print(news.image);
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: news.image != null
                    ? BoxDecoration(
                        image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(news.image),
                      ))
                    : BoxDecoration(color: Colors.blueGrey),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: Dims.medium),
                        child: Wrap(
                            children: news.category
                                .map((e) => Padding(
                                      padding: const EdgeInsets.only(
                                          right: Dims.small),
                                      child: Text(e.toUpperCase(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .overline),
                                    ))
                                .toList())),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 100),
                      child: ListTile(
                        title: Text(
                          news.title,
                          maxLines: 2,
                          style:
                              TextStyle().copyWith(fontWeight: FontWeight.w700),
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          news.description,
                          softWrap: true,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        isThreeLine: false,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider()
        ],
      ),
    );
  }
}
