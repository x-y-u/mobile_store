import 'package:flutter/material.dart';
import 'package:mobile_store/utils/icon_util.dart';

class MinePage extends StatefulWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  late final double _screenWidth = MediaQuery.of(context).size.width;
  List<Map> options1 = [
    {
      "icon":IconUtil.unpaid,
      "label":"待付款",
    },
    {
      "icon":IconUtil.unreceived,
      "label":"待收货",
    },
    {
      "icon":IconUtil.unevaluated,
      "label":"待评价",
    },
    {
      "icon":IconUtil.afterSale,
      "label":"退款/售后",
    },
    {
      "icon":IconUtil.order,
      "label":"订单",
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
  void initState() {
    // TODO: implement initState
    super.initState();
    // _screenWidth = MediaQuery.of(context).size.width;
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
              ListTile(
                leading: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(90)),
                  child: Image.asset("assets/images/head_image1.jpg"),
                ),
                title: const Text("标题"),
                subtitle: const Text("content"),
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
                                  onPressed: (){},
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
              )
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
                    onTap: (){
                      Navigator.of(context).pushNamed('setting');
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