
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product{

  @JsonKey(name: 'code')
  int? code;

  @JsonKey(name: 'data')
  ProductDataWithCount? data;

  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'flag')
  bool? flag;

  Product({this.code, this.data, this.message, this.flag});

  factory Product.fromJson(Map<String, dynamic> srcJson) => _$ProductFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable()
class ProductDataWithCount{

  @JsonKey(name: 'recordList')
  List<ProductData>? data;

  @JsonKey(name: 'count')
  int? count;

  ProductDataWithCount({this.data, this.count});

  factory ProductDataWithCount.fromJson(Map<String, dynamic> srcJson) => _$ProductDataWithCountFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProductDataWithCountToJson(this);
}

@JsonSerializable()
class ProductData{
  @JsonKey(name: 'picture')
  String? picture;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'price')
  double? price;

  @JsonKey(name: 'sales')
  int? sales;

  @JsonKey(name: 'storeId')
  int? storeId;

  @JsonKey(name: 'store')
  Store? store;

  @JsonKey(name: 'collection')
  bool? collection;

  ProductData({this.picture, this.name, this.id, this.price,
    this.sales, this.storeId,this.collection,this.store});

  factory ProductData.fromJson(Map<String, dynamic> srcJson) => _$ProductDataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProductDataToJson(this);
}

@JsonSerializable()
class Store{
  @JsonKey(name: 'address')
  String? address;
  @JsonKey(name: 'focusNum')
  int? focusNum;
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'level')
  int? level;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'storeImg')
  String? storeImg;

  Store({this.address, this.focusNum, this.id, this.level, this.name,
      this.storeImg});

  factory Store.fromJson(Map<String, dynamic> srcJson) => _$StoreFromJson(srcJson);

  Map<String, dynamic> toJson() => _$StoreToJson(this);
}

@JsonSerializable()
class ProductDetail{
  @JsonKey(name: 'code')
  int? code;

  @JsonKey(name: 'data')
  ProductData? data;

  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'flag')
  bool? flag;

  ProductDetail({this.code, this.data, this.flag,this.message});

  factory ProductDetail.fromJson(Map<String, dynamic> srcJson) => _$ProductDetailFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProductDetailToJson(this);
}