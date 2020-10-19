


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'dart:async';

import 'package:intl/intl.dart';

///多订阅流使用 Demo


class TestStreamBuilderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TestABPageState();
  }
}

class _TestABPageState extends State {
  ///测试数据
  String _message = "--";
  ///使用单订阅流即可
  StreamController<String> _streamController = StreamController();
  ///计时器
  Timer _timer;

  @override
  void initState() {
    super.initState();


    ///间隔1秒执行时间
    _timer= Timer.periodic(Duration(milliseconds: 1000), (timer) {
      ///获取当前的时间
      DateTime dateTime= DateTime.now();
      ///格式化时间
      String formatTime = DateFormat("HH:mm:ss").format(dateTime);
      _message=formatTime;
      ///流数据更新
      _streamController.add("$formatTime");
    });


  }


  @override
  void dispose() {
    super.dispose();
    ///关闭
    _streamController.close();

    ///取消计时器
    _timer.cancel();
  }
  @override
  Widget build(BuildContext context) {
    ///页面主体脚手架
    return Scaffold(
      appBar: AppBar(
        title: Text("测试Stream $_message"),
      ),

      body:buildStreamBuilder(),
    );
  }

  ///代码清单1-1
  /// 监听Stream，每次值改变的时候，更新Text中的内容
  StreamBuilder<String> buildStreamBuilder() {
    return StreamBuilder<String>(
      ///绑定stream
      stream: _streamController.stream,
      ///默认的数据
      initialData: "00:00:00",
      ///构建绑定数据的UI
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        ///snapshot.data 就是传递的数据对象
        return Text(
          '当前时间  ${snapshot.data} ',
          style: TextStyle(fontSize: 22, color: Colors.blue),
        );
      },
    );
  }
}
