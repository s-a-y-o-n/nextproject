import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _darktheme = false;
  bool get isdarktheme => _darktheme;
  void switchtheme() {
    _darktheme = !_darktheme;
    notifyListeners();
  }
}
