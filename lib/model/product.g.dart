// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      code: json['code'] as int?,
      data: json['data'] == null
          ? null
          : ProductDataWithCount.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
      flag: json['flag'] as bool?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
      'flag': instance.flag,
    };

ProductDataWithCount _$ProductDataWithCountFromJson(
        Map<String, dynamic> json) =>
    ProductDataWithCount(
      data: (json['recordList'] as List<dynamic>?)
          ?.map((e) => ProductData.fromJson(e as Map<String, dynamic>))
          .toList(),
      count: json['count'] as int?,
    );

Map<String, dynamic> _$ProductDataWithCountToJson(
        ProductDataWithCount instance) =>
    <String, dynamic>{
      'recordList': instance.data,
      'count': instance.count,
    };

ProductData _$ProductDataFromJson(Map<String, dynamic> json) => ProductData(
      picture: json['picture'] as String?,
      name: json['name'] as String?,
      id: json['id'] as int?,
      price: (json['price'] as num?)?.toDouble(),
      sales: json['sales'] as int?,
      storeId: json['storeId'] as int?,
      collection: json['collection'] as bool?,
      store: json['store'] == null
          ? null
          : Store.fromJson(json['store'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductDataToJson(ProductData instance) =>
    <String, dynamic>{
      'picture': instance.picture,
      'name': instance.name,
      'id': instance.id,
      'price': instance.price,
      'sales': instance.sales,
      'storeId': instance.storeId,
      'store': instance.store,
      'collection': instance.collection,
    };

Store _$StoreFromJson(Map<String, dynamic> json) => Store(
      address: json['address'] as String?,
      focusNum: json['focusNum'] as int?,
      id: json['id'] as int?,
      level: json['level'] as int?,
      name: json['name'] as String?,
      storeImg: json['storeImg'] as String?,
    );

Map<String, dynamic> _$StoreToJson(Store instance) => <String, dynamic>{
      'address': instance.address,
      'focusNum': instance.focusNum,
      'id': instance.id,
      'level': instance.level,
      'name': instance.name,
      'storeImg': instance.storeImg,
    };

ProductDetail _$ProductDetailFromJson(Map<String, dynamic> json) =>
    ProductDetail(
      code: json['code'] as int?,
      data: json['data'] == null
          ? null
          : ProductData.fromJson(json['data'] as Map<String, dynamic>),
      flag: json['flag'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ProductDetailToJson(ProductDetail instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
      'flag': instance.flag,
    };
