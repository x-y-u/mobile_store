import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_store/http/HttpUtil.dart';
import 'package:mobile_store/model/global_model/user_state.dart';
import 'package:mobile_store/pages/account_settingh_page.dart';
import 'package:mobile_store/pages/add_address_page.dart';
import 'package:mobile_store/pages/address_list_page.dart';
import 'package:mobile_store/pages/setting_page.dart';
import 'package:mobile_store/utils/login_util.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

void main() async{
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserStateModel>(create: (_) {
          return UserStateModel();
        }),
      ],
      child: const MyApp(),
    ),
  );

  try{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? account = prefs.getString(LoginUtil.USER_ACCOUNT);
    String? password = prefs.getString(LoginUtil.USER_PASSWORD);
    if(account == null||password == null){
    }else{
      HttpUtil().post_requset(
          "/login",
          params: {
            "username":account,
            "password":password
          }
      ).then((result){
        Map<String,dynamic> map = jsonDecode(result.data);
        print(map);
        if(map['code']==20000){//登录成功的操作
          LoginUtil.loginNewAccount(account, password);
        }else{
        }
      }).catchError((error){
        print(error);
      });
    }
  }catch(error){
    print(error);
  }

  if (Platform.isAndroid) {
    // 设置沉浸式状态栏
    SystemUiOverlayStyle systemUiOverlayStyle =
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        highlightColor: Colors.transparent, // 透明色
        splashColor: Colors.transparent, // 透明色
      ),
      routes: <String, WidgetBuilder>{
        'setting': (BuildContext context) => const SettingPage(),
        'account_setting': (BuildContext context) => const AccountSettingPage(),
        'add_address': (BuildContext context) => const AddAddressPage(),
        'address_list': (BuildContext context) => const AddressListPage(),
      },
      home: const HomePage(),
    );
  }
}


