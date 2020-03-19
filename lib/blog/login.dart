import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_app/http/dartHttp.dart';
import 'package:my_app/model/user.dart';
import 'package:my_app/model/user_model_entity.dart';
import 'package:my_app/redux/appState.dart';
import 'package:my_app/redux/userRedux.dart';
import 'package:my_app/router/NavigatorUtils.dart';
import 'package:my_app/router/application.dart';
import 'package:my_app/router/router.dart';
import 'package:my_app/theme/materialColor.dart';
import 'package:my_app/utils/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginState();
  }
}

class LoginState extends State<Login> {
  // 账户
  var account = "";

  // 密码
  var password = "";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: appBackground,
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            child: new Row(
              children: <Widget>[
                Text(
                  "登录",
                  style: titleStyle,
                ),
              ],
            ),
            padding: EdgeInsets.fromLTRB(30, 150, 15, 10),
          ),
          new Container(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: TextField(
                style: inputStyle,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "邮箱",
                  hintStyle: placeStyle,
                ),
                onChanged: (value) {
                  setState(() {
                    account = value;
                  });
                },
                cursorColor: Colors.red,
              )),
          new Container(
            color: Colors.white10,
            height: 1,
            margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
          ),
          new Container(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: TextField(
                style: inputStyle,
                obscureText: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "输入密码",
                  hintStyle: placeStyle,
                ),
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                cursorColor: Colors.red,
              )),
          new Container(
            color: Colors.white10,
            height: 1,
            margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
          ),
          new Container(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new FlatButton(
                  child: Text(
                    "没有账号,去注册",
                    style: buttonStyle,
                  ),
                  onPressed: () {
                    NavigatorUtils.goRegisterPage(context);
                  },
                ),
                new FlatButton(
                  child: Text("忘记密码", style: buttonStyle),
                  onPressed: () {
                    NavigatorUtils.goForgetPasswordPage(context);
                  },
                ),
              ],
            ),
          ),
          new Container(
              padding: EdgeInsets.fromLTRB(30, 20, 30, 10),
              height: 80,
              child: Builder(
                builder: (ctx) {
                  return RaisedButton(
                    color: blueColor,
                    child: Container(
                      margin: EdgeInsets.all(0),
                      alignment: Alignment.center,
                      child: Text(
                        "登录",
                        style: bigButtonStyle,
                      ),
                    ),
                    onPressed: () async {
                      if (account.length == 0) {
                        Fluttertoast.showToast(msg: "请输入用户名");
                        return;
                      }

                      if (Utils.isEmail(account) == false) {
                        Fluttertoast.showToast(msg: "请输入正确的邮箱格式");
                        return;
                      }

                      if (password.length == 0) {
                        Fluttertoast.showToast(msg: "请输入密码");
                        return;
                      }

                      FocusScope.of(context).requestFocus(FocusNode());

                      var userModel = await HttpUtils.login(context,
                          params: {"account": account, "password": password});
                      if (userModel.code == "200") {
                        StoreProvider.of<AppState>(context)
                            .dispatch(UserThemeDataAction(userModel));
                        UserUtils.setUserToken(userModel.user.token);
                        UserUtils.setUserInfo(userModel);
                        NavigatorUtils.goHomePage(context);
                      } else {
                        Fluttertoast.showToast(msg: userModel.msg);
                      }
                    },
                  );
                },
              ))
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
