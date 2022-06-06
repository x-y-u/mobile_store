import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:mobile_store/http/HttpUtil.dart';

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

  late List<OrderItem> _datas;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDatas(widget.index);
  }

  void _getDatas(int index) async{
    _datas = [];
    var state;
    if(index>0)
      state = index-1;
    else
      state = null;
    HttpUtil().get_param_requset(
        "/order/",
        params: {
          "state":state
        }
    ).then((value){
        Order order = Order.fromJson(value.data);
        _datas = (order.data?.recordList)!;
        setState(() {
        });
    }).catchError((error){

    });
    // _datas = [
    //   OrderItem(orderId: 18,goodId: 6,state: 3,totalPrice: 239.92,storeId: 2,
    //     storeImg: "https://g-search1.alicdn.com/img/bao/uploaded/i4//27/52/TB16683brwTMeJjSszfSutbtFXa.jpg_140x140Q90.jpg_.webp",
    //     storeName: "Muzly 韩系女装",
    //     goods: Goods(
    //       id: 6,
    //       name: "韩国chic夏季新品气质显白小众盘扣改良旗袍裙收腰显瘦短袖连衣裙",
    //       picture: "https://g-search1.alicdn.com/img/bao/uploaded/i4/i1/919022537/O1CN013zdDKy1UbzZdAvxZJ_!!919022537.jpg_320x320Q90.jpg_.webp",
    //       price: 59.98,
    //       num: 4,
    //     ),
    //   ),
    // ];
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
