import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shake_animation_widget/shake_animation_widget.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/10/31.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单  抖动的登录页面

void main() {
  runApp(RootPage());
}

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<HomePage> {
  FocusNode _userNameFocusNode = new FocusNode();
  FocusNode _passwordFocusNode = new FocusNode();

  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        hindKeyBoarder();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("登录"),
        ),
        body: buildLoginWidget(),
      ),
    );
  }

  Widget buildLoginWidget() {
    return Container(
      margin: EdgeInsets.all(30.0),
      child: Column(
        children: [
          StreamBuilder<String>(
            stream: _userNameStream.stream,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              return ShakeAnimationWidget(
                //微左右的抖动
                shakeAnimationType: ShakeAnimationType.LeftRightShake,
                //设置不开启抖动
                isForward: false,
                //抖动控制器
                shakeAnimationController: _userNameAnimation,
                child: new TextField(
                  focusNode: _userNameFocusNode,
                  controller: _userNameController,
                  onSubmitted: (String value) {
                    if (checkUserName()) {
                      _userNameFocusNode.unfocus();
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    } else {
                      FocusScope.of(context).requestFocus(_userNameFocusNode);
                    }
                  },
                  //边框样式设置
                  decoration: InputDecoration(
                    errorText: snapshot.data,
                    labelText: "用户名",
                    //设置上下左右 都有边框
                    //设置四个角的弧度
                    border: OutlineInputBorder(
                      //设置边框四个角的弧度
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: 20,
          ),
          StreamBuilder<String>(
            stream: _userPasswordStream.stream,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return ShakeAnimationWidget(
                //微左右的抖动
                shakeAnimationType: ShakeAnimationType.LeftRightShake,
                //设置不开启抖动
                isForward: false,
                //抖动控制器
                shakeAnimationController: _userPasswordAnimation,
                child: new TextField(
                  focusNode: _passwordFocusNode,
                  controller: _passwordController,
                  onSubmitted: (String value) {
                    if (checkUserPassword()) {
                      loginFunction();
                    } else {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    }
                  },
                  //隐藏输入的文本
                  obscureText: true,
                  //最大可输入1行
                  maxLines: 1,
                  //边框样式设置
                  decoration: InputDecoration(
                    labelText: "密码",
                    errorText: snapshot.data,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              child: Text("登录"),
              onPressed: () {
                checkLoginFunction();
              },
            ),
          )
        ],
      ),
    );
  }

  ShakeAnimationController _userNameAnimation = new ShakeAnimationController();

  ShakeAnimationController _userPasswordAnimation =
  new ShakeAnimationController();

  StreamController<String> _userNameStream = new StreamController();
  StreamController<String> _userPasswordStream = new StreamController();

  void checkLoginFunction() {
    hindKeyBoarder();

    checkUserName();

    checkUserPassword();

    loginFunction();
  }

  bool checkUserName() {
    String userName = _userNameController.text;
    if (userName.length == 0) {
      _userNameStream.add("请输入用户名");
      _userNameAnimation.start();
      return false;
    } else {
      _userNameStream.add(null);
      return true;
    }
  }

  bool checkUserPassword() {
    String userPassrowe = _passwordController.text;
    if (userPassrowe.length < 6) {
      _userPasswordStream.add("请输入标准密码");
      _userPasswordAnimation.start();
      return false;
    } else {
      _userPasswordStream.add(null);
      return true;
    }
  }

  void hindKeyBoarder() {
    //失去焦点
    _userNameFocusNode.unfocus();
    _passwordFocusNode.unfocus();

    //隐藏键盘
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  void loginFunction() {}
}
