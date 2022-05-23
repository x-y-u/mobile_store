import 'package:flutter/material.dart';
import 'package:mobile_store/pages/setting_page.dart';

import 'home_page.dart';

void main() {
  runApp(const MyApp());
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
      },
      home: const HomePage(),
    );
  }
}


