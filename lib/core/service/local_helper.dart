import 'package:hive/hive.dart';
import 'package:ibank/core/model/user_model.dart';

class AppLocalStorage {
  static Box? tokenbox;
  static Box<UserModel>? userbox;

  static init() async {
    userbox = Hive.box<UserModel>('userbox');
  }

  static cacheUser(UserModel user) async {
    await userbox?.put('user', user);
  }

  static UserModel? getUser() {
    return userbox?.get('user');
  }

  static removeUser() async {
    await userbox?.delete('user');
  }
}
