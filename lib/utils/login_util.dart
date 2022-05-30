

import 'package:shared_preferences/shared_preferences.dart';

class LoginUtil{

  static const String USER_ACCOUNT = "account";
  static const String USER_PASSWORD = "password";
  static const String IS_LOGIN = "is_login";

  static void loginNewAccount(String account,String password) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(USER_ACCOUNT, account);
    prefs.setString(USER_PASSWORD, password);
    prefs.setBool(IS_LOGIN, true);
  }

  static void login() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(IS_LOGIN, true);
  }

  static void logout() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(IS_LOGIN, false);
  }

  static Future<bool> getIsLogin() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogin = await prefs.getBool(IS_LOGIN)??false;
    return isLogin;
  }

}