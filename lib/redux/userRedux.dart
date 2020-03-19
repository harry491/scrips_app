import 'package:my_app/model/user_model_entity.dart';
import 'package:redux/redux.dart';

///通过 flutter_redux 的 combineReducers，创建 Reducer<State>
final UserDataReducer = combineReducers<UserModelEntity>([
  ///将Action，处理Action动作的方法，State绑定
  TypedReducer<UserModelEntity, UserThemeDataAction>(_refresh),
]);

///定义处理 Action 行为的方法，返回新的 State
UserModelEntity _refresh(UserModelEntity userData, action) {
  userData = action.userData;
  return userData;
}

///定义一个 Action 类
///将该 Action 在 Reducer 中与处理该Action的方法绑定
class UserThemeDataAction {
  final UserModelEntity userData;

  UserThemeDataAction(this.userData);
}
