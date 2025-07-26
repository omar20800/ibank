import 'package:hive/hive.dart';
import 'package:ibank/core/model/user_model.dart';

class AppLocalStorage {
  static Box<String>? tokenbox;
  static Box<UserModel>? userbox;

  static init() async {
    await Hive.openBox<UserModel>('userbox');
    await Hive.openBox<String>('tokenbox');
    userbox = Hive.box<UserModel>('userbox');
    tokenbox = Hive.box<String>('tokenbox');
  }

  static cacheToken(String token) async {
    await tokenbox?.put('token', token);
  }

  static String? getToken() {
    return tokenbox?.get('token');
  }

  static removeToken() async {
    await tokenbox?.delete('token');
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
