import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:segcov/src/config/app_config.dart' as config;

class ThemeAplication with ChangeNotifier {
  SharedPreferences _preferenceTheme;
  ThemeData _currentTheme = ThemeData();
  ThemeData get currentTheme => this._currentTheme;
  ThemeAplication() {
    verifytheme();
  }
  void verifytheme() async {
    _preferenceTheme = await SharedPreferences.getInstance();
    if (_preferenceTheme.containsKey('themeApp')) {
      valueTheme(2);
    } else {
      valueTheme(1);
    }
  }

  void valueTheme(int theme) {
    switch (theme) {
      case 1:
        _currentTheme = liteTheme;
        notifyListeners();
        break;
      case 2:
        _currentTheme = darkTheme;
        notifyListeners();
        break;
      default:
        _currentTheme = darkTheme;
        notifyListeners();
    }
  }

  final liteTheme = ThemeData(
    fontFamily: 'NotoSansTc',
    primaryColor: Colors.white,
    brightness: Brightness.light,
    accentColor: config.Colors().mainColor(1),
    focusColor: config.Colors().accentColor(1),
    hintColor: config.Colors().secondColor(1),
    textTheme: TextTheme(
      button: TextStyle(color: Colors.white),
      headline1:
          TextStyle(fontSize: 20.0, color: config.Colors().secondColor(1)),
      headline2: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: config.Colors().secondColor(1)),
      headline3: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          color: config.Colors().secondColor(1)),
      headline4: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w700,
          color: config.Colors().mainColor(1)),
      headline5: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w300,
          color: config.Colors().secondColor(1)),
      subtitle1: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w500,
          color: config.Colors().secondColor(1)),
      headline6: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: config.Colors().mainColor(1)),
      bodyText1:
          TextStyle(fontSize: 12.0, color: config.Colors().secondColor(1)),
      bodyText2: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
          color: config.Colors().secondColor(1)),
      caption:
          TextStyle(fontSize: 12.0, color: config.Colors().secondColor(0.6)),
    ),
  );

  final darkTheme = ThemeData(
    fontFamily: 'NotoSansTc',
    primaryColor: Color(0xFF252525),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xFF2C2C2C),
    accentColor: config.Colors().mainDarkColor(1),
    hintColor: config.Colors().secondDarkColor(1),
    focusColor: config.Colors().accentDarkColor(1),
    textTheme: TextTheme(
      button: TextStyle(color: Color(0xFF252525)),
      headline1:
          TextStyle(fontSize: 20.0, color: config.Colors().secondDarkColor(1)),
      headline2: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: config.Colors().secondDarkColor(1)),
      headline3: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          color: config.Colors().secondDarkColor(1)),
      headline4: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w700,
          color: config.Colors().mainDarkColor(1)),
      headline5: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w300,
          color: config.Colors().secondDarkColor(1)),
      subtitle1: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w500,
          color: config.Colors().secondDarkColor(1)),
      headline6: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: config.Colors().mainDarkColor(1)),
      bodyText1:
          TextStyle(fontSize: 12.0, color: config.Colors().secondDarkColor(1)),
      bodyText2: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
          color: config.Colors().secondDarkColor(1)),
      caption: TextStyle(
          fontSize: 12.0, color: config.Colors().secondDarkColor(0.7)),
    ),
  );
}
