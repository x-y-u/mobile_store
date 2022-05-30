import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:mobile_store/http/HttpUtil.dart';
import 'package:mobile_store/model/global_model/address_model.dart';
import 'package:mobile_store/model/product.dart';
import 'package:mobile_store/pages/shopping_cart_page.dart';
import 'package:mobile_store/utils/icon_util.dart';
import 'package:mobile_store/utils/toast_util.dart';
import 'package:provider/provider.dart';


class ProductDetailPage extends StatefulWidget {
  final dynamic id;

  ProductDetailPage({this.id,Key? key});

  _ProductDetailPageState createState() => _ProductDetailPageState(id);
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  // 是否正在请求
  bool loading = false;

  // 商品id
  final dynamic id;

  late ProductData _data;

  // 轮播图
  List<String> album = [];
  //购买数量
  int num = 1;
  // 属性类型数量
  int specs = 0;

  _ProductDetailPageState(this.id);

  @override
  void initState() {
    super.initState();
    _getProductInfo();
  }

  void _getProductInfo() async{

    HttpUtil().get_param_requset("/goods/detail",
    params: {
      "goodId":widget.id
    }
    ).then((value){
      if(value.data['code']==20000){
        ProductDetail detail = ProductDetail.fromJson(value.data);
        _data = detail.data!;
        loading = true;
        setState(() {
        });
      }
    }).catchError((error){
      print(error);
    });

    // _data = ProductData(
    //   picture: "https://www.baidu.com/img/PCtm_d9c8750bed0b3c7d089fa7d55720d6cf.png",
    //   name: "三只松鼠",
    //   price: 15.99,
    //   sales: 799,
    // );

  }

