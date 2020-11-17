import 'dart:ui';

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
/// 代码清单

void main() {
  runApp(MaterialApp(
    home: RootPage(),
  ));
}


class RootPage extends StatefulWidget {
  @override
  _TestingFadeThroughState createState() => _TestingFadeThroughState();
}

class _TestingFadeThroughState extends State<RootPage> {
  int pageIndex = 0;
  List<Widget> pageList = <Widget>[
    Container(key: UniqueKey(), color: Colors.red),
    Container(key: UniqueKey(), color: Colors.blue),
    Container(key: UniqueKey(), color: Colors.green)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Testing Fade Through')),
      body: PageTransitionSwitcher(
        transitionBuilder: (Widget child, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: pageList[pageIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (int newValue) {
          setState(() {
            pageIndex = newValue;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_one),
            title: Text('First Page'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_two),
            title: Text('Second Page'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_3),
            title: Text('Third Page'),
          ),
        ],
      ),
    );
  }
}
