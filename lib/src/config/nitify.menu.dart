import 'package:flutter/material.dart';

// ignore: unused_element
class MenuModel with ChangeNotifier {
  bool _mostrar = true;
  bool get mostrar => this._mostrar;

  set mostrar(bool valor) {
    this._mostrar = valor;
    notifyListeners();
  }
}
