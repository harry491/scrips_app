import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.grey,
  Colors.red,
];

class Global {
  // 屏幕宽度
  static double screenWidth;
  /// 屏幕高度
  static double screenHeight;
  /// 状态栏高度
  static double statusBarHeight;
  /// 底部高度
  static double safeButtomHeight;


  // 可取按的主题列表
  static SharedPreferences _prefs;

  String theme = 'red';
}

class GlobalModel extends Global with ChangeNotifier {
  Future $setTheme(playload) async {
    theme = playload;
    notifyListeners();
  }
}
