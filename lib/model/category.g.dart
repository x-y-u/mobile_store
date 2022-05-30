// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      code: json['code'] as int?,
      data: json['data'] == null
          ? null
          : CategoryDataWithCount.fromJson(
              json['data'] as Map<String, dynamic>),
      flag: json['flag'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
      'flag': instance.flag,
    };

CategoryDataWithCount _$CategoryDataWithCountFromJson(
        Map<String, dynamic> json) =>
    CategoryDataWithCount(
      data: (json['recordList'] as List<dynamic>?)
          ?.map((e) => CategoryData.fromJson(e as Map<String, dynamic>))
          .toList(),
      count: json['count'] as int?,
    );

Map<String, dynamic> _$CategoryDataWithCountToJson(
        CategoryDataWithCount instance) =>
    <String, dynamic>{
      'recordList': instance.data,
      'count': instance.count,
    };

CategoryData _$CategoryDataFromJson(Map<String, dynamic> json) => CategoryData(
      id: json['id'] as int?,
      title: json['name'] as String?,
    );

Map<String, dynamic> _$CategoryDataToJson(CategoryData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.title,
    };
