import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppThemeProvider extends ChangeNotifier{
bool isDark=false;
  void changeAppTheme(bool value){
    if(isDark==value) return;
    isDark=value;
    notifyListeners();
  }
}