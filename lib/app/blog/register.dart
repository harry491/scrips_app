import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_app/http/dartHttp.dart';
import 'package:my_app/router/NavigatorUtils.dart';
import 'package:my_app/router/application.dart';
import 'package:my_app/app//theme/materialColor.dart';
import 'package:my_app/utils/Utils.dart';

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegisterState();
  }
}

class RegisterState extends State<Register> {
  // 账户
  var account = "";

  // 验证码
  var code = "";

  // 密码
  var password = "";

  // 重复密码
  var rePassword = "";

  /// 按钮标题
  var title = "获取";

  /// 倒计时
  var count = 59;

  Timer countdownTimer;

  void getEmailCode() async {
    if (countdownTimer != null) {
      return;
    }

    setState(() {
      title = "59";

      countdownTimer = Timer.periodic(Duration(seconds: 1), (time) {
        count--;
        if (count == 0) {
          count = 59;
          countdownTimer.cancel();
          countdownTimer = null;
          title = "获取";
        } else {
          title = "$count";
        }
        setState(() {});
      });
    });

    var response = await HttpUtils.getEmailCode(context, params: {
      "account": account,
    });

    if (response["code"] == "200") {
      Fluttertoast.showToast(msg: "发送成功");
    } else {
      Fluttertoast.showToast(msg: response["msg"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: appBackground,
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: SafeArea(
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: titleColor,
                  size: 30,
                ),
                onPressed: () {
                  NavigatorUtils.back(context);
                },
              ),
            ),
            padding: EdgeInsets.only(left: 10),
          ),
          new Container(
            child: new Row(
              children: <Widget>[
                Text(
                  "注册",
                  style: titleStyle,
                ),
              ],
            ),
            padding: EdgeInsets.fromLTRB(30, 20, 15, 10),
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
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      obscureText: true,
                      style: inputStyle,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "验证码",
                        hintStyle: placeStyle,
                      ),
                      onChanged: (value) {
                        setState(() {
                          code = value;
                        });
                      },
                      cursorColor: Colors.red,
                    ),
                  ),
                  RaisedButton(
                    color: blueColor,
                    child: Container(
                      margin: EdgeInsets.all(0),
                      alignment: Alignment.center,
                      child: Text(
                        title,
                        style: bigButtonStyle,
                      ),
                    ),
                    onPressed: () {
                      if (!Utils.isEmail(account)) {
                        Fluttertoast.showToast(msg: "邮箱格式不正确");
                        return;
                      }
                      getEmailCode();
                    },
                  ),
                ],
              )),
          new Container(
            color: Colors.white10,
            height: 1,
            margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
          ),
          new Container(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: TextField(
                obscureText: true,
                style: inputStyle,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "密码",
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
              padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: TextField(
                obscureText: true,
                style: inputStyle,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "确认密码",
                  hintStyle: placeStyle,
                ),
                onChanged: (value) {
                  setState(() {
                    rePassword = value;
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
                    "已有账号,去登录",
                    style: buttonStyle,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
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
                        "注册",
                        style: bigButtonStyle,
                      ),
                    ),
                    onPressed: () async {
                      if (account.length == 0) {
                        Fluttertoast.showToast(msg: "请输入用户名");
                        return;
                      }

                      if (code.length == 0) {
                        Fluttertoast.showToast(msg: "请输入验证码");
                        return;
                      }

                      if (password.length == 0 || rePassword.length == 0) {
                        Fluttertoast.showToast(msg: "请输入密码");
                        return;
                      }

                      if (password != rePassword) {
                        Fluttertoast.showToast(msg: "两次密码输入不一致");
                        return;
                      }

                      FocusScope.of(context).requestFocus(FocusNode());
                      var response =
                          await HttpUtils.registUser(context, params: {
                        "account": account,
                        "code": code,
                        "password": password,
                      });

                      if (response["code"] == "200") {
                        Fluttertoast.showToast(msg: "注册成功");
                        Navigator.of(context).pop();
                      } else {
                        Fluttertoast.showToast(msg: response["msg"]);
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
    if (countdownTimer != null){
      countdownTimer.cancel();
      countdownTimer = null;
    }
    super.dispose();
  }
}
