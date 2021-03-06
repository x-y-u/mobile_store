import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_store/bean/cartBean.dart';
import 'package:mobile_store/http/HttpUtil.dart';
import 'package:mobile_store/model/cart.dart' as cart_json;
import 'package:mobile_store/pages/confirm_order.dart';
import 'package:mobile_store/pages/prtoduct_details_page.dart';
import 'package:mobile_store/utils/icon_util.dart';
import 'package:mobile_store/utils/no_ripple_scroll_behavior.dart';
import 'package:provider/provider.dart';

import '../model/global_model/address_model.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({Key? key}) : super(key: key);

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage>
    with AutomaticKeepAliveClientMixin{
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  late final double _screenWidth = MediaQuery.of(context).size.width;
  String defaultImage = "assets/images/head_image1.jpg";
  bool _isAllSelected = false;
  double _totalPrice = 0;
  late List<Cart> carts;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCartDatas();
  }

  void _getCartDatas() async{
    carts = [];

    HttpUtil().get_requset(
      "/shopping-cart/")
    .then((value){
      print(value);
      cart_json.Cart ccarts =cart_json.Cart.fromJson(value.data);
      for(cart_json.CartData data in ccarts.recordList!){
        Cart cart = Cart(shopName: data.store!.name!,items: []);
        carts.add(cart);
        for(cart_json.CartItem item in data.goods!){
          cart.items!.add(CartItem(id: item.id!,name: item.name!,
              imageUrl: item.img,price: item.price,num: item.num));
        }
      }
      setState(() {
      });
    })
    .catchError((error){
      print(error);
    })
    ;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
        child: Stack(
          children: [
            NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    backgroundColor: Colors.white,
                    flexibleSpace: _buildTopBar(),
                    pinned: true,
                  ),
                ];
              },
              body: ScrollConfiguration(
                behavior: NoRippleScrollBehavior(),
                child: ListView.builder(
                  itemBuilder: _buildCartItem,
                  itemCount: carts.length,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child:_buildBottomBar(),
            ),
          ],
        )
    );
  }

  Widget _buildTopBar(){
    return Container(
      height: 60,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 15,right: 7),
      child: Row(
        children: [
          const Text("?????????",
            style: TextStyle(
              color: Colors.black,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: (){},
              child: Container(
                height: 17,
                width: double.infinity,
                margin: const EdgeInsets.only(left: 5,right: 20),
                padding: const EdgeInsets.only(left: 8,right: 8),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Color(0x99DCDCDC),
                ),
                child: Row(
                  children: [
                    const Icon(
                        IconUtil.address,
                      size: 12,
                    ),
                    SizedBox(width: 3),
                    Flexible(
                      child: Text(
                        Provider.of<AddressModel>(context,listen: false).address.toString(),
                        style:const TextStyle(
                          color: Color(0xFFA9A9A9),
                          fontSize: 11,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){},
            child: const Text("??????",
              style: TextStyle(
                fontSize: 17,
                color: Colors.black,
              ),
            ),
          ),
          // const SizedBox(width: 5),
          IconButton(
            padding: const EdgeInsets.all(0),
            onPressed: (){},
            alignment: Alignment.center,
            icon: const Icon(IconUtil.more),
            iconSize:25,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(){
    return Container(
      height: 50,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 10,right: 10),
      color: Colors.white,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: (){
                      _selectAll();
                    },
                  padding: const EdgeInsets.all(0),
                  alignment: Alignment.center,
                  icon: Icon(_isAllSelected?IconUtil.selectedFill:IconUtil.unselected,
                    color: _isAllSelected?Colors.redAccent:Colors.grey.shade500,
                  ),
                  iconSize: 20,
                ),
                const Text("??????  "),
                Text("?????????" + _totalPrice.toStringAsFixed(2)),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: ()  async{
                cart_json.CartData data = cart_json.CartData();
                data.goods = [];
                for(Cart cart in carts){
                  for(CartItem item in cart.items!){
                    if(item.isSelected!){
                      data.goods!.add(cart_json.CartItem(
                        id: item.id, name: item.name,img: item.imageUrl,
                        price: item.price,num: item.num
                      ));
                    }
                  }
                }
                if(data.goods!.isNotEmpty){
                  await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>ConfirmOrderPage(data: data)),
                  );
                  setState(() {
                  });
                }
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25)),),
                ),
                padding: MaterialStateProperty.all(const EdgeInsets.only(left: 23,right: 23)),
                backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                elevation: MaterialStateProperty.all(3)
              ),
              child: const Text(
                "?????????",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  
  Widget _buildCartItem(BuildContext buildContext,int index){
    return Container(
      width: _screenWidth-20,
      margin: const EdgeInsets.only(left: 10,right: 10,bottom: 10,),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Container(
            height: 25,
            margin: const EdgeInsets.only(top: 5,bottom: 10),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: (){
                    _onShopCheck(carts[index]);
                  },
                  padding: const EdgeInsets.all(0),
                  icon: Icon(carts[index].isSelected!?IconUtil.selectedFill:IconUtil.unselected,
                    color: carts[index].isSelected!?Colors.redAccent:Colors.grey.shade500,
                  ),
                  iconSize: 20,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){},
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(IconUtil.shop,
                          size: 15,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 5),
                        Flexible(
                          child: Text(carts[index].shopName!,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Icon(IconUtil.arrowRight,
                          size: 10,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: carts[index].items!.map(_buildOrderItem).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(CartItem e){
    return InkWell(
      onTap: (){
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=>ProductDetailPage(id:e.id))
        );
      },
      child: Container(
        height: 115,
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: (){
                _onOrderCheck(e);
              },
              padding: const EdgeInsets.only(top: 22),
              iconSize: 20,
              icon: Icon(e.isSelected!?IconUtil.selectedFill:IconUtil.unselected,
                color: e.isSelected!?Colors.redAccent:Colors.grey.shade500,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10,right: 10),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                // child: Image.asset(e.imageUrl??defaultImage,
                //   width: 75,
                //   height: 75,
                // ),
                child: CachedNetworkImage(
                  imageUrl: e.imageUrl!,
                  width: 75,
                  height: 75,
                  placeholder: (context, url) => Icon(
                    Icons.image,
                    color: Colors.grey[300],
                    // size: MediaQuery.of(context).size.width / 2 - 10,
                  ),
                  errorWidget: (context, url, error) => Icon(
                    Icons.image,
                    color: Colors.grey[300],
                    // size: MediaQuery.of(context).size.width / 2 - 10,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 20,
                        padding: const EdgeInsets.only(left: 3),
                        child: Text(e.name!,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                          maxLines: 1,

                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 15,
                        padding: const EdgeInsets.only(left: 3,right: 3),
                        margin: const EdgeInsets.only(bottom: 10,left: 3),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          color: Color(0xFFFF0000),
                        ),
                        child: const Text("????????????",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text.rich(
                            TextSpan(
                                text: "???",
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                                children: [
                                  TextSpan(
                                    text: "${e.price!.truncate()}.",
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "${(e.price!*100%100).truncate()}",
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  )
                                ]
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          _buildCounter(e)
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onShopCheck(Cart cart){
    if(cart.isSelected!){
      cart.isSelected = false;
      for(CartItem item in cart.items!){
        item.isSelected = false;
      }
    }else{
      cart.isSelected = true;
      for(CartItem item in cart.items!){
        item.isSelected = true;
      }
    }
    _checkAllCart();
  }

  void _onOrderCheck(CartItem item){
    if(item.isSelected!){
      item.isSelected = false;
    }else{
      item.isSelected = true;
    }
    _checkAllCartItem();
  }

  void _checkAllCartItem(){
    bool isCartChecked;
    for(Cart cart in carts){
      isCartChecked = cart.isSelected!;
      if(isCartChecked){
        for(CartItem item in cart.items!){
          if(!item.isSelected!){
            cart.isSelected = false;
            _checkAllCart();
            return;
          }
        }
      }else{
        isCartChecked = true;
        for(CartItem item in cart.items!){
          if(!item.isSelected!){
            isCartChecked = false;
            break;
          }
        }
        cart.isSelected = isCartChecked;
      }
    }
    _checkAllCart();
  }

  void _checkAllCart(){
    bool isAllChecked = _isAllSelected;
    if(isAllChecked){
      for(Cart cart in carts){
        if(!cart.isSelected!){
          _isAllSelected = false;
          break;
        }
      }
    }else{
      isAllChecked = true;
      for(Cart cart in carts){
        if(!cart.isSelected!){
          isAllChecked = false;
          break;
        }
      }
      _isAllSelected = isAllChecked;
    }
    _setState();
  }

  void _selectAll(){
    if(_isAllSelected){
      _isAllSelected = false;
      for(Cart cart in carts){
        _onShopCheck(cart);
      }
    }else{
      _isAllSelected = true;
      for(Cart cart in carts){
        cart.isSelected = true;
        for(CartItem item in cart.items!){
          item.isSelected = true;
        }
      }
    }
    _setState();
  }

  void _figurePrice(){
    double total = 0;
    for(Cart cart in carts){
      for(CartItem item in cart.items!){
        if(item.isSelected!){
          total += item.price!*item.num!;
        }
      }
    }
    _totalPrice = total;
  }

  void _setState(){
    _figurePrice();
    setState(() {
    });
  }

  Widget _buildCounter(CartItem item){
    bool sub_able = item.num! > 1;
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
                      item.num = item.num!-1;
                      if(item.isSelected!){
                        _totalPrice -=item.price!;
                      }
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
                child: Text("${item.num!}",
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
                    item.num = item.num!+1;
                    if(item.isSelected!){
                      _totalPrice +=item.price!;
                    }
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
