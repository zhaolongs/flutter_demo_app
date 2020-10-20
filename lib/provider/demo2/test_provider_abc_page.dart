import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app/provider/demo1/number_model.dart';
import 'package:flutter_test_app/provider/demo1/time_model.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class TestProviderMulPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return TimeCounterModel();
          },
        ),
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
      Provider.of<TimeCounterModel>(context, listen: false).getCurrentTime(); //2
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
      body: Column(
        children: [
          buildTimeConsumer(),
          buildNumberConsumer(),
          OutlineButton(
            child: Text("打开B页面"),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return ProviderTestBPage();
              }));
            },
          ),
        ],
      ),
    );
  }

  ///代码清单1-1
  /// 通过 BlocBuilder 来消费事件结果
  Widget buildTimeConsumer() {
    return Consumer<TimeCounterModel>(
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
