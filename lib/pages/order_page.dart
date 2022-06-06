import 'package:flutter/material.dart';
import 'package:mobile_store/components/order_list.dart';
import 'package:mobile_store/model/order.dart';
import 'package:mobile_store/utils/icon_util.dart';

class OrderPage extends StatefulWidget {
  final int index;
  const OrderPage({Key? key,required this.index}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage>
    with SingleTickerProviderStateMixin{

  late List<OrderItem> _datas;

  bool loading = false;

  late TabController _controller;

  List<String> options = [
    "全部",
    "待付款",
    "待收货",
    "已完成",
    "已取消",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: options.length, vsync: this);
    _controller.index = widget.index;
    // _getDatas(_controller.index);
  }

  // void _getDatas(int index) async{
  //
  //   _datas = [
  //     OrderItem(orderId: 18,goodId: 6,state: 3,totalPrice: 239.92,storeId: 2,
  //   storeImg: "https://g-search1.alicdn.com/img/bao/uploaded/i4//27/52/TB16683brwTMeJjSszfSutbtFXa.jpg_140x140Q90.jpg_.webp",
  //   storeName: "Muzly 韩系女装",
  //   goods: Goods(
  //   id: 6,
  //   name: "韩国chic夏季新品气质显白小众盘扣改良旗袍裙收腰显瘦短袖连衣裙",
  //   picture: "https://g-search1.alicdn.com/img/bao/uploaded/i4/i1/919022537/O1CN013zdDKy1UbzZdAvxZJ_!!919022537.jpg_320x320Q90.jpg_.webp",
  //   price: 59.98,
  //   num: 4,
  //   ),
  // ),
  //   ];
  //   loading = true;
  //   setState(() {
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          // 触摸收起键盘
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: [
            _buildTopBar(),
            _buildOptions(),
            _buildContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(){
    return Container(
      padding: const EdgeInsets.only(top: 30),
      color: Colors.redAccent,
      child: Container(
        height: 45,
        padding: const EdgeInsets.only(right: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              icon: const Icon(IconUtil.arrowLeft),
              iconSize: 20,
              color: Colors.black,
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 15,right: 30,top: 5,bottom: 5),
                padding: const EdgeInsets.only(left: 10,top: 3,bottom: 3,right: 10),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Colors.white,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    icon: Icon(IconUtil.search,
                      color: Colors.grey.shade600,
                      size: 18,
                    ),
                    isCollapsed: true,
                    hintStyle: const TextStyle(
                      color: Color(0xFFA6A6A6),
                      fontSize: 15,
                    ),
                    hintText: "搜索我的订单",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                child: const Text("筛选",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                onTap: (){},
              ),
            ),
            IconButton(
              onPressed: (){},
              icon: const Icon(IconUtil.more,
                color: Colors.black,
              ),
              iconSize: 20,
              padding: const EdgeInsets.all(0),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildOptions(){
    double childWidth = MediaQuery.of(context).size.width/options.length;
    return TabBar(
      labelColor: Colors.black,
      controller: _controller,
      indicatorColor: Colors.redAccent,
      tabs: options.map((e) =>
          Tab(
            text: e,
          )
      ).toList(),
    );
  }

  Widget _buildContent(){
    return Expanded(
      child: TabBarView(
        controller: _controller,
        children: const [
          OrderList(index: 0),
          OrderList(index: 1),
          OrderList(index: 2),
          OrderList(index: 3),
          OrderList(index: 4),
        ],
      ),
    );
  }

}
