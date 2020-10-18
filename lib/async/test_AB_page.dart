import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/test_widget_live_widget.dart';

class TestABPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TestABPageState();
  }
}

class _TestABPageState extends State {
  ///页面B返回的数据
  String _message = "--";

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
            child: Text("打开页面B"),
            onPressed: () {
              ///以动态路由的方式打开
              openPageFunction(context);
            },
          ),
          SizedBox(
            height: 40,
          ),
          //ValueListenableBuilder是简易版的Provider
          Text("页面B返回的数据 : $_message")
        ],
      ),
    );
  }
  ///代码清单 1-1 
  void openPageFunction(BuildContext context) {
    ///以动态路由的方式打开
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return TestBPage();
        },
      ),
      ///页面 TestBPage 关闭后会回调 then 函数
      ///其中参数 value 为回传的参数
    ).then((value) {
      if (value != null) {
        setState(() {
          _message = value;
        });
      }
    });
  }
}

class TestAPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TestBPageState();
  }
}

class _TestBPageState extends State {
  @override
  Widget build(BuildContext context) {
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
          buildOutlineButton(context),
        ],
      ),
    );
  }

  ///代码 清单 1-2
  OutlineButton buildOutlineButton(BuildContext context) {
    return OutlineButton(
      child: Text("返回页面 A "),
      onPressed: () {
        String result = "345";
        Navigator.of(context).pop(result);
      },
    );
  }
}
