import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_store/utils/no_ripple_scroll_behavior.dart';

import '../model/cart.dart';
import '../model/address.dart';
import '../utils/icon_util.dart';

class ConfirmOrderPage extends StatefulWidget {

  final CartData data;

  const ConfirmOrderPage({Key? key,required this.data}) : super(key: key);
  @override
  ConfirmOrderPageState createState() => ConfirmOrderPageState();
}

class ConfirmOrderPageState extends State<ConfirmOrderPage> {

  // 选择的收货地址
  late AddressData currentAddress;

  // 商品清单
  List<CartItem> cartList = [];

  // 商品总价
  double total = 0;

  double deliveryFee = 5.99;

  double realPrice = 0;

  @override
  void initState() {
    super.initState();
    currentAddress = AddressData(name: "xyu",isDefault: false,
      province: "四川",city: "成都",area: "绵阳",
      phone: "1254716754", detail: "四川大学",
    );

    cartList = widget.data.children!;
    for(CartItem item in cartList){
      total += item.price! * item.num!;
    }
    realPrice = total + deliveryFee;
  }

// 显示的价格
  Widget _showPrice(CartItem item) {
    double totalPrice = item.num! * item.price!;
    return Text.rich(
      TextSpan(
          text: "￥",
          style: const TextStyle(
            fontSize: 12,
          ),
          children: [
            TextSpan(
              text: "${totalPrice.truncate()}.",
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            TextSpan(
              text: "${(totalPrice*100%100).truncate()}",
              style: const TextStyle(
                fontSize: 12,
              ),
            )
          ]
      ),
    );
  }

  listUI() {
    List<Widget> itemList = cartList.map(
            (item) =>Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade100))),
      margin: const EdgeInsets.only(bottom: 20.0, right: 8.0,left: 8.0),
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Row(
              children: <Widget>[
                SizedBox(
                  child: CachedNetworkImage(
                    width: 100.0,
                    height: 100.0,
                    imageUrl: item.img!,
                    placeholder: (context, url) => Icon(
                      Icons.image,
                      color: Colors.grey[300],
                      size: 100.0,
                    ),
                    errorWidget: (context, url, error) => Icon(
                      Icons.image,
                      color: Colors.grey[300],
                      size: 100.0,
                    ),
                  ),
                  width: 100.0,
                  height: 100.0,
                ),
                Expanded(
                  flex: 7,
                  child: Container(
                    width: 100.0,
                    height: 100.0,
                    margin: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 10),
                        Text(item.goodsName!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 18.0)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            _showPrice(item),
                            Text("x" + item.num.toString(),
                              style: const TextStyle(fontSize: 15),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    )
    ).toList();
    return itemList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ScrollConfiguration(
        behavior: NoRippleScrollBehavior(),
        child: CustomScrollView(slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
            pinned: true,
            elevation: 1.0,
            leading: IconButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              icon: const Icon(IconUtil.arrowLeft),
              iconSize: 18,
              color: Colors.black,
              padding: const EdgeInsets.all(0),
            ),
            title: const Text(
              '确认订单',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            actions: <Widget>[],
          ),

          SliverPadding(
            padding: const EdgeInsets.all(0.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(<Widget>[
                Container(
                  height: 2.0,
                  color: Colors.grey[200],
                ),
                Material(
                  child: InkWell(
                    onTap: () {
                      // Application.router.navigateTo(context, "/orderMap").then((onValue){
                      //   print(onValue);
                      // });
                    },
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 8.0, right: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Icon(Icons.room),
                          currentAddress != null
                              ? Expanded(child: Container(
                            padding: EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  currentAddress.province! +
                                      currentAddress.city! +
                                      currentAddress.area! +
                                      currentAddress.detail!,
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                Container(
                                  height: 10.0,
                                ),
                                Text(
                                    currentAddress.name! +
                                        ' ' +
                                        currentAddress.phone!,
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.grey))
                              ],
                            ),
                          ),)
                              : Text('添加收货地址'),
                          Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 10.0,
                  color: Colors.grey[200],
                ),
                Container(
                  child: Text('商品清单'),
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.only(bottom: 8.0),
                  decoration: BoxDecoration(
                      border:
                      Border(bottom: BorderSide(color: Colors.grey.shade300))),
                ),
                Column(
                  children: listUI(),
                ),
                Container(
                  height: 10.0,
                  color: Colors.grey[200],
                ),
                Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('商品总额',style: TextStyle(fontSize: 16.0),),
                          Text('￥'+total.toStringAsFixed(2),style: TextStyle(fontSize: 16.0,color: Colors.red),),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('配送费',style: TextStyle(fontSize: 16.0),),
                          Text('￥$deliveryFee',style: TextStyle(fontSize: 16.0,color: Colors.red),),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('实付款',style: TextStyle(fontSize: 16.0),),
                          Text('￥'+realPrice.toStringAsFixed(2),style: TextStyle(fontSize: 16.0,color: Colors.red),),
                        ],
                      ),
                    )

                  ],
                )
              ],
              ),
            ),
          ),
        ],
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          Fluttertoast.showToast(
            msg: "支付成功",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.black,
            backgroundColor: const Color(0x55616161),
          );
          Navigator.of(context).pop();
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(const Color(0xFFed154f)),
        ),
        child: const Text(
          "支付",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}