import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:segcov/src/config/app_config.dart' as config;

class ThemeAplication with ChangeNotifier {
  SharedPreferences _preferenceTheme;
  ThemeData _currentTheme = ThemeData();
  bool themecheck;
  ThemeData get currentTheme => this._currentTheme;
  bool get currentValueTheme => this.themecheck;
  ThemeAplication() {
    verifytheme();
  }
  void addThemeHomen() async {
    _preferenceTheme = await SharedPreferences.getInstance();
    _preferenceTheme.setBool('themeApp', true);
    verifytheme();
  }

  void removeThemeHomen() async {
    _preferenceTheme = await SharedPreferences.getInstance();
    _preferenceTheme.remove('themeApp');
    verifytheme();
  }

  void verifytheme() async {
    _preferenceTheme = await SharedPreferences.getInstance();
    if (_preferenceTheme.containsKey('themeApp')) {
      themecheck = true;
      valueTheme(2);
    } else {
      themecheck = false;
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
        _currentTheme = homenTheme;
        notifyListeners();
        break;
      default:
        _currentTheme = homenTheme;
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

  final homenTheme = ThemeData(
    fontFamily: 'NotoSansTc',
    primaryColor: Colors.white,
    brightness: Brightness.light,
    accentColor: config.ColorsHomen().mainColor(1),
    focusColor: config.ColorsHomen().accentColor(1),
    hintColor: config.ColorsHomen().secondColor(1),
    textTheme: TextTheme(
      button: TextStyle(color: Colors.white),
      headline1:
          TextStyle(fontSize: 20.0, color: config.ColorsHomen().secondColor(1)),
      headline2: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: config.ColorsHomen().secondColor(1)),
      headline3: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          color: config.ColorsHomen().secondColor(1)),
      headline4: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w700,
          color: config.ColorsHomen().mainColor(1)),
      headline5: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w300,
          color: config.ColorsHomen().secondColor(1)),
      subtitle1: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w500,
          color: config.ColorsHomen().secondColor(1)),
      headline6: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: config.ColorsHomen().mainColor(1)),
      bodyText1:
          TextStyle(fontSize: 12.0, color: config.ColorsHomen().secondColor(1)),
      bodyText2: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
          color: config.ColorsHomen().secondColor(1)),
      caption: TextStyle(
          fontSize: 12.0, color: config.ColorsHomen().secondColor(0.6)),
    ),
  );
}
