import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app/provider/demo2/number_model.dart';
import 'package:flutter_test_app/provider/demo1/time_model.dart';
import 'package:provider/provider.dart';
import 'dart:async';

///代码清单2-1
class TestProviderMulPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ///组合多个Provider
    return MultiProvider(
      providers: [
        ///计时器
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return TimeCounterModel();
          },
        ),

        ///随机数据
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return RandomNumberModel();
          },
        )
      ],
      child: MaterialApp(
        home: TestConsumerTimePage(),
      ),
    );
  }
}

///Bloc 初探
class TestConsumerTimePage extends StatefulWidget {
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
      Provider.of<TimeCounterModel>(context, listen: false).getCurrentTime();
      Provider.of<RandomNumberModel>(context, listen: false).testRandom(); //2
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
      // body: buildColumn(context),
      // body: buildColumn2(context),
      body:buildTimeConsumer2() ,
    );
  }

  Column buildColumn2(BuildContext context) {
    return Column(
      children: [
        buildTimeConsumer(),
        buildNumberConsumer(),
      ],
    );
  }

  Column buildColumn(BuildContext context) {
    return Column(
      children: [
        buildTimeConsumer(),
        buildNumberConsumer(),
        buildOutlineButton(context),
      ],
    );
  }

  OutlineButton buildOutlineButton(BuildContext context) {
    return OutlineButton(
      child: Text("打开B页面"),
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return ProviderTestBPage();
        }));
      },
    );
  }

  ///通过 Consumer2 来同时监听处理两个结果
  Widget buildTimeConsumer2() {
    return Consumer2<TimeCounterModel,RandomNumberModel>(
      ///参数 value 为 TimeCounterModel 类型
      ///参数 value2 为 RandomNumberModel 类型
      builder: (BuildContext context, value,value2, Widget child) {
        return Container(
          ///外边距
          margin: EdgeInsets.only(left: 12, top: 12),
          child: Text(
            '当前时间 ${value.formatTime} 随机数 ${value2.randomNumber}',
            style: TextStyle(fontSize: 22.0, color: Colors.red),
          ),
        );
      },
    );
  }






  /// 通过 Consumer 来消费事件结果
  /// 计时器的更新
  Widget buildTimeConsumer() {
    return Consumer<TimeCounterModel>(
      builder: (BuildContext context, value, Widget child) {
        return Container(
          ///外边距
          margin: EdgeInsets.only(left: 12, top: 12),
          child: Text(
            '当前时间 ${value.formatTime}',
            style: TextStyle(fontSize: 22.0, color: Colors.red),
          ),
        );
      },
    );
  }

  ///随机数的更新
  Widget buildNumberConsumer() {
    return Consumer<RandomNumberModel>(
      builder: (BuildContext context, value, Widget child) {
        return Container(
          ///外边距
          margin: EdgeInsets.only(left: 12, top: 12),
          child: Text(
            '回传的数据 ${value.randomNumber}',
            style: TextStyle(fontSize: 22.0, color: Colors.red),
          ),
        );
      },
    );
  }
}

class ProviderTestBPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProviderTestBPageState();
  }
}

class ProviderTestBPageState extends State {
  @override
  Widget build(BuildContext context) {
    RandomNumberModel numberModel =
        Provider.of<RandomNumberModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("测试B页面"),
      ),
      body: Container(
        child: RaisedButton(
          child: Text("向A页面发送数据"),
          onPressed: () {
            numberModel.testNumber(234); //2
          },
        ),
      ),
    );
  }
}
