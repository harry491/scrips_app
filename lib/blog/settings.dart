import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_app/components/person_info_component.dart';
import 'package:my_app/model/user.dart';
import 'package:my_app/router/NavigatorUtils.dart';
import 'package:my_app/theme/materialColor.dart';

class Setting extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SettingState();
  }
}

class SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("设置"),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 0.5,
            color: Colors.black12,
          ),
          PersonInfoComponent(
            "设置主题",
            60,
            right: null,
            click: true,
            callback: () {
              NavigatorUtils.goThemePage(context);
            },
          ),
          Container(
            height: 0.5,
            color: Colors.black12,
          ),
          PersonInfoComponent(
            "版本信息",
            60,
            right: Text(
              "v1.0.0",
              style: grayTitleFontStyle,
            ),
            click: false,
            callback: () {
              NavigatorUtils.goThemePage(context);
            },
          ),
          Container(
            height: 0.5,
            color: Colors.black12,
          ),
          Container(
              height: 100,
              padding: EdgeInsets.only(left: 30, right: 30, top: 50),
              child: RaisedButton(
                onPressed: () {
                  UserUtils.setUserToken("");
                  NavigatorUtils.goLoginPage(context);
                },
                color: blueColor,
                child: Container(
                  margin: EdgeInsets.all(0),
                  alignment: Alignment.center,
                  child: Text(
                    "退出登录",
                    style: bigButtonStyle,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
