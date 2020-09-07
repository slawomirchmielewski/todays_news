import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:todays_news/config/dims.dart';
import 'package:todays_news/model/news.dart';

class NewsCard extends StatelessWidget {
  final News news;
  final VoidCallback onPressed;

  NewsCard({this.news, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: Dims.small),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(Dims.radius))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: news.image != null
                    ? BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(Dims.radius),
                            topLeft: Radius.circular(Dims.radius)),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(news.image),
                        ))
                    : BoxDecoration(color: Colors.blueGrey),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dims.medium, vertical: Dims.small),
                  child: Wrap(
                      children: news.category
                          .map((e) => Padding(
                                padding:
                                    const EdgeInsets.only(right: Dims.small),
                                child: Text(e.toUpperCase(),
                                    style:
                                        Theme.of(context).textTheme.overline),
                              ))
                          .toList())),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dims.medium),
                child: Text(
                  news.title,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      .copyWith(fontWeight: FontWeight.w700),
                  overflow: TextOverflow.fade,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: Dims.medium,
                    right: Dims.medium,
                    bottom: Dims.medium,
                    top: Dims.tiny),
                child: Text(
                  news.description,
                  softWrap: true,
                  style: Theme.of(context).textTheme.caption,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
