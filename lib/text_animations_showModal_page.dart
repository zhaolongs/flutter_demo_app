import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/11/1.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///

//启动函数
void main() {
  runApp(RootApp());
}

//根目录
class RootApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //默认启动的页面
      home: AnimationSshowModalHomePage(),
    );
  }
}

class AnimationSshowModalHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<AnimationSshowModalHomePage> {
  String resultMessage = "--";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("浏览图片"),
      ),
      //线性布局
      //子Widget 竖直方向排开
      body: Column(
        children: [
          //一个按钮
          OutlineButton(
            child: Text("点击查看图片"),
            onPressed: () {
              showBottomSheet();
            },
          ),
        ],
      ),
    );
  }

  //显示底部弹框的功能
  void showBottomSheet() {
    showModal(
      context: context,
      //动画过渡配置
      configuration: FadeScaleTransitionConfiguration(
        //阴影背景颜色
        barrierColor: Colors.black54,
        //打开新的Widget 的时间
        transitionDuration: Duration(milliseconds: 1000),
        //关闭新的Widget 的时间
        reverseTransitionDuration: Duration(milliseconds: 1000),
      ),
      builder: (BuildContext context) {
        //显示的Widget
        return HomePage2();
      },
    );
  }
}

class HomePage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //背景透明
      backgroundColor: Colors.transparent,
      body: Theme(
        data: ThemeData(
          //去除点击事件的水波纹效果
          splashColor: Colors.transparent,
          //云除点击事件的高亮效果
          highlightColor: Colors.transparent,
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            child: Center(
              child: Image.asset("images/banner3.webp"),
            ),
          ),
        ),
      ),
    );
  }
}
