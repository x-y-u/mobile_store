import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_store/components/order_list_item.dart';
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

  late List<OrderData> _datas;

  bool loading = false;

  late TabController _controller;

  List<String> options = [
    "全部",
    "已完成",
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
    _getDatas(_controller.index);
  }

  void _getDatas(int index) async{
    _datas = [
      OrderData(storeName: "三只松鼠",
        imgUrl: "https://www.baidu.com/img/PCtm_d9c8750bed0b3c7d089fa7d55720d6cf.png",
        state: 1, productName: "三只松鼠", price: 15.99, num: 2,),
      OrderData(storeName: "三只松鼠",
        imgUrl: "https://www.baidu.com/img/PCtm_d9c8750bed0b3c7d089fa7d55720d6cf.png",
        state: 1, productName: "三只松鼠", price: 15.99, num: 2,),
      OrderData(storeName: "三只松鼠",
        imgUrl: "https://www.baidu.com/img/PCtm_d9c8750bed0b3c7d089fa7d55720d6cf.png",
        state: 1, productName: "三只松鼠", price: 15.99, num: 2,),
      OrderData(storeName: "三只松鼠",
        imgUrl: "https://www.baidu.com/img/PCtm_d9c8750bed0b3c7d089fa7d55720d6cf.png",
        state: 1, productName: "三只松鼠", price: 15.99, num: 2,),
      OrderData(storeName: "三只松鼠",
        imgUrl: "https://www.baidu.com/img/PCtm_d9c8750bed0b3c7d089fa7d55720d6cf.png",
        state: 1, productName: "三只松鼠", price: 15.99, num: 2,),
    ];
    loading = true;
    setState(() {
    });
  }

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
      padding: EdgeInsets.only(top: AppBar().preferredSize.height),
      color: Colors.redAccent,
      child: Container(
        height: 50,
        padding: const EdgeInsets.only(left: 10,right: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              icon: Icon(IconUtil.arrowLeft),
              iconSize: 20,
              color: Colors.black,
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
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
            Padding(padding: const EdgeInsets.only(right: 15),
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
      tabs: options.map((e) =>
          Tab(
            text: e,
          )
      ).toList(),
    );
  }

  Widget _buildContent(){
    return loading?Expanded(
      child: ListView.builder(
        itemCount: _datas.length,
        itemBuilder: (context,index){
          return OrderListItem(data: _datas[index]);
        }
      ),
    ) :const Center(
      child: SizedBox(
        width: 30.0,
        height: 30.0,
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      ),
    );
  }

}
