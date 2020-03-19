import 'package:flutter/material.dart';
import 'package:my_app/model/user_model_entity.dart';
import 'package:my_app/redux/themeRedux.dart';
import 'package:my_app/redux/userRedux.dart';

@immutable
class AppState {
  /// 主题
  ThemeData themeData;

  /// 用户信息
  UserModelEntity userModel;

  AppState({this.themeData, this.userModel});
}

AppState appReducer(AppState state, action) {
  return AppState(
    themeData: ThemeDataReducer(state.themeData, action),
    userModel: UserDataReducer(state.userModel, action),
  );
}
