import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 创建人： Created by zhaolong
// 创建时间：Created by  on 2020/9/25.
//
// 创建人： Created by zhaolong
// 创建时间：Created by  on 2020/9/25.
//
// gongzhonghao biglead
// https://study.163.com/instructor/1021406208.htm
// https://blog.csdn.net/zl1
// https://www.toutiao.com/c/user/token/MS4wLjABAAAAYMrKikomuQJ4d-cPaeBqtAK2cQY697Pv9xIyyDhtwIM/
//
//

void main() {
  //启动根目录
  runApp(MaterialApp(
    home: Example625(),
  ));
}

class Example625 extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text("AnimatedSwitcher 动画 "),
      ),
      //线性排列
      body: Column(
        children: [
          //第一部分 效果区域
          Container(
            height: 180,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: buildAnimatedSwitcher(context),
          ),
          //第二部分 按钮区域 与代码清单 代码清单 6-29 中的一致
          buildContainer()
        ],
      ),
    );
  }

  int _count = 200;

  int _flag = 1;

  Widget buildAnimatedSwitcher(BuildContext context) {
    return AnimatedSwitcher(
      //切换时间 定义
      duration: Duration(milliseconds: 1300),
      //让文本动起来
      transitionBuilder: (Widget child, Animation<double> animation) {

        _flag++;

        Offset startOffset = Offset(0.0, -1.0);
        Offset endOffset = Offset(0.0, 0.0);

        if(_flag%2==0){
          startOffset = Offset(0.0, 1.0);
          endOffset = Offset(0.0, 0.0);
        }

        //再来个平移动画
        return SlideTransition(
          //先来个透明渐变动画
          position:
              Tween(begin: startOffset, end: endOffset).animate(
            CurvedAnimation(curve: Curves.linear, parent: animation),
          ),
          child: FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(curve: Curves.linear, parent: animation),
            ),
            //再来个缩放动画
            child: ScaleTransition(
              scale: Tween(begin: 0.6, end: 1.0).animate(
                  CurvedAnimation(curve: Curves.linear, parent: animation)),
              child: child,
            ),
          ),
        );
      },
      //定义 文本
      child: Text(
        "$_count",
        key: ValueKey("$_count"),
        style: TextStyle(
            fontWeight: FontWeight.w500, color: Colors.black, fontSize: 44),
      ),
    );
  }

  //定义定时器
  Timer _timer;

  void startTimer() {
    stopTimer();

    //间隔 1300 毫秒执行一次
    _timer = Timer.periodic(Duration(milliseconds: 1600), (timer) {
      print("执行");
      setState(() {
        _count++;
      });
    });
  }

  void stopTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
  }

  Container buildContainer() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        //子Widget居中
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            child: Text("开始"),
            onPressed: () {
              startTimer();
            },
          ),
          SizedBox(
            width: 22,
          ),
          ElevatedButton(
            child: Text("停止"),
            onPressed: () {
              stopTimer();
            },
          ),
        ],
      ),
    );
  }
}
