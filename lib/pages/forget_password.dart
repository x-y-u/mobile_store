import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_store/utils/icon_util.dart';

import '../../http/HttpUtil.dart';
import '../utils/TextFieldUtil.dart';


class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {

  TextEditingController verifyCodeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

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
        child: Column(
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
                  const Text("忘记密码",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
            _textInput("请输入注册手机号/邮箱", Icon(IconUtil.account), TextFieldType.normal, phoneController),
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
            _textInput("请输入新的密码", Icon(IconUtil.password), TextFieldType.password, newPasswordController),
            _textInput("确认密码", Icon(IconUtil.password), TextFieldType.password, confirmController),
            Container(
              margin: const EdgeInsets.only(left: 55,right: 50),
              child: const Text("备注：请将密码设置为8-20位，并且由字母、数字和符号两种以上组合，不能与旧密码相同。",
                style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF707070)
                ),
              ),
            ),
            Expanded(
              child:Container(
                  alignment: Alignment.bottomCenter,
                  margin: const EdgeInsets.only(bottom: 75),
                  child: ElevatedButton(
                    onPressed: () {
                      _modifyPassword();
                    },
                    child: const Text("确认修改",
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
        icon: icon,
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

  void _modifyPassword() {
    print(newPasswordController.text);
    print(confirmController.text);
    if(newPasswordController.text!=confirmController.text){
      _showDialog('新密码与确认密码不同');
      return;
    }
    HttpUtil().post_requset(
        "/register/modifyParentPassword",
        params: {
          "phone":phoneController.text,
          "password":newPasswordController.text,
          "code":verifyCodeController.text
        }
    ).then((result){
      print(result);
    }).catchError((error){
      print("请求失败！");
    });
  }
}