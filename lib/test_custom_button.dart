import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_camera_pugin/flutter_custom_camera_pugin.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/9/9.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
class TestCustomCameraPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

//lib/code/main_data.dart
class _TestPageState extends State<TestCustomCameraPage> {
  CameraResultInfo _cameraResultInfo;

  @override
  void initState() {
    super.initState();
  }

  Future<void> testPlugin() async {
    CameraResultInfo platformVersion;

    try {
      platformVersion = await FlutterCustomCameraPugin.testPugin();
    } on PlatformException {
      platformVersion = CameraResultInfo.fromError();
    }
    if (!mounted) return;

    setState(() {
      _cameraResultInfo = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(' Flutter 的一个 Button  '),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.blue.withOpacity(.4)),
              child: InkWell(
                onTap: () {},
                child: Stack(children: <Widget>[
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.blue),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
