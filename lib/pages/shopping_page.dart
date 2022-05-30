import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:mobile_store/components/product_list_item.dart';
import 'package:mobile_store/http/HttpUtil.dart';
import 'package:mobile_store/model/category.dart';
import 'package:mobile_store/model/product.dart';

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({Key? key}) : super(key: key);

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  int _index = 0;

  bool _multiple = true;

  late List<CategoryData> _categoryDatas;

  late List<ProductData> _productDatas;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _initCategories();
    _getProducts(1);
  }

  void _initCategories() async{
    _categoryDatas = [];
    HttpUtil().get_requset("/category/all")
    .then((value){
      print(value);
      Category category = Category.fromJson(value.data);
      if(category.code == 20000){
        _categoryDatas = category.data!.data!;
        setState(() {
        });
      }
    })
    .catchError((error){
      print("请求失败！");
    });
    // _datas = [
    //   CategoryData(title: "首页"),
    //   CategoryData(title: "首页"),
    //   CategoryData(title: "首页"),
    //   CategoryData(title: "首页"),
    //   CategoryData(title: "首页"),
    //   CategoryData(title: "首页"),
    //   CategoryData(title: "首页"),
    //   CategoryData(title: "首页"),
    //   CategoryData(title: "首页"),
    // ];
  }

  void _getProducts(int id) async{
    _productDatas = [];
    HttpUtil().get_param_requset("/goods/categoryId/$id")
    .then((value){
      print(value);
      Product product = Product.fromJson(value.data);
      if(product.code == 20000){
        _productDatas = product.data!.data!;
        setState(() {
        });
      }
    })
    .catchError((error){
      print("请求失败！");
    });

    // _products = [
    //   ProductData(picture: "https://www.baidu.com/img/PCtm_d9c8750bed0b3c7d089fa7d55720d6cf.png",
    //       name: "三只松鼠", id: 1, price: 15.99),
    //   ProductData(picture: "https://www.baidu.com/img/PCtm_d9c8750bed0b3c7d089fa7d55720d6cf.png",
    //       name: "三只松鼠", id: 1, price: 15.99),
    //   ProductData(picture: "https://www.baidu.com/img/PCtm_d9c8750bed0b3c7d089fa7d55720d6cf.png",
    //       name: "三只松鼠", id: 1, price: 15.99),
    //   ProductData(picture: "https://www.baidu.com/img/PCtm_d9c8750bed0b3c7d089fa7d55720d6cf.png",
    //       name: "三只松鼠", id: 1, price: 15.99),
    //   ProductData(picture: "https://www.baidu.com/img/PCtm_d9c8750bed0b3c7d089fa7d55720d6cf.png",
    //       name: "三只松鼠", id: 1, price: 15.99),
    //   ProductData(picture: "https://www.baidu.com/img/PCtm_d9c8750bed0b3c7d089fa7d55720d6cf.png",
    //       name: "三只松鼠111111", id: 1, price: 15.99),
    //   ProductData(picture: "https://www.baidu.com/img/PCtm_d9c8750bed0b3c7d089fa7d55720d6cf.png",
    //       name: "三只松鼠", id: 1, price: 15.99),
    //   ProductData(picture: "https://www.baidu.com/img/PCtm_d9c8750bed0b3c7d089fa7d55720d6cf.png",
    //       name: "三只松鼠", id: 1, price: 15.99),
    //   ProductData(picture: "https://www.baidu.com/img/PCtm_d9c8750bed0b3c7d089fa7d55720d6cf.png",
    //       name: "三只松鼠", id: 1, price: 15.99),
    // ];
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
            title: const Text("首页",style: TextStyle(color: Colors.black),),
            actions: [
              IconButton(
                iconSize: 20,
                icon: Icon(_multiple ? Icons.view_agenda : Icons.dashboard),
                onPressed: (){
                  _multiple = !_multiple;
                  setState(() {
                  });
                },
                color: Colors.black,
              )
            ],
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 35,
              color: Colors.white,
              child: ListView.builder(
                itemCount: _categoryDatas.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
                  bool isSelected = _index == index;
                  return GestureDetector(
                    onTap: (){
                      _index = index;
                      _getProducts(_categoryDatas[index].id!);
                    },
                    child: Container(
                      height: 25,
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: Text(_categoryDatas[index].title!,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: isSelected?FontWeight.w600:null
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ];
      },
      body: EasyRefresh.custom(
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
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
                (context,index)=>
                    ProductListItem(data: _productDatas[index], multiple: _multiple),
              childCount: _productDatas.length,
          ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _multiple ? 1 : 2,
              childAspectRatio: _multiple ? 2.5 : 0.7,
            ),
          )
        ],
      ),
    );
  }
}
