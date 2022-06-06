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
