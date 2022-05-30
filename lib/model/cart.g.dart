// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
      code: json['code'] as int?,
      data: json['data'] == null
          ? null
          : CartData.fromJson(json['data'] as Map<String, dynamic>),
      msg: json['msg'] as String?,
    );

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'msg': instance.msg,
    };

CartData _$CartDataFromJson(Map<String, dynamic> json) => CartData(
      id: json['Id'] as int?,
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => CartItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CartDataToJson(CartData instance) => <String, dynamic>{
      'Id': instance.id,
      'Children': instance.children,
    };

CartItem _$CartItemFromJson(Map<String, dynamic> json) => CartItem(
      id: json['id'] as int?,
      goodsName: json['goodsName'] as String?,
      parentId: json['parentId'] as int?,
      img: json['Img'] as String?,
      num: json['num'] as int?,
      price: (json['price'] as num?)?.toDouble(),
      shopName: json['shopName'] as String?,
    );

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
      'id': instance.id,
      'goodsName': instance.goodsName,
      'parentId': instance.parentId,
      'Img': instance.img,
      'shopName': instance.shopName,
      'price': instance.price,
      'num': instance.num,
    };
