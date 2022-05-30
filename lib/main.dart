import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_store/pages/account_settingh_page.dart';
import 'package:mobile_store/pages/add_address_page.dart';
import 'package:mobile_store/pages/address_list_page.dart';
import 'package:mobile_store/pages/prtoduct_details_page.dart';
import 'package:mobile_store/pages/setting_page.dart';

import 'home_page.dart';

void main() async{
  runApp(const MyApp());
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


