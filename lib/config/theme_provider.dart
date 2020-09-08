import 'package:flutter/material.dart';

///
/// This class will provide the themes for the application
/// depends from the settings will return light or dark theme
///
class ThemeProvider {
  // Return light theme
  static ThemeData getLightTheme(BuildContext context) {
    return ThemeData.light().copyWith(
        primaryColor: Colors.black,
        accentColor: Colors.black,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.black,
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          shape: CircularNotchedRectangle(),
        ),
        appBarTheme: AppBarTheme(
          brightness: Brightness.light,
          color: Colors.white,
          textTheme: Theme.of(context).textTheme,
          iconTheme: Theme.of(context).iconTheme,
          actionsIconTheme: Theme.of(context).iconTheme,
          centerTitle: true,
        ),
        bottomSheetTheme: BottomSheetThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15),
            ),
          ),
        ),
        dividerTheme: DividerThemeData(space: 32, thickness: 1),
        dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
        ));
  }

  // Return dark theme
  static ThemeData getDarkTheme(BuildContext context) {
    return ThemeData.dark().copyWith(
        primaryColor: Colors.white,
        accentColor: Colors.white,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.white,
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          shape: CircularNotchedRectangle(),
        ),
        appBarTheme: AppBarTheme(
          brightness: Brightness.dark,
          color: Colors.grey[800],
          centerTitle: true,
        ),
        bottomSheetTheme: BottomSheetThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15),
            ),
          ),
        ),
        dividerTheme: DividerThemeData(space: 32, thickness: 1),
        dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
        ));
  }
}
