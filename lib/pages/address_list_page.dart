import 'package:flutter/material.dart';

import '../model/address.dart';

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
    addressList = [];
    setState(() {
    });
  }

  listUI() {
    List<Widget> itemList = [];
    addressList.map((item) {
      itemList.add(
        Dismissible(
          direction: DismissDirection.endToStart,
          key: Key(item.id.toString()),
          secondaryBackground: Container(
            color: Colors.red,
            padding: const EdgeInsets.only(right: 20.0),
            alignment: Alignment.centerRight,
            child: const Icon(Icons.delete,color: Colors.white,),
          ),
          background: Container(
            alignment: Alignment.centerRight,
            color: Colors.green,
            child: const Icon(Icons.delete),
          ),
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.endToStart) {
              showDialog(
                  context: context,
                  builder:(BuildContext context){
                    return AlertDialog(
                      title: Text('提示'),
                      content: Text("确定删除？"),
                      actions: <Widget>[
                        new FlatButton(
                          child: new Text('取消'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        new FlatButton(
                          child: new Text('确定'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  }
              );
            }
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey.shade100))),
            padding:
            EdgeInsets.only(left: 8.0, right: 8.0, top: 12.0, bottom: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
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
                          item.isDefault == 1
                              ? Container(
                            margin: EdgeInsets.only(left: 3.0),
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(5.0))),
                            padding: EdgeInsets.all(2.0),
                            child: Text('默认',
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.white)),
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
                )
              ],
            ),
          ),
        ),
      );
    }).toList();
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
            title: Text(
              '收货地址',
              style: TextStyle(color: Colors.black),
            ),
            actions: <Widget>[
              Align(
                child: Container(
                  margin: const EdgeInsets.only(right: 10.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('add_address')
                          .then((value) {
                         setState(() {
                         });
                      });
                    },
                    child: const Text(
                      '新增地址',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SliverPadding(
              padding: const EdgeInsets.all(0.0),
              sliver: SliverList(
                  delegate: SliverChildListDelegate(listUI())))
        ]));
  }
}