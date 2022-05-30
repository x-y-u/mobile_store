/// 1.引入json_annotation
import 'package:json_annotation/json_annotation.dart';

part 'cart.g.dart';

@JsonSerializable()
class Cart{

  @JsonKey(name: 'code')
  int? code;

  @JsonKey(name: 'data')
  CartData? data;

  @JsonKey(name: 'msg')
  String? msg;

  Cart({this.code,this.data,this.msg});

  factory Cart.fromJson(Map<String, dynamic> srcJson) => _$CartFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CartToJson(this);

}


@JsonSerializable()
class CartData{

  @JsonKey(name: 'Id')
  int? id;

  @JsonKey(name: 'Children')
  List<CartItem>? children;

  CartData({this.id = 0, this.children});

  factory CartData.fromJson(Map<String, dynamic> srcJson) => _$CartDataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CartDataToJson(this);
}


@JsonSerializable()
class CartItem{

  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'goodsName')
  String? goodsName;

  @JsonKey(name: 'parentId')
  int? parentId;

  @JsonKey(name: 'Img')
  String? img;

  @JsonKey(name: 'shopName')
  String? shopName;

  @JsonKey(name: 'price')
  double? price;

  @JsonKey(name: 'num')
  int? num;

  CartItem({this.id,this.goodsName,this.parentId,this.img,
    this.num,this.price,this.shopName});

  factory CartItem.fromJson(Map<String, dynamic> srcJson) => _$CartItemFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CartItemToJson(this);

}

