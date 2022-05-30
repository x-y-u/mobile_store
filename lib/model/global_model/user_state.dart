

import 'package:flutter/cupertino.dart';

class UserStateModel with ChangeNotifier{
  bool isLogin = false;

  void login(){
    isLogin = true;
    notifyListeners();
  }

  void logout(){
    isLogin = false;
    notifyListeners();
  }
}