import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todays_news/bloc/settings_bloc/settings_bloc.dart';
import 'package:todays_news/utils/languages.dart';
import 'package:todays_news/utils/theme_converter.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
        if (state is SettingsStateLoaded) {
          return Column(
            children: [
              ListTile(
                leading: Icon(Icons.brightness_medium),
                title: Text("Theme"),
                subtitle: Text(ThemeConverter.themeToString(state.themeMode)),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RadioListTile(
                              title: Text("Light"),
                              value: "light",
                              groupValue:
                                  ThemeConverter.themeToString(state.themeMode),
                              onChanged: (value) {
                                context
                                    .bloc<SettingsBloc>()
                                    .add(SettingsEventSetTheme(theme: value));
                                Navigator.of(context).pop();
                              }),
                          RadioListTile(
                              title: Text("Dark"),
                              value: "dark",
                              groupValue:
                                  ThemeConverter.themeToString(state.themeMode),
                              onChanged: (value) {
                                context
                                    .bloc<SettingsBloc>()
                                    .add(SettingsEventSetTheme(theme: value));
                                Navigator.of(context).pop();
                              }),
                          RadioListTile(
                              title: Text("System"),
                              value: "system",
                              groupValue:
                                  ThemeConverter.themeToString(state.themeMode),
                              onChanged: (value) {
                                context
                                    .bloc<SettingsBloc>()
                                    .add(SettingsEventSetTheme(theme: value));
                                Navigator.of(context).pop();
                              }),
                        ],
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.language),
                title: Text("News Language"),
                subtitle: Text(state.newsLanguage),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                            child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: SingleChildScrollView(
                            child: Column(
                              children: Languages.getLanguages()
                                  .entries
                                  .map((e) => RadioListTile(
                                      title: Text(e.key),
                                      value: e.value,
                                      groupValue: state.newsLanguage,
                                      onChanged: (value) {
                                        context.bloc<SettingsBloc>().add(
                                            SettingsEventSetNewsLanguage(
                                                language: value));
                                        Navigator.of(context).pop();
                                      }))
                                  .toList(),
                            ),
                          ),
                        ));
                      });
                },
              )
            ],
          );
        }

        return Container();
      }),
    );
  }
}
