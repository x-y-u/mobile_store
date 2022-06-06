// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      code: json['code'] as int?,
      data: json['data'] == null
          ? null
          : OrderDataWithCount.fromJson(json['data'] as Map<String, dynamic>),
      flag: json['flag'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
      'flag': instance.flag,
    };

OrderDataWithCount _$OrderDataWithCountFromJson(Map<String, dynamic> json) =>
    OrderDataWithCount(
      count: json['count'] as int?,
      recordList: (json['recordList'] as List<dynamic>?)
          ?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderDataWithCountToJson(OrderDataWithCount instance) =>
    <String, dynamic>{
      'recordList': instance.recordList,
      'count': instance.count,
    };

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem(
      orderId: json['orderId'] as int?,
      goodId: json['goodId'] as int?,
      state: json['state'] as int?,
      totalPrice: (json['totalPrice'] as num?)?.toDouble(),
      storeId: json['storeId'] as int?,
      storeImg: json['storeImg'] as String?,
      storeName: json['storeName'] as String?,
      goods: json['goods'] == null
          ? null
          : Goods.fromJson(json['goods'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'orderId': instance.orderId,
      'goodId': instance.goodId,
      'state': instance.state,
      'totalPrice': instance.totalPrice,
      'storeId': instance.storeId,
      'storeImg': instance.storeImg,
      'storeName': instance.storeName,
      'goods': instance.goods,
    };

Goods _$GoodsFromJson(Map<String, dynamic> json) => Goods(
      id: json['id'] as int?,
      name: json['name'] as String?,
      picture: json['picture'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      num: json['num'] as int?,
    );

Map<String, dynamic> _$GoodsToJson(Goods instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'picture': instance.picture,
      'price': instance.price,
      'num': instance.num,
    };
