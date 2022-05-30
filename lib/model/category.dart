/// 1.引入json_annotation
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category{
  @JsonKey(name: 'code')
  int? code;

  @JsonKey(name: 'data')
  CategoryDataWithCount? data;

  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'flag')
  bool? flag;

  Category({this.code, this.data, this.flag,this.message});

  factory Category.fromJson(Map<String, dynamic> srcJson) => _$CategoryFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

}

@JsonSerializable()
class CategoryDataWithCount{
  @JsonKey(name: 'recordList')
  List<CategoryData>? data;

  @JsonKey(name: 'count')
  int? count;

  CategoryDataWithCount({this.data, this.count});

  factory CategoryDataWithCount.fromJson(Map<String, dynamic> srcJson) => _$CategoryDataWithCountFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CategoryDataWithCountToJson(this);
}

@JsonSerializable()
class CategoryData{

  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'name')
  String? title;

  CategoryData({this.id,this.title});

  factory CategoryData.fromJson(Map<String, dynamic> srcJson) => _$CategoryDataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CategoryDataToJson(this);
}