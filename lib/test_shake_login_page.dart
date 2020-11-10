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
  //用户名输入框的焦点控制
  FocusNode _userNameFocusNode = new FocusNode();
  FocusNode _passwordFocusNode = new FocusNode();

  //文本输入框控制器
  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  //抖动动画控制器
  ShakeAnimationController _userNameAnimation = new ShakeAnimationController();

  ShakeAnimationController _userPasswordAnimation =
      new ShakeAnimationController();

  //Stream 更新操作控制器
  StreamController<String> _userNameStream = new StreamController();
  StreamController<String> _userPasswordStream = new StreamController();

  @override
  Widget build(BuildContext context) {
    //手势识别点击空白隐藏键盘
    return GestureDetector(
      onTap: () {
        hindKeyBoarder();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("登录"),
        ),
        //登录页面的主体
        body: buildLoginWidget(),
      ),
    );
  }

//登录页面的主体
  Widget buildLoginWidget() {
    return Container(
      margin: EdgeInsets.all(30.0),
      //线性布局
      child: Column(
        children: [
          //用户名输入框
          buildUserNameWidget(),
          SizedBox(
            height: 20,
          ),
          //用户密码输入框
          buildUserPasswordWidget(),
          SizedBox(
            height: 40,
          ),
          //登录按钮
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

  StreamBuilder<String> buildUserPasswordWidget() {
    return StreamBuilder<String>(
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
    );
  }

  ///用户名输入框 Stream 局部更新 error提示
  ///     ShakeAnimationWidget 抖动动画
  ///
  StreamBuilder<String> buildUserNameWidget() {
    return StreamBuilder<String>(
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
            //焦点控制
            focusNode: _userNameFocusNode,
            //文本控制器
            controller: _userNameController,
            //键盘回车键点击回调
            onSubmitted: (String value) {
              //点击校验，如果有内容输入 输入焦点跳入下一个输入框
              if (checkUserName()) {
                _userNameFocusNode.unfocus();
                FocusScope.of(context).requestFocus(_passwordFocusNode);
              } else {
                FocusScope.of(context).requestFocus(_userNameFocusNode);
              }
            },
            //边框样式设置
            decoration: InputDecoration(
              //红色的错误提示文本
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
    );
  }

  void checkLoginFunction() {
    hindKeyBoarder();

    checkUserName();

    checkUserPassword();

    loginFunction();
  }

  bool checkUserName() {
    //获取输入框中的输入文本
    String userName = _userNameController.text;
    if (userName.length == 0) {
      //Stream 事件流更新提示文案
      _userNameStream.add("请输入用户名");
      //抖动动画开启
      _userNameAnimation.start();
      return false;
    } else {
      //清除错误提示
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
    //输入框失去焦点
    _userNameFocusNode.unfocus();
    _passwordFocusNode.unfocus();

    //隐藏键盘
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  void loginFunction() {}
}
