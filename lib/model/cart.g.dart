// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
      code: json['code'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CartData.fromJson(e as Map<String, dynamic>))
          .toList(),
      msg: json['msg'] as String?,
      total: json['total'] as int?,
    );

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'msg': instance.msg,
      'total': instance.total,
    };

CartData _$CartDataFromJson(Map<String, dynamic> json) => CartData(
      id: json['Id'] as int?,
      shopName: json['shopName'] as String?,
      img: json['Img'] as String?,
      children: (json['Children'] as List<dynamic>?)
          ?.map((e) => Children.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CartDataToJson(CartData instance) => <String, dynamic>{
      'Id': instance.id,
      'shopName': instance.shopName,
      'Img': instance.img,
      'Children': instance.children,
    };

Children _$ChildrenFromJson(Map<String, dynamic> json) => Children(
      id: json['Id'] as int?,
      goodsName: json['goodsName'] as String?,
      parentId: json['ParentId'] as int?,
      img: json['Img'] as String?,
    );

Map<String, dynamic> _$ChildrenToJson(Children instance) => <String, dynamic>{
      'Id': instance.id,
      'goodsName': instance.goodsName,
      'ParentId': instance.parentId,
      'Img': instance.img,
    };
