import 'package:shared_preferences/shared_preferences.dart';

class AppLocalStorage {
  static SharedPreferences? tokenpref;

  static init() async {
    tokenpref = await SharedPreferences.getInstance();
  }

  static cacheToken(String token) async {
    await tokenpref?.setString('token', token);
  }

  static getToken() {
    return tokenpref?.getString('token');
  }

  static removeToken() async {
    await tokenpref?.remove('token');
  }
}
