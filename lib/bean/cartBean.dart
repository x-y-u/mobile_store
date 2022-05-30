
class Cart{
  String? shopId;
  String? shopName;
  List<CartItem>? items;
  bool? isSelected;
  Cart({this.shopId,this.shopName,this.items,this.isSelected = false});
}

class CartItem{
  int? id;
  String? name;
  String? category;
  double? price;
  int? num;
  String? imageUrl;
  bool? isSelected;
  CartItem({this.id,this.name,this.category,this.imageUrl,this.num = 1,this.price,this.isSelected = false});
}