import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import '../model/order.dart';
import 'order_list_item.dart';

class OrderList extends StatefulWidget {

  final int index;

  const OrderList({Key? key,required this.index}) : super(key: key);

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> with AutomaticKeepAliveClientMixin{

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  bool loading = false;

  late List<OrderData> _datas;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDatas(widget.index);
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
    return Container(
      height: double.infinity,
      child: loading?EasyRefresh.custom(
        header: MaterialHeader(),
        footer: MaterialFooter(),
        onRefresh: () async {
          await Future.delayed(Duration(milliseconds: 1500), () {
          });
        },
        onLoad: () async {
          await Future.delayed(Duration(milliseconds: 1500), () {
          });
        },
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (content, index) {
                return OrderListItem(data: _datas[index]);
              },
              childCount: _datas.length,
            ),
          )
        ],
      ):const Center(
        child: SizedBox(
          width: 30.0,
          height: 30.0,
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      ),
    );
  }
}
