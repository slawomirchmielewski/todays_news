import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todays_news/bloc/news_bloc/news_bloc.dart';
import 'package:todays_news/config/dims.dart';
import 'package:todays_news/model/news.dart';
import 'package:todays_news/screen/about_screen.dart';
import 'package:todays_news/screen/search_screen.dart';
import 'package:todays_news/screen/settings_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todays_news/view/news_list.dart';

///
/// Representing main screen where newest news are displaying
///
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    context.bloc<NewsBloc>().add(NewsEventFetchNews());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
      ),
      body: BlocBuilder<NewsBloc, List<News>>(
        builder: (context, newses) {
          if (newses == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.bloc<NewsBloc>().add(NewsEventRefreshNews());
              return await Future.delayed(Duration(seconds: 1));
            },
            child: NewsList(
              newses: newses,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SearchScreen()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: Dims.small,
        child: Row(
          children: [
            IconButton(
                icon: Icon(Icons.menu),
                onPressed: () => onMenuItemPressed(context))
          ],
        ),
      ),
    );
  }

  void onMenuItemPressed(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(
                "News",
                style: TextStyle().copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Icon(Icons.sort_by_alpha),
              title: Text("Newest first"),
              onTap: () {
                Navigator.of(context).pop();
                context.bloc<NewsBloc>().add(NewsEventSortAscendingByData());
              },
            ),
            ListTile(
              leading: Icon(Icons.sort_by_alpha),
              title: Text("Latest first"),
              onTap: () {
                Navigator.of(context).pop();
                context.bloc<NewsBloc>().add(NewsEventSortDescendingByData());
              },
            ),
            ListTile(
                leading: Icon(Icons.settings),
                title: Text("Settings"),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SettingsScreen(),
                  ));
                }),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text("About"),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AboutScreen(),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => false;
}
