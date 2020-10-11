import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/clip/test_clip_oval_page.dart';


/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/10/11.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
/// 
/// 代码清单
///

void main()=>runApp(TestClipMainPage());
///应用的根布局
class TestClipMainPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    ///构建Materia Desin 风格的应用程序
    return MaterialApp(
      ///Android应用程序中任务栏中显示应用的名称
      title: "  配制",
      theme: ThemeData(
        accentColor: Colors.blue,
        ///默认是 Brightness.light
        brightness: Brightness.light,
      ),
      ///默认的首页面
//    home: ScrollHomePage(),
//      home: NetScrollHomePage(),
      home: TestClipOvalPage(),
//    home: CustomScrollDemoPage(),
    );
  }
}
