import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todays_news/bloc/search_bloc/search_bloc.dart';
import 'package:todays_news/config/dims.dart';
import 'package:todays_news/model/news.dart';
import 'package:todays_news/screen/news_screen.dart';
import 'package:todays_news/widget/news_list_tile.dart';
import 'package:todays_news/widget/search_bar.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SearchBloc, List<News>>(
        builder: (context, newses) => CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              automaticallyImplyLeading: true,
              floating: false,
              pinned: true,
              expandedHeight: 140,
              flexibleSpace: FlexibleSpaceBar(
                background: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(Dims.medium),
                    child: SearchBar(
                      controller: _textEditingController,
                      onTextChanged: (text) {
                        context
                            .bloc<SearchBloc>()
                            .add(SearchEventQueryNews(query: text));
                      },
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                newses
                    .map(
                      (news) => Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: Dims.medium),
                        child: NewsListTile(
                          news: news,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => NewsScreen(news: news),
                            ));
                          },
                        ),
                      ),
                    )
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
