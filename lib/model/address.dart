

class Address{

}

class AddressData{
  int? id;

  int? userId;

  String? name;

  bool? isDefault;

  String? province;

  String? city;

  String? area;

  String? detail;

  String? phone;

  String toString(){
    return province! + city! + area! + name!;
  }

  AddressData({this.id, this.userId, this.name = "", this.isDefault = false, this.province = "",
      this.city = "", this.area = "", this.detail = "", this.phone = ""});
}