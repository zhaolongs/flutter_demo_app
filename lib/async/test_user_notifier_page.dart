import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestUserNotifierPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScrollHomePageState();
  }
}

class _ScrollHomePageState extends State {

  UserNotifier _testUserNotifier = UserNotifier(UserInfo(name: "", age: 0));

  @override
  Widget build(BuildContext context) {
    ///页面主体脚手架
    return Scaffold(
      appBar: AppBar(
        title: Text("测试"),
      ),

      /// 处理滑动
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),

          OutlineButton(
            child: Text("测试用户数据"),
            onPressed: () {
              testUserFunction();
            },
          ),
          SizedBox(
            height: 40,
          ),
          //ValueListenableBuilder是简易版的Provider
          buildUserListenableBuilder(),
        ],
      ),
    );
  }

  ///第二步 定义
  Widget buildUserListenableBuilder() {
    return ValueListenableBuilder(
      ///数据发生变化时回调
      builder: (context, value, child) {
        String message = "--";
        if (value != null) {
          message = "姓名是：${value.name}  年龄是: ${value.age}";
        }
        return Text(message);
      },

      ///监听的数据
      valueListenable: _testUserNotifier,
    );
  }

  void testUserFunction() {
    _testUserNotifier.setName("李四");
  }
}

class UserInfo {
  String name;
  int age;

  UserInfo({this.name, this.age});
}

///自定义 ValueNotifier
/// UserInfo 为数据类型
class UserNotifier extends ValueNotifier<UserInfo> {
  UserNotifier(UserInfo userInfo) : super(userInfo);

  void setName(String name) {
    ///赋值
    value.name = name;

    ///通知更新
    notifyListeners();
  }
}
