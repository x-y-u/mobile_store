import 'package:flutter/material.dart';

import '../utils/icon_util.dart';

class AccountSettingPage extends StatefulWidget {
  const AccountSettingPage({Key? key}) : super(key: key);

  @override
  State<AccountSettingPage> createState() => _AccountSettingPageState();
}

class _AccountSettingPageState extends State<AccountSettingPage> {
  late final double _screenWidth = MediaQuery.of(context).size.width;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Container(
            height: 75,
            color: Colors.white,
            child: InkWell(
              onTap: (){},
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text("头像",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(90)),
                    child: Image.asset("assets/images/head_image1.jpg",width: 55,height: 55,),
                  ),
                  const SizedBox(width: 5),
                  Icon(IconUtil.arrowRight,
                    size: 16,
                    color: Colors.grey.shade500,
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ),
          _buildDevider(),
          _buildSettingItem("用户名", "chengzige", false, () { }),
          _buildDevider(),
          _buildSettingItem("昵称", "一名不愿透漏姓名的用户", true, () { }),
          _buildDevider(),
          _buildSettingItem("性别", "保密", true, () { }),
          _buildDevider(),
          _buildSettingItem("出生日期", "", true, () { })
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(){
    return PreferredSize(
      preferredSize: Size(_screenWidth,50),
      child: Container(
        color: Colors.redAccent,
        padding: const EdgeInsets.only(top: 30),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child:IconButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                icon: const Icon(IconUtil.arrowLeft),
                iconSize: 18,
                color: Colors.white,
              ),
            ),
            const Align(
              alignment: Alignment.center,
              child: Text("个人信息",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDevider(){
    return Container(
      height: 0.6,
      width: _screenWidth,
      color: Colors.grey.shade200,
    );
  }

  Widget _buildSettingItem(String option,String content,bool isShowArrow,GestureTapCallback onTap){
    return Container(
      height: 45,
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            const SizedBox(width: 12),
            Expanded(
              child: Text(option,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            Text(content,
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 13,
              ),
            ),
            const SizedBox(width: 5),
            isShowArrow ?Icon(IconUtil.arrowRight,
              size: 16,
              color: Colors.grey.shade500,
            )
            :const SizedBox(width: 16),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }

}
