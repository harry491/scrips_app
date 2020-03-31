import 'package:flutter/material.dart';
import 'package:my_app/redux/themeRedux.dart';
import 'package:my_app/utils/Utils.dart';
import 'package:redux/redux.dart';

Color appBackground = Utils.hexColor(0x131B2F);
Color titleColor = Utils.hexColor(0xB8C0CF);
Color placeColor = Utils.hexColor(0x575B6A);
Color blueColor = Utils.hexColor(0x6FBEFA);

/// 标题样式
TextStyle titleStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: titleColor);

/// 输入框站位
TextStyle placeStyle =
    TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: placeColor);

/// 输入字符
TextStyle inputStyle =
    TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: titleColor);

/// 按钮标题
TextStyle buttonStyle =
    TextStyle(fontSize: 13, fontWeight: FontWeight.normal, color: blueColor);

/// 大按钮标题
TextStyle bigButtonStyle =
    TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white);

TextStyle normalFontStyle = TextStyle(
    fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black87);

TextStyle smallFontStyle = TextStyle(
    fontSize: 13, fontWeight: FontWeight.normal, color: Colors.black87);

TextStyle bigFontStyle =
    TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87);

TextStyle titleFontStyle = TextStyle(
    fontSize: 18, fontWeight: FontWeight.normal, color: Colors.black87);

TextStyle grayTitleFontStyle = TextStyle(
    fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black54);

class AppColors {
  static const int primaryValue = 0xFF24292E;
  static const int primaryLightValue = 0xFF42464b;
  static const int primaryDarkValue = 0xFF121917;

  static const MaterialColor primarySwatch = const MaterialColor(
    primaryValue,
    const <int, Color>{
      50: const Color(primaryLightValue),
      100: const Color(primaryLightValue),
      200: const Color(primaryLightValue),
      300: const Color(primaryLightValue),
      400: const Color(primaryLightValue),
      500: const Color(primaryValue),
      600: const Color(primaryDarkValue),
      700: const Color(primaryDarkValue),
      800: const Color(primaryDarkValue),
      900: const Color(primaryDarkValue),
    },
  );

  static List<Color> getThemeListColor() {
    return [
      AppColors.primarySwatch,
      Colors.brown,
      appBackground,
      Colors.blue,
      Colors.teal,
      Colors.amber,
      Colors.blueGrey,
      Colors.deepOrange,
    ];
  }

  static pushTheme(Store store, int index) {
    ThemeData themeData;
    List<Color> colors = getThemeListColor();
    themeData = getThemeData(colors[index]);
    store.dispatch(new RefreshThemeDataAction(themeData));
  }

  static getThemeData(Color color) {
    return ThemeData(primarySwatch: color, platform: TargetPlatform.iOS);
  }
}
