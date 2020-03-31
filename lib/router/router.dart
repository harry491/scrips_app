import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_app/app/blog/blogDetail.dart';
import 'package:my_app/app/blog/blogMain.dart';
import 'package:my_app/app/blog/card.dart';
import 'package:my_app/app/blog/favourite.dart';
import 'package:my_app/app/blog/writeBlog.dart';
import 'package:my_app/app/blog/forgetPassword.dart';
import 'package:my_app/app/blog/login.dart';
import 'package:my_app/app/components/mine.dart';
import 'package:my_app/app/components/personInfo.dart';
import 'package:my_app/app/blog/register.dart';
import 'package:my_app/app/blog/settings.dart';
import 'package:my_app/app/components/themeset.dart';
import 'package:my_app/router/router_handler.dart';

var routers = <String, WidgetBuilder>{
  '/login': (BuildContext context) => new Login(),
  '/register': (BuildContext context) => new Register(),
  '/forgetPassword': (BuildContext context) => new ForgetPassword(),
  '/mine': (BuildContext context) => new Mine(),
  '/set': (BuildContext context) => new Setting(),
  '/theme': (BuildContext context) => new ThemeSet(),
  '/personInfo': (BuildContext context) => new PersonInfo(),
  '/writeBlog': (BuildContext context) => new WriteBlog(),
  '/blogDetail': (BuildContext context) => new BlogDetail(),
  '/favourite': (BuildContext context) => new MyFavourite(),
  '/blogMain': (BuildContext context) => new BlogMain(),
  '/card': (BuildContext context) => new Card(),
};

class Routers {
  static String login = '/login';
  static String register = '/register';
  static String forgetPassword = '/forgetPassword';
  static String blogMain = '/blogMain';
  static String web = '/web';
  static String home = "/home";
  static String mine = '/mine';
  static String set = '/set';
  static String personInfo = '/personInfo';
  static String writeBlog = '/writeBlog';
  static String blogDetail = '/blogDetail';
  static String favourite = '/favourite';
  static String card = '/card';
  static String theme = '/theme';
  static String authorInfo = '/authorInfo';
  static String editHead = '/editHead';
  static String editName = '/editName';
  static String settings = '/settings';

  static String lineAnimate = '/lineAnimate';

  static void configureRouters(Router router) {
    router.define(login, handler: loginHandler);
    router.define(register, handler: registerHandler);
    router.define(forgetPassword, handler: forgetPasswordHandler);
    router.define(blogMain, handler: blogHandler);
    router.define(mine, handler: mineHandler);
    router.define(personInfo, handler: setHandler);
    router.define(writeBlog, handler: writeHandler);
    router.define(blogDetail, handler: blogDetailHandler);
    router.define(favourite, handler: favouriteHandler);
    router.define(web, handler: webHandler);
    router.define(home, handler: homeHandler);
    router.define(theme, handler: setThemeHandler);
    router.define(authorInfo, handler: setPersonInfo);
    router.define(editHead, handler: setHeadInfo);
    router.define(editName, handler: setNameInfo);
    router.define(settings, handler: setPage);

    router.define(lineAnimate, handler: lineAnimatePage);
  }
}
