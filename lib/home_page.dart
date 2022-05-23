import 'package:flutter/material.dart';
import 'package:mobile_store/pages/mine_page.dart';
import 'package:mobile_store/pages/shopping_cart_page.dart';
import 'package:mobile_store/pages/shopping_page.dart';
import 'package:mobile_store/utils/icon_util.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int _index;
  List<Widget> pages = [
    const ShoppingPage(),
    const ShoppingCartPage(),
    const MinePage(),
  ];
  @override
  void initState(){
    super.initState();
    _index = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[_index],
        bottomNavigationBar:Theme(
          data: ThemeData(
            brightness: Brightness.light,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child:Card(
            // shadowColor: const Color(0xFFFFFFFF),
            elevation: 10,
            // margin: const EdgeInsets.only(top: 2),
            margin: const EdgeInsets.all(0),
            color: Colors.amberAccent,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)
                )
            ),
            child: SizedBox(
              height: 70,
              child: _setBottomNavigationBar(),
            ),
          ),
        ),
    );
  }

  Widget _setBottomNavigationBar(){
    return SizedBox(
      height: 63,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15)
        ),
        child: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            currentIndex: _index,
            onTap: _onChangePage,
            // elevation: 5,
            // backgroundColor: const Color(0xFFFFFFFF),
            selectedItemColor: const Color(0xFF1DAFC2),
            unselectedItemColor: const Color(0xFF808080),
            selectedFontSize: 12,
            unselectedFontSize: 12,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: SizedBox(
                height: 25,
                width: 25,
                child: Icon(IconUtil.home),
              ),
                label: "首页",
              ),
              BottomNavigationBarItem(icon: SizedBox(
                height: 25,
                width: 25,
                child: Icon(IconUtil.cart),
              ),
                label: "购物车",
              ),
              BottomNavigationBarItem(icon: SizedBox(
                height: 25,
                width: 25,
                child: Icon(IconUtil.mine),
              ),
                label: "我的",
              ),

            ]
        ),
      ),
    );
  }

  void _onChangePage(int index){
    setState(() {
      _index = index;
    });
  }
}