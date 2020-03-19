import 'package:flutter/cupertino.dart';

class LoginNotification {
  String account;

  // 通知账户和密码
  LoginNotification({
    this.account,
  });
}

class PublishNotification {
  // 发帖
  PublishNotification();
}

class ThemeChangeNotification {
  Color color;

  ThemeChangeNotification({this.color});
}
