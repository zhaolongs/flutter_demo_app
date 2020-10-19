import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

/// 对比使用 StreamBuilder 实现的计时性能分析 Demo
class TestTimerBuilderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TestABPageState();
  }
}

class _TestABPageState extends State {
  ///测试数据
  String _message = "--";
  ///计时器
  Timer _timer;

  @override
  void initState() {
    super.initState();
    ///间隔1秒执行时间
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      ///获取当前的时间
      DateTime dateTime = DateTime.now();
      ///格式化时间
      String formatTime = DateFormat("HH:mm:ss").format(dateTime);
      setState(() {
        _message = formatTime;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ///页面主体脚手架
    return Scaffold(
      appBar: AppBar(
        title: Text("测试Stream $_message"),
      ),
      body: Text(
        '当前时间  $_message ',
        style: TextStyle(fontSize: 22, color: Colors.blue),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    ///取消计时器
    _timer.cancel();
  }
}
