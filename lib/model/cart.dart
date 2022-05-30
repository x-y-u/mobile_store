/// 1.引入json_annotation
import 'package:json_annotation/json_annotation.dart';

part 'cart.g.dart';

@JsonSerializable()
class Cart{

  @JsonKey(name: 'code')
  int? code;

  @JsonKey(name: 'data')
  List<CartData>? data;

  @JsonKey(name: 'msg')
  String? msg;

  @JsonKey(name: 'total')
  int? total;

  Cart({this.code,this.data,this.msg,this.total});

  factory Cart.fromJson(Map<String, dynamic> srcJson) => _$CartFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CartToJson(this);

}


@JsonSerializable()
class CartData{

  @JsonKey(name: 'Id')
  int? id;

  @JsonKey(name: 'shopName')
  String? shopName;

  @JsonKey(name: 'Img')
  String? img;

  @JsonKey(name: 'Children')
  List<Children>? children;

  CartData({this.id,this.shopName,this.img,this.children});

  factory CartData.fromJson(Map<String, dynamic> srcJson) => _$CartDataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CartDataToJson(this);
}


@JsonSerializable()
class Children{

  @JsonKey(name: 'Id')
  int? id;

  @JsonKey(name: 'goodsName')
  String? goodsName;

  @JsonKey(name: 'ParentId')
  int? parentId;

  @JsonKey(name: 'Img')
  String? img;

  Children({this.id,this.goodsName,this.parentId,this.img});

  factory Children.fromJson(Map<String, dynamic> srcJson) => _$ChildrenFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ChildrenToJson(this);

}

