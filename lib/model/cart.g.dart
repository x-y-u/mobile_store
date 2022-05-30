// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
      recordList: (json['recordList'] as List<dynamic>?)
          ?.map((e) => CartData.fromJson(e as Map<String, dynamic>))
          .toList(),
      count: json['count'] as int? ?? 0,
    );

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'recordList': instance.recordList,
      'count': instance.count,
    };

CartData _$CartDataFromJson(Map<String, dynamic> json) => CartData(
      id: json['id'] as int?,
      num: json['num'] as int? ?? 0,
      store: json['store'] == null
          ? null
          : Store.fromJson(json['store'] as Map<String, dynamic>),
      goods: (json['goods'] as List<dynamic>?)
          ?.map((e) => CartItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CartDataToJson(CartData instance) => <String, dynamic>{
      'id': instance.id,
      'store': instance.store,
      'goods': instance.goods,
      'num': instance.num,
    };

CartItem _$CartItemFromJson(Map<String, dynamic> json) => CartItem(
      id: json['id'] as int?,
      name: json['name'] as String?,
      img: json['picture'] as String?,
      num: json['num'] as int?,
      price: (json['price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'picture': instance.img,
      'price': instance.price,
      'num': instance.num,
    };
