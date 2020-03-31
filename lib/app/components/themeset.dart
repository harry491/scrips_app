import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_app/redux/appState.dart';
import 'package:my_app/redux/themeRedux.dart';
import 'package:my_app/app//theme/materialColor.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ThemeSet extends StatelessWidget {
  List colors = AppColors.getThemeListColor();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    Widget _themeItem(Color color) {
      return GestureDetector(
        onTap: () {
          print(color);
          StoreProvider.of<AppState>(context)
              .dispatch(new RefreshThemeDataAction(ThemeData(
            primaryColor: color,
          )));
        },
        child: Container(
          color: color,
          padding: EdgeInsets.all(10),
          child: Text(""),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("设置主题"),
      ),
      body: ListView(
        itemExtent: 60,
        children: colors.map((color) {
          return _themeItem(color);
        }).toList(),
      ),
    );
  }
}
