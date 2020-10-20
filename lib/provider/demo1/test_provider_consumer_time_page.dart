import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'time_model.dart';




///Bloc 初探
class TestProviderConsumerTimePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TestABPageState();
  }
}

class _TestABPageState extends State {
  ///计时器
  Timer _timer;
  @override
  void initState() {
    super.initState();
    ///间隔1秒执行时间
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      ///发送事件
      Provider.of<TimeCounterModel>(context,listen: false).getCurrentTime(); //2
    });
  }

  @override
  void dispose() {
    super.dispose();
    ///取消计时器
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    ///页面主体脚手架
    return Scaffold(
      appBar: AppBar(
        title: Text("Provider "),
      ),
      body: buildBlocBuilder(),
    );
  }

  ///代码清单1-4
  /// 通过 Consumer 来消费事件结果
  Widget buildBlocBuilder() {
    return Consumer<TimeCounterModel>(
      ///参数 value 就是绑定的事件结果 TimeCounterModel
      builder: (BuildContext context, value, Widget child) {
        return Container(
          ///外边距
          margin: EdgeInsets.only(left: 12, top: 12),
          child: Text(
            '${value.formatTime}',
            style: TextStyle(fontSize: 22.0, color: Colors.red),
          ),
        );
      },
    );
  }
}








