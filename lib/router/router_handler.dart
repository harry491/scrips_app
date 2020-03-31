import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:my_app/app/animate/lineAnimate.dart';
import 'package:my_app/app/blog/blog.dart';
import 'package:my_app/app/blog/blogDetail.dart';
import 'package:my_app/app/blog/blogWeb.dart';
import 'package:my_app/app/blog/editHead.dart';
import 'package:my_app/app/blog/editName.dart';
import 'package:my_app/app/blog/favourite.dart';
import 'package:my_app/app/blog/personInfo.dart';
import 'package:my_app/app/blog/themePage.dart';
import 'package:my_app/app/blog/writeBlog.dart';
import 'package:my_app/app/blog/forgetPassword.dart';
import 'package:my_app/app/blog/login.dart';
import 'package:my_app/app/components/mine.dart';
import 'package:my_app/app/blog/register.dart';
import 'package:my_app/app/blog/settings.dart';
import 'package:my_app/app/home/homePage.dart';
import 'package:my_app/router/fluro_convert_utils.dart';

/// 主页
var homeHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  return HomePage();
});

/// 登录
var loginHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  return Login();
});

/// 注册
var registerHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  return Register();
});

/// 忘记密码
var forgetPasswordHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  return ForgetPassword();
});

/// 纸条主页
var blogHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  return Blog();
});

/// web页面
var webHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  var data = FluroConvertUtils.string2map(params["data"].first);

  return BlogWeb(
    url: data["url"],
  );
});

/// 收藏
var favouriteHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  return MyFavourite();
});

/// 我的
var mineHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  return Mine();
});

/// 写纸条
var writeHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  return WriteBlog();
});

/// 纸条详情
var blogDetailHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  var data = FluroConvertUtils.string2map(params["data"].first);
  return BlogDetail(
    params: data,
  );
});

/// 设置
var setHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  return Setting();
});

/// 主题
var setThemeHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  return ThemePage();
});

/// 个人信息
var setPersonInfo = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return PersonInfo();
    });

/// 头像设置
var setHeadInfo = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return EditHead();
    });

/// 名称设置
var setNameInfo = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return EditName();
    });

/// 设置
var setPage = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return Setting();
    });


/// 线性动画
var lineAnimatePage = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return LineAnimate();
    });
