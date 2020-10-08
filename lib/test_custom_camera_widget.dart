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
          title: const Text(' Flutter 自定义相机插件 '),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
                'Running on: ${_cameraResultInfo != null ? _cameraResultInfo.toString() : ''}\n'),
            OutlineButton(
              child: Text('测试下'),
              onPressed: () {
                testPlugin();
              },
            ),
            OutlineButton(
              child: Text('清除下数据'),
              onPressed: () {
                setState(() {
                  _cameraResultInfo = null;
                  imageFile = null;
                });
              },
            ),
            OutlineButton(
              child: Text('打开相机'),
              onPressed: () {
                openCamera();
              },
            ),
            OutlineButton(
              child: Text('打开相册'),
              onPressed: () {
                openPhotoAlbum();
              },
            ),
            OutlineButton(
              child: Text('考虑自定义一下？'),
              onPressed: () {
                openCustomCamera();
              },
            ),
            imageFile == null
                ? Text("图片预览区域")
                : Image.file(
                    imageFile,
                    width: 300,
                    height: 300,
                  ),
          ],
        ),
      ),
    );
  }

  File imageFile;

  ///打开相机
  void openCamera() async {
    CameraConfigOptions options = new CameraConfigOptions();

    ///默认自定义相册是否显示 相册切换
    options.isShowSelectCamera = true;

    ///默认自定义相册是否显示 前后镜头切换
    options.isShowPhotoAlbum = true;

    ///默认自定义相册是否显示 闪光灯开关按钮
    options.isShowFlashButtonCamera = true;

    ///调起自定义相机
    ///拍照的返回结果
    CameraResultInfo resultInfo =
        await FlutterCustomCameraPugin.openCamera(cameraConfigOptions: options);

    if (resultInfo.code == 200) {
      imageFile = new File(resultInfo.data["lImageUrl"]);
    }

    _cameraResultInfo = resultInfo;

    setState(() {});
  }

  ///考虑自定义一下 开发中
  void openCustomCamera() async {}

  ///打开相册
  void openPhotoAlbum() async {
    _cameraResultInfo = await FlutterCustomCameraPugin.openPhotoAlbum();
    if (_cameraResultInfo.code == 200) {
      imageFile = new File(_cameraResultInfo.data["lImageUrl"]);
    }
    setState(() {});
  }
}
