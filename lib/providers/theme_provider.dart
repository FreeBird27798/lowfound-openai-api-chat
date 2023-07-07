import 'package:flutter/material.dart';
import 'package:lowfound_openai_api_chat/constants/constants.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode getThemeMode() => _themeMode;

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  ThemeData getLightTheme() {
    return ThemeData(
      cardColor: cardColor,
      primaryColor: Colors.blue,
      fontFamily: 'Roboto',
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(color: blueColor),
      iconTheme: IconThemeData(color: greyColor),
      canvasColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.white,
          filled: true,
          hintStyle: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Roboto',
          )),
      textTheme: TextTheme(
        titleLarge: TextStyle(fontSize: 24.0, color: Colors.black),
        titleMedium: TextStyle(fontSize: 20.0, color: Colors.black),
        titleSmall: TextStyle(fontSize: 16.0, color: Colors.black),
        bodyLarge: TextStyle(fontSize: 24.0, color: Colors.black),
        bodyMedium: TextStyle(fontSize: 20.0, color: Colors.black),
        bodySmall: TextStyle(fontSize: 16.0, color: Colors.black),
        displayLarge: TextStyle(fontSize: 24.0, color: Colors.black),
        displayMedium: TextStyle(fontSize: 20.0, color: Colors.black),
        displaySmall: TextStyle(fontSize: 16.0, color: Colors.black),
        labelLarge: TextStyle(fontSize: 24.0, color: Colors.black),
        labelMedium: TextStyle(fontSize: 20.0, color: Colors.black),
        labelSmall: TextStyle(fontSize: 16.0, color: Colors.black),
      ),
    );
  }

  ThemeData getDarkTheme() {
    return ThemeData(
      cardColor: greyColor,
      primaryColor: Colors.black,
      fontFamily: 'Roboto',
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      appBarTheme: AppBarTheme(color: greyColor),
      iconTheme: IconThemeData(color: Colors.white),
      canvasColor: greyColor,
      inputDecorationTheme: InputDecorationTheme(
          fillColor: greyColor,
          filled: true,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Roboto',
          )),
      textTheme: TextTheme(
        titleLarge: TextStyle(fontSize: 24.0, color: Colors.white),
        titleMedium: TextStyle(fontSize: 20.0, color: Colors.white),
        titleSmall: TextStyle(fontSize: 16.0, color: Colors.white),
        bodyLarge: TextStyle(fontSize: 24.0, color: Colors.white),
        bodyMedium: TextStyle(fontSize: 20.0, color: Colors.white),
        bodySmall: TextStyle(fontSize: 16.0, color: Colors.white),
        displayLarge: TextStyle(fontSize: 24.0, color: Colors.white),
        displayMedium: TextStyle(fontSize: 20.0, color: Colors.white),
        displaySmall: TextStyle(fontSize: 16.0, color: Colors.white),
        labelLarge: TextStyle(fontSize: 24.0, color: Colors.white),
        labelMedium: TextStyle(fontSize: 20.0, color: Colors.white),
        labelSmall: TextStyle(fontSize: 16.0, color: Colors.white),
      ),
    );
  }
}
