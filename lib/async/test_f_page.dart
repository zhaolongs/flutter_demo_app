import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestValueNotifierPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScrollHomePageState();
  }
}

class _ScrollHomePageState extends State {
  ValueNotifier<String> _testValueNotifier = ValueNotifier<String>('');

  ValueNotifier<UserInfo> _testUserNotifier = ValueNotifier<UserInfo>(null);

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
            child: Text("测试数据"),
            onPressed: () {
              testFunction();
            },
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

        ],
      ),
    );
  }

  ValueListenableBuilder<String> buildValueListenableBuilder() {
    return ValueListenableBuilder(
      ///数据发生变化时回调
      builder: (context, value, child) {
        return Text(value);
      },
      ///监听的数据
      valueListenable: _testValueNotifier,
      child: Text(
        '未登录',
        style: TextStyle(color: Colors.red),
      ),
    );
  }

  void testFunction() {
    _testValueNotifier.value = '传递的测试数据';
  }

  void testUserFunction(){
    UserInfo userInfo = new UserInfo();
    userInfo.name='张三';
    userInfo.age = 29 ;

    _testUserNotifier.value = userInfo;
  }
}


class UserInfo {
  String name;
  int age ;
}