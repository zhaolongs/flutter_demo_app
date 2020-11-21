import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/11/21.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
/// 西瓜视频 https://www.ixigua.com/home/3662978423
/// 知乎 https://www.zhihu.com/people/zhao-long-90-89

void main() {
  //启动根目录
  runApp(MaterialApp(
    //默认的页面
    home: Example820(),
  ));
}

/// 代码清单 8-30
/// 
class Example820 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ExampleState();
  }
}

class _ExampleState extends State with SingleTickerProviderStateMixin {
  ///动画控制器
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    //创建动画控制器
    _animationController = AnimationController(
      //默认的初始值
      value: 0.0,
      //执行时间
      duration: Duration(seconds: 10),
      //值变化范围
      upperBound: 1,
      lowerBound: -1,
      vsync: this,
    );
    //重复执行
    _animationController.repeat();
  }

  @override
  void dispose() {
    //销毁
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //获取当前组件的大小
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      //允许键盘弹出布局文件上移
      resizeToAvoidBottomPadding: true,
      body: Container(
        //填充
        width: size.width,
        height: size.height,
        //层叠
        child: Stack(
          children: <Widget>[
            //水波纹背景
            buildFirstAnimation(size),
            //顶部的文本
            buildTopText(size),
            //底部的按钮
            buildBottomButton(size),
          ],
        ),
      ),
    );
  }

  /// 代码清单 8-33 构建 AnimatedBuilder 与裁剪水波纹
  /// 
  AnimatedBuilder buildFirstAnimation(Size size) {
    return AnimatedBuilder(
      //绑定动画控制器
      animation: _animationController,
      builder: (BuildContext context, Widget child) {
        //裁剪组件
        return ClipPath(
          //自定义裁剪路径
          clipper: HeaderClipper(_animationController.value),
          //裁剪的子Widget
          child: Container(
            //高度
            height: size.height * 0.5,
            //线性渐变颜色的样式
            decoration: BoxDecoration(
              gradient: LinearGradient(
                //线性渐变的方向
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [Color(0xFFE0647B), Color(0xFFFCDD89)]),
            ),
          ),
        );
      },
    );
  }

  /// 代码清单 8-31 顶部对齐的文本
  /// 
  Positioned buildTopText(Size size) {
    return Positioned(
      top: size.height * 0.2,
      left: 0,
      right: 0,
      child: Text(
        "Hello World",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 33, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  /// 代码清单 8-32 底部对齐的输入框
  /// 
  Positioned buildBottomButton(Size size) {
    return Positioned(
      bottom: 60,
      left: 0,
      right: 0,
      child: Column(
        //包裹子Widget
        mainAxisSize: MainAxisSize.min,
        //主方向子Widget 底部对齐 （Column的垂直方向）
        mainAxisAlignment: MainAxisAlignment.end,
        //次方向子Widget居中对齐 （Column的水平方向）
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: size.width * 0.8,
            margin: EdgeInsets.only(top: 18),
            child: buildInputWidget('请输入账号'),
          ),
          Container(
            width: size.width * 0.8,
            margin: EdgeInsets.only(top: 18),
            child: buildInputWidget('请输入密码', isPass: true),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.only(bottom: 60),
            width: size.width * 0.7,
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                '登录',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 代码清单 8-33
/// 
Widget buildInputWidget(String hint, {bool isPass = false}) {
  return TextField(
    //是否隐藏文本
    obscureText: isPass,
    //文本的边框装饰
    decoration: InputDecoration(
      //提示文本
      hintText: hint,
      //提示文本的样式
      hintStyle: TextStyle(color: Color(0xFFACACAC), fontSize: 14),
      //输入内容的内边距
      contentPadding: EdgeInsets.only(top: 20, bottom: 20, left: 38),
      //输入框可用时的边框样式
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.lightBlueAccent),
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
      //输入框获取输入焦点时的边框样式
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.green),
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
    ),
  );
}

/// 代码清单 8-34 自定义 Clipper
/// 
class HeaderClipper extends CustomClipper<Path> {
  ///取值为 -1 ~ 1.0
  double moveFlag = 0;

  HeaderClipper(this.moveFlag);

  @override
  Path getClip(Size size) {
    //创建 Path
    Path path = Path();
    //移动到点 P0点 也是曲线的起点
    path.lineTo(0, size.height * 0.8);
    //计算控制点 P1 的坐标
    double xCenter = size.width * 0.5 +
        (size.width * 0.6 + 1) * sin(moveFlag * pi);
    double yCenter = size.height * 0.8 + 69 * cos(moveFlag*pi);
    //构建 二阶贝塞尔曲线
    path.quadraticBezierTo(xCenter, yCenter, size.width, size.height * 0.8);

    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    //刷新
    return true;
  }
}
