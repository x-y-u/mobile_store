import 'package:flutter/material.dart';
import 'package:mobile_store/pages/EditAddressPage.dart';

import '../model/address.dart';
import '../utils/icon_util.dart';

class AddressListPage extends StatefulWidget {
  const AddressListPage({Key? key}) :super(key: key);
  @override
  AddressListPageState createState() => AddressListPageState();
}

class AddressListPageState extends State<AddressListPage> {
  AddressListPageState();

  // 个人收货地址列表
  late List<AddressData> addressList;

  @override
  void initState() {
    super.initState();
    _getAddress();
  }

  void _getAddress() async{
    addressList = [
      AddressData(name: "xyu",isDefault: false,
        province: "四川",city: "成都",area: "绵阳",
        phone: "1254716754", detail: "四川大学",
      ),
      AddressData(name: "xyu",isDefault: true,
        province: "四川",city: "成都",area: "绵阳",
        phone: "1254716754", detail: "四川大学",
      ),
      AddressData(name: "xyu",isDefault: false,
        province: "四川",city: "成都",area: "绵阳",
        phone: "1254716754", detail: "四川大学",
      ),
      AddressData(name: "xyu",isDefault: false,
        province: "四川",city: "成都",area: "绵阳",
        phone: "1254716754", detail: "四川大学",
      ),
      AddressData(name: "xyu",isDefault: false,
        province: "四川",city: "成都",area: "绵阳",
        phone: "1254716754", detail: "四川大学",
      ),
    ];
    setState(() {
    });
  }

  listUI() {
    List<Widget> itemList = addressList.map((item) =>
        Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade100))),
          padding:
          EdgeInsets.only(left: 8.0, right: 8.0, top: 12.0, bottom: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(width: 5),
                          Text(
                            item.name!,
                            style: TextStyle(fontSize: 18.0),
                          ),
                          Container(
                            width: 30.0,
                          ),
                          Text(item.phone!,
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.grey)),
                          item.isDefault!
                              ? Container(
                            margin: EdgeInsets.only(left: 5.0),
                            decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(5.0))),
                            padding: EdgeInsets.only(left: 5,right: 5,top: 1,bottom: 1),
                            child: Text('默认',
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.white)),
                          )
                              : Container()
                        ],
                      ),
                      Container(
                        height: 10.0,
                      ),
                      Text(item.province! + item.city! + item.area! + item.detail!,
                          style: TextStyle(fontSize: 16.0, color: Colors.grey))
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () async {
                  AddressData data = await Navigator.of(context).push(
                      MaterialPageRoute(builder: (context)=>EditAddressPage(data: item))
                  );
                  item = data;
                  setState(() {
                  });
                },
                icon: Icon(IconUtil.edit),
                iconSize: 20,
                color: Colors.grey,
              )
            ],
          ),
        )
    ).toList();
    return itemList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(slivers: <Widget>[
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
              '收货地址',
              style: TextStyle(color: Colors.black),
            ),
            actions: <Widget>[
              IconButton(
                onPressed: (){
                  Navigator.of(context).pushNamed('add_address');
                },
                icon: const Icon(IconUtil.add),
                iconSize: 25,
                color: Colors.black,
              )
            ],
          ),
          SliverPadding(
              padding: const EdgeInsets.all(0.0),
              sliver: SliverList(
                  delegate: SliverChildListDelegate(listUI())))
        ]));
  }
}