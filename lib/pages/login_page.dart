import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_store/model/global_model/user_state.dart';
import 'package:mobile_store/utils/icon_util.dart';
import 'package:mobile_store/utils/login_util.dart';
import 'package:provider/provider.dart';

import '../http/HttpUtil.dart';
import '../model/product.dart';
import '../utils/TextFieldUtil.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin{

  TextEditingController accountNumberController = TextEditingController(text: 'chengzige');
  TextEditingController passwordController = TextEditingController(text: '123456');
  TextEditingController phoneController = TextEditingController();
  TextEditingController verifyCodeController = TextEditingController();

  TabController? _tabController;
  bool checkboxSelected = false;
  bool checkboxSelected1 = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            // 触摸收起键盘
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child:Container(
            alignment: Alignment.topCenter,
            color: Colors.white,
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(height: 200,),
                Container(
                    width: 240,
                    child: TabBar(
                        indicatorColor: Color.fromRGBO(29,175,194, 1.0),
                        labelColor: Colors.black,
                        controller: _tabController,
                        tabs: const <Widget>[
                          Tab(text: '邮箱快捷登录',),
                          Tab(text: '账号密码登录',),
                        ]
                    )
                ),
                SizedBox(height: 20,),
                Container(
                  height: 200,
                  width: double.infinity,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              _textInput('请填写邮箱地址', const Icon(IconUtil.account), TextFieldType.phone,phoneController),
                              Container(
                                width: MediaQuery.of(context).size.width-80,
                                height: 45,
                                alignment: Alignment.centerLeft,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: Color(0xFFE5E5E5),
                                ),
                                child: Container(
                                  height: 30,
                                  margin: const EdgeInsets.only(left: 12,right: 8),
                                  // width: double.infinity,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: TextField(
                                          controller: verifyCodeController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            icon: const Icon(IconUtil.password),
                                            isCollapsed: true,
                                            hintStyle: _hintTextStyle(),
                                            hintText: "验证码",
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 1,
                                        height: double.infinity,
                                        margin: const EdgeInsets.only(left: 5,right: 5),
                                        // margin: const EdgeInsets.all(5),
                                        color: const Color(0xFFA6A6A6),
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          _getVerifyCode();
                                        },
                                        child: const Text("发送验证码",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 14,),
                              GestureDetector(
                                onTap: (){
                                  Navigator.of(context).pushNamed('register');
                                },
                                child: Container(
                                    alignment: Alignment.topRight,
                                    width: double.infinity,
                                    padding: const EdgeInsets.only(right: 30),
                                    child: const Text('立即注册')
                                ),
                              )

                            ],
                          )
                      ),
                      Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              _textInput('请输入登录手机号/邮箱/账号', const Icon(IconUtil.account), TextFieldType.normal,accountNumberController),
                              _textInput('请输入登录密码', const Icon(IconUtil.password), TextFieldType.hide,passwordController),
                              Container(
                                height: 20,
                                padding: const EdgeInsets.only(left: 16,right: 30),
                                child: Row(
                                  children: [
                                    Checkbox(
                                      activeColor: const Color.fromRGBO(29,175,194, 1.0),
                                      value: checkboxSelected1,
                                      onChanged: (value) {
                                        checkboxSelected1 = !checkboxSelected1;
                                        setState(() {});
                                      },
                                      shape: CircleBorder(),//这里就是实现圆形的设置
                                    ),
                                    const Text('自动登录'),
                                    const Flexible(fit:FlexFit.tight,child: SizedBox()),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.of(context).pushNamed('forget_password');
                                      },
                                      child: const Text('忘记密码'),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 320,
                  child: Column(
                    children: [
                      Container(
                        width: 220,
                        height: 40,
                        child: RaisedButton(
                          elevation: 2,
                          color: const Color(0xFFA6A6A6),
                          colorBrightness: Brightness.light,
                          child: Text(
                            "登录",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          //async阻断指令
                          onPressed: () {
                            _login();
                          },
                        ),
                      ),
                      Container(
                          height: 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Transform.scale(
                                scale: 0.8,
                                child: Checkbox(
                                    activeColor: Color.fromRGBO(29,175,194, 1.0),
                                    value: checkboxSelected,
                                    onChanged: (value){
                                      checkboxSelected = !checkboxSelected;
                                      setState(() {});
                                    }
                                ),
                              ),

                              Expanded(child: Text('我已阅读并同意 《中国移动认证服务条款》'))
                            ],
                          )

                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }

  Widget _textInput(String hintText, Icon icon, TextFieldType type,TextEditingController controller){
    return  Container(
      margin: const EdgeInsets.only(bottom: 15),
      alignment: Alignment.center,
      child: TextFieldUtil(
        textEditingController: controller,
        textFieldType: type,
        hintText: hintText,
        icon: icon
      ),
    );
  }

  void _getVerifyCode(){
    if(phoneController.text==""){
      _showDialog('输入的手机号格式错误');
      return;
    }
    HttpUtil().get_param_requset(
        "/tripartite/getSms",
        params: {
          "phone":phoneController.text,
        }
    ).then((result){
      print(result);
    }).catchError((error){
      print("请求失败！");
    });
  }

  Future<void> _login() async {
    if(checkboxSelected==false){
      _showDialog('请阅读并勾选相关协议');
      return;
    }
    if(_tabController?.index==1){
       HttpUtil().post_requset(
          "/login",
          params: {
            "username":accountNumberController.text,
            "password":passwordController.text
          }
      ).then((result){
         if(result.data['code']==20000){//登录成功的操作
           LoginUtil.loginNewAccount(accountNumberController.text, passwordController.text);
           Provider.of<UserStateModel>(context,listen: false).login();
           Navigator.of(context).pop();
         }else{
           _showDialog(result.data['message']??"");
         }
      }).catchError((error){
        print(error);
      });


    }
    else{
      print(phoneController.text);
      print(verifyCodeController.text);
      HttpUtil().post_requset(
          "/login/parentLoginBySms",
          params: {
            "phone":phoneController.text,
            "code":verifyCodeController.text
          }
      ).then((result){
        print(result);
      }).catchError((error){
        print("请求失败！");
      });
    }
  }

  static TextStyle _hintTextStyle(){
    return const TextStyle(
      color: Color(0xFFA6A6A6),
      fontSize: 15,
    );
  }
  void _showDialog(String errorMsg) {
    Fluttertoast.showToast(
        msg: errorMsg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.black,
        backgroundColor: const Color(0x55616161)
    );
  }
}
