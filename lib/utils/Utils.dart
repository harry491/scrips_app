import 'dart:convert';

import 'package:flutter/material.dart';

class Utils {
  /// 时间格式化
  static String timeFormat(String time) {
    var date = DateTime.parse(time).toLocal();
    return date.year.toString() +
        " " +
        date.month.toString() +
        "-" +
        date.day.toString() +
        " " +
        date.hour.toString() +
        ":" +
        date.minute.toString();
  }

  /// 十六进制颜色，
  /// hex, 十六进制值，例如：0xffffff,
  /// alpha, 透明度 [0.0,1.0]
  static Color hexColor(int hex, {double alpha = 1}) {
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    return Color.fromRGBO((hex & 0xFF0000) >> 16, (hex & 0x00FF00) >> 8,
        (hex & 0x0000FF) >> 0, alpha);
  }

  /// 检查是否是邮箱格式
  static bool isEmail(String input) {
    /// 邮箱正则
    final String regexEmail =
        "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$";
    if (input == null || input.isEmpty) return false;
    return new RegExp(regexEmail).hasMatch(input);
  }

  /*
  * Base64加密
  */
  static String encodeBase64(String data) {
    var content = utf8.encode(data);
    var digest = base64Encode(content);
    return digest;
  }

  /*
  * Base64解密
  */
  static String decodeBase64(String data) {
    return String.fromCharCodes(base64Decode(data));
  }
}
