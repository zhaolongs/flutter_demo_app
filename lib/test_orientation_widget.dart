import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_camera_pugin/flutter_custom_camera_pugin.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/9/9.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
class TestOrientationPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

//lib/code/main_data.dart
class _TestPageState extends State<TestOrientationPage> {
  String testStr = '';

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar( title: const Text(' Flutter 横竖屏切换 '),),
        // 在方向改变时 重新构建
        body: OrientationBuilder(builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            testStr = '竖屏';
          } else {
            testStr = '横屏';
          }



          return buildBodyFunction();
        }),
      ),
    );
  }

  Column buildBodyFunction() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("当前：$testStr"),
        OutlineButton(
          child: Text('打开相机'),
          onPressed: () {},
        ),
      ],
    );
  }
}