  // 加入购物车
  void _addCart() async {
    HttpUtil().postRequestWithJson(
      "/shopping-cart/${_data.id}",
      data: {
        'num':num
      }
    ).catchError((error){
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              loading
                  ? CustomScrollView(
                slivers: <Widget>[
                  // 商品图片轮播
                  SliverPadding(
                    padding: const EdgeInsets.all(0.0),
                    sliver: SliverList(
                        delegate: SliverChildListDelegate(
                            <Widget>[
                              CachedNetworkImage(
                                imageUrl: _data.picture!,
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width - 100.0,
                                placeholder: (context, url) => Icon(
                                  Icons.image,
                                  color: Colors.grey[300],
                                  size: MediaQuery.of(context).size.width - 100.0,
                                ),
                                errorWidget: (context, url, error) => Icon(
                                  Icons.image,
                                  color: Colors.grey[300],
                                  size: MediaQuery.of(context).size.width - 100.0,
                                ),
                              ),
                        ],
                        ),
                    ),
                  ),
                  // 标题、价格、销量、产地等信息
                  SliverPadding(
                      padding: const EdgeInsets.all(0.0),
                      sliver: SliverList(
                          delegate: SliverChildListDelegate(<Widget>[
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(color: Colors.white),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text.rich(
                                    TextSpan(
                                        text: "￥",
                                        style: const TextStyle(
                                          fontSize: 12,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: "${_data.price!.truncate()}.",
                                            style: const TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                          TextSpan(
                                            text: "${(_data.price!*100%100).truncate()}",
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          )
                                        ]
                                    ),
                                  ),
                                  Container(
                                    child: Text(_data.name!,
                                        style: TextStyle(fontSize: 18.0)),
                                    margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 8.0),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("产地：中国",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 16.0)),
                                      Text("快递：13",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 16.0)),
                                      Text(
                                          "销量：" +
                                              _data.sales.toString(),
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 16.0)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 10.0,
                            )
                          ]))),
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.only(left: 15,right: 10),
                      margin: const EdgeInsets.all(10),
                      color: Colors.white,
                      child: Column(
                        children: [
                          InkWell(
                            child: Container(
                              height: 45,
                              child: Row(
                                children: const [
                                  Text(
                                    "规格选择",
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                  Expanded(child: SizedBox()),
                                  Icon(IconUtil.arrowRight,
                                    color: Colors.black,
                                    size: 16,
                                  )
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            child: Container(
                              height: 45,
                              child: Row(
                                children: [
                                  const Text(
                                    "购买数量",
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                  const Expanded(child: SizedBox()),
                                  _buildCounter()
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            child: Container(
                              height: 45,
                              child: Row(
                                children: const [
                                  Text(
                                    "用户评价",
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                  Expanded(child: SizedBox()),
                                  Text(
                                    "0条评价",
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            child: Container(
                              height: 45,
                              child: Row(
                                children: const [
                                  Text(
                                    "商品详情",
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                  Expanded(child: SizedBox()),
                                  Icon(IconUtil.arrowRight,
                                    color: Colors.black,
                                    size: 16,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
                  : const Center(
                child: SizedBox(
                  width: 30.0,
                  height: 30.0,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 45,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: 25,
                          width: 25,
                          margin: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(90)),
                            color: Colors.grey.shade600,
                          ),
                          child:const Icon(IconUtil.arrowLeft,
                            size: 17,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(90)),
                            color: Colors.grey.shade600,
                          ),
                          child:const Icon(IconUtil.share,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: 25,
                          width: 25,
                          margin: const EdgeInsets.only(left: 10,right: 10),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(90)),
                            color: Colors.grey.shade600,
                          ),
                          child:const Icon(IconUtil.more,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: loading? Container(
          height: 45,
          decoration: const BoxDecoration(color: Colors.white),
          child: Row(
            children: <Widget>[
              InkWell(
                onTap: (){},
                child:Container(
                  width: 35,
                  margin: const EdgeInsets.only(left: 10,right: 15,top: 5,bottom: 5),
                  child: Column(
                    children: [
                      const Icon(IconUtil.shop,
                      size: 21,
                        color: Colors.redAccent,
                      ),
                      const Expanded(child: SizedBox()),
                      Text("店铺",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade500,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){},
                child:Container(
                  width: 35,
                  margin: const EdgeInsets.only(left: 10,right: 15,top: 5,bottom: 5),
                  child: Column(
                    children: [
                      Icon(IconUtil.message,
                        size: 21,
                        color: Colors.grey.shade900,
                      ),
                      const Expanded(child: SizedBox()),
                      Text("客服",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade500,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  // Navigator.of(context).push(
                  //     MaterialPageRoute(builder: (context)=>const ShoppingCartPage())
                  // );
                },
                child:Container(
                  width: 35,
                  margin: const EdgeInsets.only(left: 10,right: 15,top: 5,bottom: 5),
                  child: Column(
                    children: [
                      Icon(IconUtil.cart,
                        size: 21,
                        color: Colors.grey.shade900,
                      ),
                      const Expanded(child: SizedBox()),
                      Text("购物车",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade500,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: (){
                    _addCart();
                    ToastUtil.makeToast("加入购物车成功");
                    // Navigator.of(context).pop();
                  },
                  child: Container(
                    height: double.infinity,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: Colors.amber
                    ),
                    child: const Text("加入购物车",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: (){
                    HttpUtil().postRequestWithJson(
                      "/goods/buy",
                      data: {
                        'address':Provider.of<AddressModel>(context,listen: false).address,
                        'goods':{
                          'goodId':_data.id,
                          'num':num
                        }
                      }
                    ).catchError((error){
                      print(error);
                    });
                    ToastUtil.makeToast("购买成功");
                  },
                  child: Container(
                    height: double.infinity,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: Colors.redAccent
                    ),
                    child: const Text("立即购买",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ):Container(
          height: 0.0,
        ));
  }

  Widget _buildCounter(){
    bool sub_able = num > 1;
    return Container(
      height: 25,
      width: 81,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          border: Border.all(
            width: 1,
            color: Colors.grey.shade600,
          )
      ),
      child:Row(
        children: [
          Expanded(
              child: InkWell(
                onTap: (){
                  if(sub_able){
                    setState(() {
                      num = num-1;
                    });
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.center,
                  child: Text("-",
                    style: TextStyle(
                      fontSize: 18,
                      color: sub_able?Colors.black:Colors.grey.shade600,
                    ),
                  ),
                ),
              )
          ),
          Container(
            width: 1,
            height: double.infinity,
            color: Colors.grey.shade600,
          ),
          Expanded(
              child: Center(
                child: Text("${num}",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              )
          ),
          Container(
            width: 1,
            height: double.infinity,
            color: Colors.grey.shade600,
          ),
          Expanded(
              child: InkWell(
                onTap: (){
                  setState(() {
                    num = num+1;
                  });
                },
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.center,
                  child: const Text("+",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }
}