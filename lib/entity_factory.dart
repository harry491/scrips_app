import 'package:my_app/model/scrip_model_entity.dart';
import 'package:my_app/model/user_model_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "ScripMode1Entity") {
      return ScripModelEntity.fromJson(json) as T;
    } else if (T.toString() == "UserModelEntity") {
      return UserModelEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}
