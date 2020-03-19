import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:my_app/router/fluro_convert_utils.dart';
import 'package:my_app/router/router.dart';
import 'application.dart';

class NavigatorUtils {
  static _navigateTo(BuildContext context, String path,
      {bool replace = false,
      bool clearStack = false,
      Duration transitionDuration = const Duration(milliseconds: 250),
      RouteTransitionsBuilder transitionBuilder}) {
    Application.router.navigateTo(context, path,
        replace: replace,
        clearStack: clearStack,
        transitionDuration: transitionDuration,
        transitionBuilder: transitionBuilder,
        transition: TransitionType.material);
  }

  /// 返回
  static void back(BuildContext context) {
    Application.router.pop(context);
  }

  /// 登录页
  static void goLoginPage(BuildContext context) {
    _navigateTo(context, Routers.login, clearStack: true);
  }

  /// 注册
  static void goRegisterPage(BuildContext context) {
    _navigateTo(context, Routers.register, clearStack: false);
  }

  /// 忘记密码
  static void goForgetPasswordPage(BuildContext context) {
    _navigateTo(context, Routers.forgetPassword, clearStack: false);
  }

  /// 首页
  static void goHomePage(BuildContext context) {
    _navigateTo(context, Routers.home, clearStack: true);
  }

  /// 博客首页
  static void goBlogPage(BuildContext context) {
    _navigateTo(context, Routers.blogMain, clearStack: true);
  }

  /// web页面
  static void goWebPage(BuildContext context, Map<String, dynamic> params) {
    _navigateTo(context,
        Routers.web + "?data=" + FluroConvertUtils.object2string(params),
        clearStack: false);
  }

  /// 写纸条
  static void goWritePage(BuildContext context) {
    _navigateTo(context, Routers.writeBlog, clearStack: false);
  }

  /// 详情
  static void goBlogDetailPage(
      BuildContext context, Map<String, dynamic> params) {
    _navigateTo(context,
        Routers.blogDetail + "?data=" + FluroConvertUtils.object2string(params),
        clearStack: false);
  }

  /// 收藏
  static void goFavouritePage(BuildContext context) {
    _navigateTo(context, Routers.favourite, clearStack: false);
  }

  /// 我的
  static void goMinePage(BuildContext context) {
    _navigateTo(context, Routers.mine, clearStack: false);
  }

  /// 主题
  static void goThemePage(BuildContext context) {
    _navigateTo(context, Routers.theme, clearStack: false);
  }

  /// 个人信息
  static void goPersonInfoPage(BuildContext context) {
    _navigateTo(context, Routers.authorInfo, clearStack: false);
  }

  /// 设置头像
  static void goEditHeadPage(BuildContext context) {
    _navigateTo(context, Routers.editHead, clearStack: false);
  }

  /// 设置名称
  static void goEditNamePage(BuildContext context) {
    _navigateTo(context, Routers.editName, clearStack: false);
  }

  /// 设置
  static void goSetPage(BuildContext context) {
    _navigateTo(context, Routers.settings, clearStack: false);
  }
}
