import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_store/model/address.dart';

import '../utils/icon_util.dart';

class EditAddressPage extends StatefulWidget {
  final AddressData data;
  const EditAddressPage({Key? key,required this.data}) : super(key: key);

  @override
  State<EditAddressPage> createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {

  late AddressData _data;

  bool isDefault = false; // 是否默认地址
  String province = ''; // 省
  String city = ''; // 市
  String area = ''; // 县

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController detailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _data = widget.data;
    province = _data.province!;
    city = _data.city!;
    area = _data.area!;
    nameController.text = _data.name!;
    phoneController.text = _data.phone!;
    detailController.text = _data.detail!;
    isDefault = _data.isDefault!;
  }

  // 新增
  check() async {
    if(nameController.text == ''){
      Fluttertoast.showToast(
        msg: "请输入姓名",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.black,
        backgroundColor: const Color(0x55616161),
      );
      return;
    }
    if(phoneController.text == ''){
      Fluttertoast.showToast(
        msg: "请输入手机号码",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.black,
        backgroundColor: const Color(0x55616161),
      );
      return;
    }
    if(detailController.text == ''){
      Fluttertoast.showToast(
        msg: "请输入详细地址",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.black,
        backgroundColor: const Color(0x55616161),
      );
      return;
    }
    if(province == ''){
      Fluttertoast.showToast(
        msg: "请选择地区",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.black,
        backgroundColor: const Color(0x55616161),
      );
      return;
    }
    _data.detail = detailController.text;
    _data.phone = phoneController.text;
    _data.name = nameController.text;
    _data.province = province;
    _data.city = city;
    _data.area = area;
    _data.isDefault = isDefault;
    Navigator.of(context).pop(_data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          // 触摸收起键盘
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: CustomScrollView(slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0.0,
            leading: IconButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              icon: const Icon(IconUtil.arrowLeft),
              iconSize: 18,
              color: Colors.black,
              padding: const EdgeInsets.all(0),
            ),
            title: const Text(
              '新增收货地址',
              style: TextStyle(color: Colors.black,
                fontSize: 18,
              ),
            ),
            actions: <Widget>[],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(0.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey.shade100)))),
                  _buildInputRow("收货人", "输入姓名", nameController),
                  _buildInputRow("手机号码", "输入手机号码",
                      detailController,type: TextInputType.number),
                  _buildInputRow("详细地址", "街道、楼牌号等", phoneController),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 55.0,
                    decoration: BoxDecoration(
                        border:
                        Border(bottom: BorderSide(color: Colors.grey.shade100))),
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Text('所在地区'),
                        InkWell(
                          onTap: () async {
                            Result? result = await CityPickers.showCityPicker(
                                context: context,
                                height: 300.0
                            );
                            print(result);
                            setState(() {
                              province = result!.provinceName!;
                              city = result.cityName!;
                              area = result.areaName!;
                            });
                          },
                          child: Text(
                            province == ''
                                ? '选择地区'
                                : '$province,$city,$area',
                            style: const TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border:
                        Border(bottom: BorderSide(color: Colors.grey.shade100))),
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text('设为默认'),
                        Switch(
                            value: isDefault,
                            onChanged: (bool newValue) {
                              setState(() {
                                isDefault = newValue;
                              });
                            })
                      ],
                    ),
                  ),
                  Container(
                    height: 30.0,
                  ),
                  InkWell(
                    onTap: () {
                      check();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width - 30,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        color: Colors.redAccent,
                      ),
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                      height: 42.0,
                      child: const Text(
                        '确认修改',
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        ),
      ),
    );
  }

  Widget _buildInputRow(String title,String hint,TextEditingController controller,
      {TextInputType type = TextInputType.text}){
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border:
          Border(bottom: BorderSide(color: Colors.grey.shade100))),
      padding: const EdgeInsets.only(
          left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(title),
          ),
          Expanded(
            flex: 4,
            child: TextField(
                keyboardType: type,
                controller: controller,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                    hintText: hint, border: InputBorder.none)),
          )
        ],
      ),
    );
  }
}
