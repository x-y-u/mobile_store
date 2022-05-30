/// 1.引入json_annotation
import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_store/model/product.dart';

part 'cart.g.dart';

@JsonSerializable()
class Cart{

  @JsonKey(name: 'recordList')
  List<CartData>? recordList;

  @JsonKey(name: 'count')
  int? count;

  Cart({this.recordList,this.count = 0});

  factory Cart.fromJson(Map<String, dynamic> srcJson) => _$CartFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CartToJson(this);

}


@JsonSerializable()
class CartData{

  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'store')
  Store? store;

  @JsonKey(name: 'goods')
  List<CartItem>? goods;

  @JsonKey(name: 'num')
  int? num;


  CartData({this.id, this.num = 0, this.store, this.goods});

  factory CartData.fromJson(Map<String, dynamic> srcJson) => _$CartDataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CartDataToJson(this);
}


@JsonSerializable()
class CartItem{

  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'picture')
  String? img;

  @JsonKey(name: 'price')
  double? price;

  @JsonKey(name: 'num')
  int? num;

  CartItem({this.id,this.name,this.img,
    this.num,this.price});

  factory CartItem.fromJson(Map<String, dynamic> srcJson) => _$CartItemFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CartItemToJson(this);

}

