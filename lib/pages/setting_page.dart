import 'package:flutter/material.dart';
import 'package:mobile_store/utils/icon_util.dart';
import 'package:mobile_store/utils/no_ripple_scroll_behavior.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late final double _screenWidth = MediaQuery.of(context).size.width;

  List<Map> options2 = [
    {
      "label":"账户与安全",
      "route":""
    },
    {
      "label":"设置字体大小",
      "route":""
    },
    {
      "label":"支付设置",
      "route":""
    },
    {
      "label":"发票抬头管理",
      "route":""
    },
    {
      "label":"我的档案",
      "route":""
    },
    {
      "label":"通用",
      "route":""
    },
  ];
  List<Map> options3 = [
    {
      "label":"PLUS会员",
      "route":""
    },
    {
      "label":"家庭号设置",
      "route":""
    },
    {
      "label":"功能实验室",
      "route":""
    },
    {
      "label":"功能反馈",
      "route":""
    },
    {
      "label":"关于京东APP",
      "route":""
    },
    {
      "label":"隐私政策简要版",
      "route":""
    },
    {
      "label":"个人信息收集清单",
      "route":""
    },
    {
      "label":"应用权限说明",
      "route":""
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: _buildAppBar(),
        body: ScrollConfiguration(
          behavior: NoRippleScrollBehavior(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildContent1(),
                _buildContent2(),
                _buildContent3(),
                _buildLogoutButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(){
    return PreferredSize(
      preferredSize: Size(_screenWidth,60),
      child: Container(
        color: Colors.redAccent,
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
                color: Colors.black,
              ),
            ),
            const Align(
              alignment: Alignment.center,
              child: Text("账户设置",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildContent1(){
    return Container(
      width: _screenWidth,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 90,
            child: InkWell(
              onTap: (){
                Navigator.of(context).pushNamed('account_setting');
              },
              child: Row(
                children: [
                  Expanded(
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(90)),
                        child: Image.asset("assets/images/head_image1.jpg"),
                      ),
                      title: const Text("标题"),
                      subtitle: const Text("content"),
                    ),
                  ),
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
          _buildSettingItem("地址管理", ""),
        ],
      ),
    );
  }

  Widget _buildContent2(){
    return Container(
      width: _screenWidth,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Column(
            children: options2.map((e) =>
                Column(
                  children: [
                    _buildSettingItem(e["label"], e["route"]),
                    _buildDevider(),
                  ],
                )
            ).toList()
          ),
          _buildSettingItem("长辈版", ""),
        ],
      ),
    );
  }

  Widget _buildContent3(){
    return Container(
      width: _screenWidth,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Column(
              children: options3.map((e) =>
                  Column(
                    children: [
                      _buildSettingItem(e["label"], e["route"]),
                      _buildDevider(),
                    ],
                  )
              ).toList()
          ),
          _buildSettingItem("第三方共享个人信息清单", ""),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(){
    return InkWell(
      child:Container(
        width: _screenWidth,
        height: 45,
        margin: const EdgeInsets.only(bottom: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white,
        ),
        alignment: Alignment.center,
        child: const Text("退出登录",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
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

  Widget _buildSettingItem(String option,String route){
    return SizedBox(
      height: 45,
      child: InkWell(
        onTap: (){
          if(route.isNotEmpty){
            Navigator.of(context).pushNamed(route);
          }else{

          }
        },
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
            Icon(IconUtil.arrowRight,
              size: 16,
              color: Colors.grey.shade500,
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }

}
