import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test_app/canvas/test_bubble_login_page.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/11/22.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
/// 西瓜视频 https://www.ixigua.com/home/3662978423
/// 知乎 https://www.zhihu.com/people/zhao-long-90-89
///
///
/// 程序入口
void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TestPage(),
    ),
  );
}

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> with TickerProviderStateMixin {
  List<CustomPoint> _list = [];

  Random _random = new Random();

  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    //初妈化创建
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 4000));

    //动画监听
    _animationController.addListener(() {
      setState(() {});
    });

    //重复执行
    _animationController.repeat();

    ///创建点
    Future.delayed(Duration.zero, () {
      for (int i = 0; i < 1000; i++) {
        CustomPoint point = new CustomPoint();

        //随机x 坐标
        double x = _random.nextDouble() * MediaQuery.of(context).size.width;

        //随机y坐标
        double y = _random.nextDouble() * MediaQuery.of(context).size.height;

        //点的位置
        point.postion = Offset(x, y);
        //点的半径 随机
        point.radius = 3.0 * _random.nextDouble();

        //随机速度
        point.speet = _random.nextDouble();

        point.origin = Offset(0, 0);

        _list.add(point);
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      ///填充布局
      body: Container(
        width: double.infinity,
        height: double.infinity,
        //层叠布局
        child: Stack(
          alignment: Alignment.center,
          children: [
            //来一个图片
            Positioned.fill(
              child: Image.asset(
                "assets/images/bg_snow.png",
                //填充一下
                fit: BoxFit.fill,
              ),
            ),

            //绘制
            Positioned.fill(
              child: CustomPaint(
                painter: SnowCustomPater(list: _list),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///绘制雪花效果
class SnowCustomPater extends CustomPainter {
  //先来个画笔
  Paint _paint = new Paint()
    ..isAntiAlias = true
    ..color = Colors.white;

  //来个List
  List<CustomPoint> list;

  SnowCustomPater({@required this.list});

  //绘制操作
  @override
  void paint(Canvas canvas, Size size) {
    //在每次绘制前计算一下坐标

    list.forEach((element) {
      double x = element.postion.dx;
      double y = element.postion.dy;

      //移动屏幕后重置
      if (y >= size.height) {
        //回到最上面
        y = element.origin.dy;
      }
      //因为这里的偏移值 是一样的 所以移动 速度是一样的
      //再来个随机的速度

      element.postion = Offset(x, y + element.speet);
    });

    //
    list.forEach((element) {
      //element 就是当前的点
      //先来画个点
      canvas.drawCircle(element.postion, element.radius, _paint);
    });
  }

  //实时刷新
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

//定义点
class CustomPoint {
  //点的位置
  Offset postion;

  //点 初始化的的位置  移动出后需要重新初始化
  Offset origin;

  //点的大小
  double radius;

  //随机速度
  double speet;
}
