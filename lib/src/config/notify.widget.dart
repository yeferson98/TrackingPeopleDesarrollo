import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LayoutModel with ChangeNotifier {
  Widget _currentPage;
  SharedPreferences _preferences;
  bool _loggendIn = false;
  LayoutModel() {
    _verifyAuthUser();
  }
  bool isLoggedIn() => _loggendIn;
  void _verifyAuthUser() async {
    _preferences = await SharedPreferences.getInstance();
    if (_preferences.containsKey('isLoggedInUser')) {
      _loggendIn = true;
      notifyListeners();
    } else {
      _loggendIn = false;
    }
  }

  set currentPage(Widget page) {
    this._currentPage = page;
    notifyListeners();
  }

  Widget get currentPageView => this._currentPage;
}
