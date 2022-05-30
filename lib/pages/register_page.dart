import 'dart:convert';

import 'package:city_pickers/city_pickers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_store/utils/icon_util.dart';
import '../../http/HttpUtil.dart';
import '../model/product.dart';
import '../utils/TextFieldUtil.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  TextEditingController verifyCodeController = TextEditingController();//验证码
  TextEditingController phoneController = TextEditingController();//邮箱
  TextEditingController usernameController = TextEditingController();//用户名
  TextEditingController passwordController = TextEditingController();//密码

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
        child:Column(
        children: [
          const SizedBox(height: 50),
          Container(
            padding: const EdgeInsets.only(left: 10),
            margin: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                IconButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios_sharp),
                  color: Colors.black,
                  iconSize: 18,
                  padding: const EdgeInsets.all(0),
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                ),
                const Text("账号注册",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
          _textInput('请输入注册手机号/邮箱', Icon(IconUtil.account), TextFieldType.normal, phoneController),
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
                        icon: Icon(IconUtil.password),
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
          SizedBox(height: 14,),
          _textInput('账号设置', Icon(IconUtil.account), TextFieldType.password, usernameController),
          _textInput('密码设置', Icon(IconUtil.password), TextFieldType.password, passwordController),
          Container(
            margin: const EdgeInsets.only(left: 55,right: 50),
            child: const Text("备注：请将密码设置为8-20位，并且由字母、数字和符号两种以上组合，不能与旧密码相同。",
              style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF707070)
              ),
            ),
          ),
          Expanded(//注册按钮
            child: Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(bottom: 75),
              child: ElevatedButton(
                onPressed: () {
                  _register();
                },
                child: const Text("确认注册",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color(0xFFC4C4C4)),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.only(left: 80,right: 80,top: 8,bottom: 8)),
                  shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      )
                  ),
                ),
              ),
            ),
          )
        ],
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

  static TextStyle _hintTextStyle(){
    return const TextStyle(
      color: Color(0xFFA6A6A6),
      fontSize: 15,
    );
  }

  void _getVerifyCode(){
    if(phoneController.text==""){
      _showDialog('输入的邮箱格式错误');
      return;
    }
    HttpUtil().get_param_requset(
        "/user-auth/code",
        params: {
          "email":phoneController.text,
        }
    ).then((result){
        Product data = Product.fromJson(result.data);
        if(data.code==51000){
          _showDialog(data.message??'');
        }else if(data.code==20000){
          _showDialog('发送成功');
        }
    }).catchError((error){
      print(error);
    });
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

  //传json需要这样
  void _register() async{
    Map<String,dynamic> map = Map();
    map['email'] = phoneController.text;
    map["username"] = usernameController.text;
    map["password"] = passwordController.text;
    map["code"] = verifyCodeController.text;
    HttpUtil().postRequestWithJson(
      "/user-auth/register",
      data: map,
    ).then((value){
      Product product = Product.fromJson(value.data);
      if(product.code==20000){//注册成功跳转
        _showDialog('注册成功');
      }else if(product.code!=20000){
          _showDialog(product.message??'');
      }
    }).catchError((error){
      print(error);
    });

  }
}
