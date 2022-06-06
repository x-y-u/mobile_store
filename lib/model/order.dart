/// 1.引入json_annotation
import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class Order{
  @JsonKey(name: 'code')
  int? code;

  @JsonKey(name: 'data')
  OrderDataWithCount? data;

  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'flag')
  bool? flag;

  Order({this.code, this.data, this.flag,this.message});

  factory Order.fromJson(Map<String, dynamic> srcJson) => _$OrderFromJson(srcJson);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}


@JsonSerializable()
class OrderDataWithCount{
  @JsonKey(name: 'recordList')
  List<OrderItem>? recordList;

  @JsonKey(name: 'count')
  int? count;

  OrderDataWithCount({this.count, this.recordList});

  factory OrderDataWithCount.fromJson(Map<String, dynamic> srcJson) => _$OrderDataWithCountFromJson(srcJson);

  Map<String, dynamic> toJson() => _$OrderDataWithCountToJson(this);
}

@JsonSerializable()
class OrderItem{
  @JsonKey(name: 'orderId')
  int? orderId;

  @JsonKey(name: 'goodId')
  int? goodId;

  @JsonKey(name: 'state')
  int? state;

  @JsonKey(name: 'totalPrice')
  double? totalPrice;

  @JsonKey(name: 'storeId')
  int? storeId;

  @JsonKey(name: 'storeImg')
  String? storeImg;

  @JsonKey(name: 'storeName')
  String? storeName;

  @JsonKey(name: 'goods')
  Goods? goods;

  OrderItem({this.orderId, this.goodId, this.state, this.totalPrice, this.storeId, this.storeImg, this.storeName, this.goods});

  factory OrderItem.fromJson(Map<String, dynamic> srcJson) => _$OrderItemFromJson(srcJson);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}

@JsonSerializable()
class Goods{
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'picture')
  String? picture;

  @JsonKey(name: 'price')
  double? price;

  @JsonKey(name: 'num')
  int? num;


  Goods({this.id, this.name, this.picture, this.price, this.num});

  factory Goods.fromJson(Map<String, dynamic> srcJson) => _$GoodsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$GoodsToJson(this);
}