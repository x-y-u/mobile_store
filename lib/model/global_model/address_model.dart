

import 'package:flutter/cupertino.dart';
import 'package:mobile_store/model/address.dart';

class AddressModel with ChangeNotifier{
  AddressData _address = AddressData(province: "四川省",
    city: "宜宾市",area: "南溪区",name: "某处"
  );

  get address => _address;

  void setAddress(AddressData value){
    _address = value;
  }

}