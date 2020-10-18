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

  /// 第一步 定义 ValueNotifier  这里传递的数据类型为 String
  ValueNotifier<String> _testValueNotifier = ValueNotifier<String>('');


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

          SizedBox(
            height: 40,
          ),
          //ValueListenableBuilder是简易版的Provider
          buildValueListenableBuilder(),
        ],
      ),
    );
  }

  ///第二步定义 数据变化后监听的 Widget
  Widget buildValueListenableBuilder() {
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

  ///第三步就是数据变化后
  void testFunction() {
    ///赋值更新
    _testValueNotifier.value = '传递的测试数据';
  }

}

