import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_store/model/product.dart';
import 'package:mobile_store/utils/toast_util.dart';

import '../http/HttpUtil.dart';
import '../pages/prtoduct_details_page.dart';
import '../utils/icon_util.dart';

class ProductListItem extends StatefulWidget {

  final ProductData data;

  final bool multiple;
  const ProductListItem({Key? key, required this.multiple,required this.data}) : super(key: key);

  @override
  State<ProductListItem> createState() => _ProductListItemState();
}

class _ProductListItemState extends State<ProductListItem> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: (){
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=>ProductDetailPage(id:widget.data.id))
        );
      },
      child: widget.multiple?Container(
        width: screenWidth-10,
        // decoration: BoxDecoration(
        //   border: Border.all(color: Colors.grey.shade500,width: 0.5)
        // ),
        margin: const EdgeInsets.all(5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              child: CachedNetworkImage(
                imageUrl: widget.data.picture!,
                width: (screenWidth-10)/2.5,
                height: (screenWidth-10)/2.5,
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
            const SizedBox(width: 5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 40,
                    padding: const EdgeInsets.only(left: 3),
                    margin: const EdgeInsets.only(top: 10,bottom: 20),
                    child: Text(widget.data.name!,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        Text.rich(
                          TextSpan(
                              text: "￥",
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                              children: [
                                TextSpan(
                                  text: "${widget.data.price!.truncate()}.",
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                TextSpan(
                                  text: "${(widget.data.price!*100%100).truncate()}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                )
                              ]
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        InkWell(
                          onTap: (){
                            _addCart(widget.data.id!);
                            ToastUtil.makeToast("已成功加入购物车");
                          },
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(90)),
                            child: Container(
                              height: 37,
                              width: 37,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(90)),
                                color: Colors.grey.shade300,
                              ),
                              child: const Icon(
                                IconUtil.cart,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ) :Container(
        width: (screenWidth-20)/2,
        height: (screenWidth-20)/1.3,
        margin: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: Column(
            children: [
              CachedNetworkImage(
                imageUrl: widget.data.picture!,
                width: (screenWidth-20)/2,
                height: (screenWidth-20)/2,
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
              const SizedBox(width: 5),
              Container(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.data.name!,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Container(
                      height: 30,
                      margin: const EdgeInsets.only(bottom: 3),
                      alignment: Alignment.centerLeft,
                      child: Text.rich(
                        TextSpan(
                            text: "￥",
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                            children: [
                              TextSpan(
                                text: "${widget.data.price!.truncate()}.",
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              TextSpan(
                                text: "${(widget.data.price!*100%100).truncate()}",
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              )
                            ]
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // 加入购物车
  void _addCart(int? id) async {
    HttpUtil().get_param_requset(
        "/shopping-cart/${id}",
        method: 'put',
        params: {
          'num':1
        }
    ).catchError((error){
      print(error);
    });
  }

}
