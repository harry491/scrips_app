import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_app/http/api.dart';
import 'package:my_app/http/myDialog.dart';
import 'package:my_app/model/comments_entity.dart';
import 'package:my_app/model/scrip_model_entity.dart';
import 'package:my_app/model/user.dart';
import 'package:my_app/model/user_model_entity.dart';

class Movie {
  Movie(Map<String, dynamic> map) {
    this.title = map["title"];
    this.other = map["other"];
    this.href = map["href"];
  }

  String title;
  String other;
  String href;
}

class Movies {
  List<Movie> movieList;

  Movies(List movies) {
    if (movies is List) {
      movieList = movies.map((movie) {
        return Movie(movie);
      }).toList();
    }
  }
}

class HttpUtils {
  static String baseUrl = "http://localhost/";
  static String baseImageUrl = "http://localhost/";
  static Dio _dio = initDio();

  static Dio initDio() {
    var dio = new Dio();
    BaseOptions options = BaseOptions();

//    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client){
//      client.findProxy = (uri){
//        return "PROXY localhost:8888";
//      };
//    };

    /// Http请求头
    Map<String, dynamic> headers = Map<String, dynamic>();
    headers['Accept'] = 'application/json';
    headers['Content-Type'] = 'application/json';
    headers['1'] = '2';
    options.headers = headers;

    /// 连接服务器超时时间，单位是毫秒
    options.connectTimeout = 40 * 1000;

    /// 接收数据的最长时限，单位是毫秒
    options.receiveTimeout = 40 * 1000;

    /// 请求路径，如果 `path` 以 "http(s)"开始, 则 `baseURL` 会被忽略； 否则,
    /// 将会和baseUrl拼接出完整的的url.
    //String path = "";
    /// 请求的Content-Type，默认值是"application/json; charset=utf-8".
    /// 如果您想以"application/x-www-form-urlencoded"格式编码请求数据,
    /// 可以设置此选项为 `Headers.formUrlEncodedContentType`,  这样[Dio]
    /// 就会自动编码请求体.
    dio.options = options;
    return dio;
  }

  static Future<Response> _get(
    BuildContext ctx,
    String url, {
    Map<String, dynamic> params,
  }) async {
    try {
      if (url.contains("v1/")) {
        var token = await UserUtils.getUserToken();
        params["token"] = token;
      }
      return await _dio.get(url, queryParameters: params);
    } on DioError catch (e) {
      Navigator.of(ctx).pop();
      if (e.response is Map) {
        return Future.value(e.response);
      } else {
        return Future.error(e.response);
      }
    } finally {}
  }

  static Future<Response> _post(BuildContext ctx, String url,
      {Map<String, dynamic> params, dynamic data}) async {
    var response;
    try {
      if (url.contains("v1/")) {
        var token = await UserUtils.getUserToken();
        params["token"] = token;
      }
      response = await _dio.post(url, queryParameters: params, data: data);
    } on DioError catch (e) {
      response = Response(statusCode: 404, data: {
        "status": "404",
        "msg": e.error.toString(),
      });
    }
    return response;
  }

  /// 获取影视
  static Future<Movies> getMoviesData(BuildContext context,
      {Map<String, dynamic> params = const {'offset': 0, 'limit': 10}}) async {
    var response = await _get(context, baseUrl + 'movies', params: params);
    return Movies(response.data["data"]);
  }

