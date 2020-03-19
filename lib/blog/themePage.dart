import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_app/redux/appState.dart';
import 'package:my_app/redux/themeRedux.dart';
import 'package:my_app/theme/materialColor.dart';

class ThemePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("设置主题"),
      ),
      body: StoreConnector<AppState, ThemeData>(
        converter: (store) => store.state.themeData,
        builder: (context, themeData) {
          return ListView(
            children: AppColors.getThemeListColor().map((color) {
              return GestureDetector(
                onTap: () {
                  StoreProvider.of<AppState>(context).dispatch(
                      RefreshThemeDataAction(ThemeData(primaryColor: color)));
//                  if (AppEvent.event != null) {
//                    AppEvent.event.fire(ThemeChangeNotification(color: color));
//                  }
                },
                child: Container(
                  padding: EdgeInsets.only(left: 15, top: 10, bottom: 10 , right: 15),
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        width: 40,
                        height: 40,
                        color: color,
                        child:
                            Text(themeData.primaryColor == color ? "当前" : ""),
                      ),
                      Expanded(
                        child: Text(""),
                      ),
                      Text('RGB色值(${color.red} - ${color.green} - ${color.blue})'),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
