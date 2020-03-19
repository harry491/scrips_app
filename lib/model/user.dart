import 'dart:convert';
import 'package:my_app/model/user_model_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {}

class UserUtils {
  static String userKey = "share_user_key";
  static String userToken = "share_user_token_key";

  /// 存储token
  static Future<bool> setUserToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userToken, token);
  }

  /// 获取token
  static Future<String> getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(userToken);
  }

  /// 获取用户信息存储
  static Future<UserModelEntity> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return UserModelEntity.fromJson(jsonDecode(prefs.get(userKey)));
  }

  /// 设置用户信息存储
  static Future<bool> setUserInfo(UserModelEntity user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userKey, jsonEncode(user.toJson()));
  }
}
