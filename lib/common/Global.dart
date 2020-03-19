import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.grey,
  Colors.red,
];


class Global{

  // 可取按的主题列表
  static SharedPreferences _prefs;

  String theme = 'red';

}

class GlobalModel extends Global with ChangeNotifier{
  Future $setTheme(playload) async {
    theme = playload;
    notifyListeners();
  }
}
