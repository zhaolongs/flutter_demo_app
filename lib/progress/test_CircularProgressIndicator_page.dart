import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/10/31.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单 下拉刷新 RefreshIndicator

void main() {
  runApp(RootPage());
}

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePageRefreshIndicator(),
    );
  }
}

///下拉刷新组件
class HomePageRefreshIndicator extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<HomePageRefreshIndicator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("圆形"),
      ),

      body:  Center(
        child: Container(
          width: 55,
          height: 55,
          child: CircularProgressIndicator(
            // value: 0.3,
            //进度高亮颜色
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
            //总进度的颜色
            backgroundColor: Color(0xff00ff00),
            //圆圈的厚度
            strokeWidth: 6.0,
          ),
        ),
      ),
    );
  }
}
