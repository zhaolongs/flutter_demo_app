import 'dart:ui';

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
/// 代码清单

void main() {
  runApp(MaterialApp(
    home: RootPage(),
  ));
}

class RootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RootPageState();
  }
}

class _RootPageState extends State with SingleTickerProviderStateMixin {
  //动画控制器
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    //动画监听
    _animationController.addListener(() {
      setState(() {});
    });
    //添加一个动画状态监听
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //动画正向执行完成 重新执行
        _animationController.reset();
        _animationController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Path动画"),
      ),
      body: Column(
        children: [
          //第一部分 画布 画线处
          Expanded(
            child: buildContainer(),
          ),
          //第二部分 底部的按钮区域
          buildControllerContainer()
        ],
      ),
    );
  }

  //第二部分 底部的按钮区域
  Container buildControllerContainer() {
    return Container(
      margin: EdgeInsets.only(bottom: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //按钮
          ElevatedButton(
            onPressed: () {
              //重置动画
              _animationController.reset();
              //正向执行动画
              _animationController.forward();
            },
            child: Text("开始"),
          ),
          SizedBox(
            width: 20,
          ),
          //按钮
          ElevatedButton(
            onPressed: () {
              _animationController.reset();
            },
            child: Text("结束"),
          )
        ],
      ),
    );
  }

  //第一部分 画布 画线处
  buildContainer() {
    return Container(
      //定义 一个画板
      child: CustomPaint(
        //定义一个画布
        painter: PathPainter(_animationController.value),
      ),
    );
  }
}

class PathPainter extends CustomPainter {
  //记录绘制进度 0.0  - 1.0
  double progress = 0.0;

  PathPainter(this.progress);

  //定义画笔
  Paint _paint = new Paint()
    ..color = Colors.blue //画笔颜色
    ..style = PaintingStyle.stroke
    ..strokeWidth = 6.0
    ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Size size) {
    //画一个矩形

    //创建一个Path
    Path startPath = new Path();

    //路径中添加矩形
    startPath.addRect(
      Rect.fromCenter(
        height: 100,
        width: 100,
        center: Offset(100, 100),
      ),
    );

    //测量Path
    PathMetrics pathMetrics = startPath.computeMetrics();
    //获取第一小节信息
    PathMetric pathMetric = pathMetrics.first;

    //测量并裁剪Path

    Path extrPath = pathMetric.extractPath(0, pathMetric.length * progress);

    //绘制
    canvas.drawPath(extrPath, _paint);

    // canvas.drawPath(startPath, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    //返回ture 实时更新
    return true;
  }
}
