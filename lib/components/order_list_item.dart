import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_store/utils/icon_util.dart';

import '../model/order.dart';

class OrderListItem extends StatefulWidget {

  final OrderData data;

  const OrderListItem({Key? key,required this.data}) : super(key: key);

  @override
  State<OrderListItem> createState() => _OrderListItemState();
}

class _OrderListItemState extends State<OrderListItem> {

  late double totalPrice;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    totalPrice = widget.data.price! * widget.data.num!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(top: 15,left: 10,right: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Container(
            height: 25,
            margin: const EdgeInsets.only(top: 15),
            child: Row(
              children: [
                GestureDetector(
                  onTap: (){

                  },
                  child: Row(
                    children: [
                      Text(widget.data.storeName!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(width: 3),
                      const Icon(
                        IconUtil.arrowRight,
                        size: 13,
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                _orderState(),
              ],
            ),
          ),
          InkWell(
            onTap: (){
            },
            child: Container(
              height: 100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: CachedNetworkImage(
                      imageUrl: widget.data.imgUrl!,
                      width: 100,
                      height: 100,
                      placeholder: (context, url) => Icon(
                        Icons.image,
                        color: Colors.grey[300],
                        size: 60,
                      ),
                      errorWidget: (context, url, error) => Icon(
                        Icons.image,
                        color: Colors.grey[300],
                        size: 60,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(left: 5,right: 30),
                      child: Text(
                        widget.data.productName!,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text.rich(
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
                        ),
                        Text("共${widget.data.num}件",
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("更多",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                  ),
                ),
                const Expanded(child: SizedBox()),
                _buildButton("卖了换钱", Colors.black),
                _buildButton("退还/售后", Colors.black),
                _buildButton("再次购买", Colors.redAccent),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _orderState(){
    String state;
    switch(widget.data.state){
      case 1:
        state = "等待付款";
        break;
      case 2:
        state = "待收货";
        break;
      case 3:
        state = "完成";
        break;
      case 4:
        state = "已取消";
        break;
      default:
        state = "";
        break;
    }
    return Text(state,
      style: const TextStyle(
        fontSize: 14,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildButton(String text,Color color){
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(left: 5,right: 5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        border: Border.all(color: color, width: 0.8,)
      ),
      child: Text(text,
        style: TextStyle(
          fontSize: 18,
          color: color,
        ),
      ),
    );
  }
}
