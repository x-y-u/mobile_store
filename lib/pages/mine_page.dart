import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_store/model/global_model/user_state.dart';
import 'package:mobile_store/http/HttpUtil.dart';

import 'package:mobile_store/pages/login_page.dart';
import 'package:mobile_store/pages/prtoduct_details_page.dart';
import 'package:mobile_store/utils/icon_util.dart';
import 'package:mobile_store/utils/login_util.dart';
import 'package:provider/provider.dart';

import 'order_page.dart';

class MinePage extends StatefulWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage>
    with AutomaticKeepAliveClientMixin{

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  late final double _screenWidth = MediaQuery.of(context).size.width;

  List<Map> options1 = [
    {
      "icon":IconUtil.unpaid,
      "label":"待付款",
      "index":1
    },
    {
      "icon":IconUtil.unreceived,
      "label":"待收货",
      "index":2
    },
    {
      "icon":IconUtil.unevaluated,
      "label":"待评价",
      "index":-1
    },
    {
      "icon":IconUtil.afterSale,
      "label":"退款/售后",
      "index":-1
    },
    {
      "icon":IconUtil.order,
      "label":"订单",
      "index":0
    },
  ];
  List<Map> options2 = [
    {
      "icon":IconUtil.collection,
      "label":"商品收藏",
    },
    {
      "icon":IconUtil.shop,
      "label":"店铺关注",
    },
    {
      "icon":IconUtil.time,
      "label":"浏览记录",
    },
  ];
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    _initLogin();
  }

  void _initLogin() async{
    bool isLogin = await LoginUtil.getIsLogin();
    if(isLogin){
      print(isLogin);
      Provider.of<UserStateModel>(context,listen: false).login();
      setState(() {
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 40),
              InkWell(
                onTap:() async {
                  if(Provider.of<UserStateModel>(context,listen: false).isLogin){
                    Navigator.of(context).pushNamed('account_setting');
                  }else{
                    await Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=>LoginPage())
                    );
                    setState(() {
                    });
                  }
                },
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(90)),
                    child: Provider.of<UserStateModel>(context,listen: false).isLogin?
                    Image.asset("assets/images/head_image1.jpg")
                        :const Icon(Icons.image),
                  ),
                  title: Text(Provider.of<UserStateModel>(context,listen: false).isLogin
                      ?"一名用户":"点击登录"
                  ),
                  subtitle: const Text("content"),
                ),
              ),
              Container(
                height: 105.5,
                width: _screenWidth-20,
                margin: const EdgeInsets.only(left: 10,top: 15),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 35,
                      child: Row(
                        children: options2.map(
                                (e) => Container(
                                  alignment: Alignment.center,
                                  height: 35,
                                  width: (_screenWidth-20)/3,
                                  child: InkWell(
                                    onTap: (){},
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(e["icon"],size: 18,),
                                        const SizedBox(width: 5),
                                        Text(e["label"]),
                                      ],
                                    ),
                                  ),
                                )
                        ).toList(),
                      ),
                    ),
                    Container(
                      height: 0.4,
                      width: double.infinity,
                      margin: const EdgeInsets.only(left: 15,right: 15),
                      color: const Color(0xFFA9A9A9),
                    ),
                    SizedBox(
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: options1.map((e){
                          return Container(
                            height: 70,
                            width: (_screenWidth-50)/5,
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  // highlightColor: Colors.transparent, // 透明色
                                  // splashColor: Colors.transparent, // 透明色
                                  onPressed: (){
                                    if(e["index"]!=-1){
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context)=>OrderPage(index: e["index"],))
                                      );
                                    }
                                  },
                                  icon: Icon(e["icon"]),
                                  iconSize: 23,
                                ),
                                Text(e["label"]),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    )
                  ],
                ),
              ),
              ElevatedButton(onPressed: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>ProductDetailPage(id:1))
                );
              },
                child: Text("商品详情"),
              ),
              ElevatedButton(onPressed: (){
                Navigator.of(context).pushNamed('add_address');
              },
                child: Text("添加地址"),
              ),
              ElevatedButton(onPressed: (){
                Navigator.of(context).pushNamed('address_list');
              },
                child: Text("地址列表"),
              ),
              ElevatedButton(onPressed: (){
                HttpUtil().get_requset("/user-auth/test")
                    .then((value){
                  print(value.data);

                });
              },
                child: Text("登陆状态"),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: const EdgeInsets.only(right: 15,top: 15),
              width: 85,
              child: Row(
                children: [
                  const Icon(IconUtil.addFriend,size: 23,),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () async{
                      await Navigator.of(context).pushNamed('setting');
                      setState(() {
                      });
                    },
                    child: const Icon(IconUtil.setting,size: 23,),
                  ),
                  const SizedBox(width: 8),
                  const Icon(IconUtil.message,size: 23,),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
