import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/tk/demo6/config/colors.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/11/24.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
///代码清单
void main() {
  //启动根目录
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TestPage(),
  ));
}

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

List category = [
  {"name": "Groceries", "amount": 500.0},
  {"name": "Online Shopping", "amount": 100.0},
  {"name": "Eating Out", "amount": 80.0},
  {"name": "Bills", "amount": 50.0},
  {"name": "Subscriptions", "amount": 100.0},
  {"name": "Fees", "amount": 30.0},
];

class _TestPageState extends State<TestPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  Animation<double> _chartAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 400));

    _chartAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.8, 1.0, curve: Curves.bounceOut)));
    _animationController.addListener(() {
      setState(() {});
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,

      ///填充布局
      body: Center(
        child: Container(
          margin: EdgeInsets.all(44),
          decoration: BoxDecoration(
              color: AppColors.primaryWhite,
              shape: BoxShape.circle,
              boxShadow: AppColors.neumorpShadow),
          child: Stack(
            children: <Widget>[
              Center(
                child: Container(
                  margin: EdgeInsets.all(64),
                  child: CustomPaint(
                    child: Container(),
                    foregroundPainter: PieChartCustomPainter(
                        categories: category,
                        progress: _animationController.value),
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * .45,
                  decoration: BoxDecoration(
                      color: AppColors.primaryWhite,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 3 * _chartAnimation.value,
                            blurRadius: 5 * _chartAnimation.value,
                            offset: Offset(3 * _chartAnimation.value,
                                3 * _chartAnimation.value),
                            color: Colors.black38)
                      ]),
                  child: Center(
                      child: Text(
                    "￥ ${(100 * _chartAnimation.value).toInt()}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.show_chart),onPressed: (){

        _animationController.forward();
      },),
    );
  }
}

class PieChartCustomPainter extends CustomPainter {
  final List categories;

  final double progress;

  PieChartCustomPainter({this.categories, this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    double total = 0;
    double startRadian = -pi / 2;
    print("$progress");
    Path path = new Path();
    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 1.8;
    categories.forEach((f) => total += f['amount']);
    for (var i = 0; i < categories.length; i++) {
      final currentCategory = categories[i];
      final sweepRadian =
          (currentCategory['amount'] / total) * 2 * pi * progress;
      paint.color = AppColors.pieColors[i];
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
          startRadian, sweepRadian, false, paint);
      startRadian += sweepRadian;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
