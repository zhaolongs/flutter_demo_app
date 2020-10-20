


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'bloc_time.dart';

///Bloc 初探
class TestBlocTimePage extends StatefulWidget {
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
    _timer= Timer.periodic(Duration(milliseconds: 1000), (timer) {
      ///发送事件
      BlocProvider.of<TimeCounterBloc>(context).add(0);
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
        title: Text("Bloc "),
      ),
      body:buildBlocBuilder(),
    );
  }

  ///代码清单1-1
  /// 通过 BlocBuilder 来消费事件结果
  Widget buildBlocBuilder() {
    return BlocBuilder<TimeCounterBloc, String>(
      ///条件判断是否更新视图
      /// 参数 previous 上一次的数据
      /// 参数 current 当前的数据
      buildWhen: (String previous,String current){
        print("previous $previous  current $current");
        return true;
      },
      ///入参 time 为BloC发射的数据
      builder: (context, time) {
        ///在这里 time 就是BloC回传的数据处理结果
        ///当然在这里是一个 String 类型
        return Container(
          ///外边距
          margin: EdgeInsets.only(left: 12,top: 12),
          child: Text(
            '$time',
            style: TextStyle(fontSize: 22.0, color: Colors.red),
          ),
        );
      },
    );
  }
}
