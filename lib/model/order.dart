/// 1.引入json_annotation
import 'package:json_annotation/json_annotation.dart';

class Order{

}

class OrderData{
  String? storeName;
  int? storeId;
  int? productId;
  String? imgUrl;
  String? productName;
  double? price;
  int? num;
  int? state;

  OrderData({this.storeName, this.storeId, this.productId, this.imgUrl,
    this.productName, this.price, this.num,this.state});
}