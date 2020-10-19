import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'dart:async';


///通过流 Stream 实现的倒计时功能
///倒计时
class TestTimePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TestABPageState();
  }
}

class _TestABPageState extends State {

  ///单订阅流
  StreamController<double> _streamController = StreamController();
  
  ///页面B返回的数据
  String _message = "--";

  ///计时器
  Timer _timer;

  ///倒计时6秒
  double totalTimeNumber = 6000;

  ///当前的时间
  double currentTimeNumber = 6000;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    ///间隔100毫秒执行时间
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      ///间隔100毫秒执行一次 每次减100
      currentTimeNumber -= 100;

      ///如果计完成取消定时
      if (currentTimeNumber <= 0) {
        _timer.cancel();
        currentTimeNumber = 0;
      }

      ///流数据更新
      _streamController.add(currentTimeNumber);
    });
  }


  @override
  void dispose() {
    super.dispose();
    ///关闭
    _streamController.close();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    ///页面主体脚手架
    return Scaffold(
      appBar: AppBar(
        title: Text("测试Stream $_message"),
      ),
      body: Column(children: [
        Container(
          child: buildStreamBuilder(),
          margin: EdgeInsets.only(top: 20, left: 20),
        ),

        SizedBox(height: 40,),

        OutlineButton(child: Text('开始倒计时'), onPressed: () {
          currentTimeNumber = totalTimeNumber;
          if (!_timer.isActive) {
            startTimer();
        }

        },)
      ],),
    );
  }

  /// 监听Stream，每次值改变的时候，更新Text中的内容
  StreamBuilder<double> buildStreamBuilder() {
    return StreamBuilder<double>(
      ///绑定stream
      stream: _streamController.stream,
      ///默认的数据
      initialData: 0,
      ///构建绑定数据的UI
      builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
        return Stack(
          ///子Widget 居中对齐
          alignment: Alignment.center,
          children: [
            ///中间显示的文本
            Text(
              (snapshot.data / 1000).toStringAsFixed(0),
              style: TextStyle(fontSize: 22, color: Colors.blue),
            ),
            ///圆圈进度
            CircularProgressIndicator(
              value: 1.0 - snapshot.data / totalTimeNumber,)
          ],
        );
      },
    );
  }
}