  /// 获取验证码
  static Future<Map<String, dynamic>> getEmailCode(BuildContext context,
      {@required Map<String, dynamic> params}) async {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return MyDialog(
            text: "loading...",
          );
        });
    var response =
        await _post(context, baseUrl + "sendEmailCode", params: params);
    Navigator.of(context).pop();
    return response.data;
  }

  /// 注册
  static Future<Map<String, dynamic>> registUser(BuildContext context,
      {@required Map<String, dynamic> params}) async {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return MyDialog(
            text: "loading...",
          );
        });
    var response =
        await _post(context, baseUrl + "v1/register", params: params);
    Navigator.of(context).pop();
    return response.data;
  }

  /// 找回密码
  static Future<Map<String, dynamic>> editPassword(BuildContext context,
      {@required Map<String, dynamic> params}) async {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return MyDialog(
            text: "loading...",
          );
        });
    var response =
        await _post(context, baseUrl + "v1/findPassword", params: params);
    Navigator.of(context).pop();
    return response.data;
  }

  /// 登录
  static Future<UserModelEntity> login(BuildContext context,
      {@required Map<String, dynamic> params}) async {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return MyDialog(
            text: "loading...",
          );
        });
    var response = await _post(context, baseUrl + "v1/login", params: params);
    Navigator.of(context).pop();
    return UserModelEntity.fromJson(response.data);
  }

  /// 获取用户信息
  static Future<UserModelEntity> getUserInfo(BuildContext context,
      {@required Map<String, dynamic> params}) async {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return MyDialog(
            text: "loading...",
          );
        });
    var response = await _post(context, baseUrl + api_my_info, params: params);
    Navigator.of(context).pop();
    return UserModelEntity.fromJson(response.data);
  }

  /// 编辑用户信息
  static Future<UserModelEntity> editUserInfo(BuildContext context,
      {@required Map<String, dynamic> params, dynamic data}) async {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return MyDialog(
            text: "loading...",
          );
        });
    var response = await _post(context, baseUrl + api_edit_info,
        params: params, data: data);
    Navigator.of(context).pop();
    return UserModelEntity.fromJson(response.data);
  }

  /// 写纸条
  static Future<Map<String, dynamic>> writeScrip(BuildContext context,
      {@required Map<String, dynamic> params, dynamic data}) async {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return MyDialog(
            text: "loading...",
          );
        });
    var response = await _post(context, baseUrl + "v1/writeScrip",
        params: params, data: data);
    Navigator.of(context).pop();
    return response.data;
  }

  /// 查询所有纸条
  static Future<ScripModelEntity> scrips(BuildContext context,
      {@required Map<String, dynamic> params}) async {
    var response = await _post(context, baseUrl + "v1/scrips", params: params);

    var scrips = ScripModelEntity.fromJson(response.data);
    return scrips;
  }

  /// 写评论
  static Future<Map<String, dynamic>> writeComment(BuildContext context,
      {@required Map<String, dynamic> params}) async {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return MyDialog(
            text: "loading...",
          );
        });
    var response =
        await _post(context, baseUrl + api_writeComments, params: params);
    Navigator.of(context).pop();
    return response.data;
  }

  /// 查询字条评论
  static Future<CommentsEntity> comments(BuildContext context,
      {@required Map<String, dynamic> params}) async {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return MyDialog(
            text: "loading...",
          );
        });
    var response = await _post(context, baseUrl + api_comments, params: params);
    Navigator.of(context).pop();
    return CommentsEntity().fromJson(response.data);
  }

  /// 点赞
  static Future<Map<String, dynamic>> addPoint(BuildContext context,
      {@required Map<String, dynamic> params}) async {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return MyDialog(
            text: "loading...",
          );
        });
    var response =
        await _post(context, baseUrl + api_add_point, params: params);
    Navigator.of(context).pop();
    return response.data;
  }

  /// 收藏
  static Future<Map<String, dynamic>> addCollect(BuildContext context,
      {@required Map<String, dynamic> params}) async {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return MyDialog(
            text: "loading...",
          );
        });
    var response =
        await _post(context, baseUrl + api_add_collect, params: params);
    Navigator.of(context).pop();
    return response.data;
  }

  /// 我的收藏
  static Future<ScripModelEntity> myCollect(BuildContext context,
      {@required Map<String, dynamic> params}) async {
    var response =
        await _post(context, baseUrl + api_my_collect, params: params);
    var scrips = ScripModelEntity.fromJson(response.data);
    return scrips;
  }
}
