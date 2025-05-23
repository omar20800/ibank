import 'package:hive/hive.dart';
import 'package:ibank/core/model/user_model.dart';

class AppLocalStorage {
  static Box<UserModel>? userbox;

  static init() async {
    userbox = Hive.box<UserModel>('userbox');
  }

  static cacheUser(String key, UserModel user) async {
    await userbox?.put(key, user);
  }

  static UserModel? getUser(String key) {
    return userbox?.get(key);
  }

  static removeUser(String key) async {
    await userbox?.delete(key);
  }
}
