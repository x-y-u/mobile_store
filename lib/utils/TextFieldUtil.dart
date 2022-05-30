import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class TextFieldUtil extends StatefulWidget {
  final TextFieldType textFieldType;
  final TextEditingController? textEditingController;
  final String? hintText;
  final Widget? icon;
  final TextInputType? keyboardType;

  const TextFieldUtil({
    Key? key,
    this.textFieldType = TextFieldType.normal,
    this.textEditingController,
    this.hintText,
    this.icon,
    this.keyboardType,
  }) : super(key: key);

  @override
  State<TextFieldUtil> createState() => _TextFieldUtilState();
}

class _TextFieldUtilState extends State<TextFieldUtil> {
  bool _hideText = false;
  var _isShowPwd = false; //是否显示密码

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _hideText = widget.textFieldType == TextFieldType.password;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width-80,
      height: 45,
      alignment: Alignment.centerLeft,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color(0xFFE5E5E5),
      ),

      child: widget.textFieldType == TextFieldType.verify
      ?Container(
        height: 30,
        margin: const EdgeInsets.only(left: 12,right: 8),
        // width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: TextField(
                controller: widget.textEditingController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  icon: widget.icon??Image.asset("assets/images/inputs/input_verify.png",
                    width: 25,
                    height: 25,
                  ),
                  isCollapsed: true,
                  hintStyle: _hintTextStyle(),
                  hintText: widget.hintText,
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
                // _getVerifyCode();
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

      )
      :(
          widget.textFieldType == TextFieldType.phone
          ?Container(
            height: 30,
            margin: const EdgeInsets.only(left: 12,right: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){},
                  child: const Text("+86",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: double.infinity,
                  margin: const EdgeInsets.all(5),
                  color: const Color(0xFFA6A6A6),
                ),
                Expanded(
                  child: TextField(
                    controller: widget.textEditingController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      // icon: widget.icon??Image.asset("assets/images/inputs/input_verify.png"),
                      hintStyle: _hintTextStyle(),
                      hintText: widget.hintText,
                      border: InputBorder.none,
                      isCollapsed: true,

                    ),
                  ),
                ),
              ],
            ),
          )
          :(
              widget.textFieldType == TextFieldType.hide
              ?Container(
                height: 22,
                margin: const EdgeInsets.only(left: 12,right: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        textAlign: TextAlign.left,
                        obscureText: !_isShowPwd,
                        controller: widget.textEditingController,
                        keyboardType: widget.keyboardType??TextInputType.text,
                        decoration: InputDecoration(
                          icon: widget.icon??Image.asset("assets/images/inputs/input_password.png",
                            width: 25,
                            height: 25,
                          ),
                          hintStyle: _hintTextStyle(),
                          hintText: widget.hintText,
                          border: InputBorder.none,
                          isCollapsed: true,
                            suffixIcon: IconButton(
                              color: Color.fromRGBO(29,175,194, 1.0),
                              padding: EdgeInsets.only(bottom: 10),
                              icon: Icon(
                                  (_isShowPwd) ? Icons.visibility : Icons.visibility_off
                              ),
                              // 点击改变显示或隐藏密码
                              onPressed: () {
                                setState(() {
                                  _isShowPwd = !_isShowPwd;
                                });
                              },

                            )
                        ),

                      ),
                    ),

                  ],
                ),
              )
              :(
                  Container(
                    height: 30,
                    margin: const EdgeInsets.only(left: 12,right: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextField(
                            textAlign: TextAlign.left,
                            obscureText: _hideText,
                            controller: widget.textEditingController,
                            keyboardType: widget.keyboardType??TextInputType.text,
                            decoration: InputDecoration(
                              icon: widget.icon??Image.asset("assets/images/inputs/input_password.png",
                                width: 25,
                                height: 25,
                              ),
                              hintStyle: _hintTextStyle(),
                              hintText: widget.hintText,
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
              )
          )
      ),
    );
  }

  static TextStyle _hintTextStyle(){
    return const TextStyle(
      color: Color(0xFFA6A6A6),
      fontSize: 15,
    );
  }

  // void _getVerifyCode(){
  //   HttpUtil().get_param_requset(
  //     "/tripartite/getSms",
  //     params: {
  //       "phone":widget.textEditingController,
  //     }
  //   ).then((result){
  //     print(result);
  //   }).catchError((error){
  //     print("请求失败！");
  //   });
  // }
}

enum TextFieldType{
  password,//密码
  verify,//验证
  normal,
  phone,
  hide
}
