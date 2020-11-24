import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:async';

void main() {
  runApp(RootPage());
}

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TestTimeProgressIndicatorPage(),
    );
  }
}

///通过流 Stream 实现的倒计时功能
///倒计时
class TestTimeProgressIndicatorPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TestABPageState();
  }
}

class _TestABPageState extends State {
  Timer _mainLooptimer;

  ///时间计时器
  Timer _timer;

  ///初始的时间
  double _progress = 1000;

  ///倒计时时间
  double _totalProgress = 10000;

  ///AnimatedContainer的装饰的阴影的宽度
  double _borderWidth = 1.0;

  @override
  void initState() {
    super.initState();

    _mainLooptimer = Timer.periodic(Duration(milliseconds: (_totalProgress+1000).toInt()), (timer) {
      print("循环");
      startTimer();
    });
  }

  void getCurrentTime() {
    ///进度每次累加100，
    _progress += 100;

    ///每一秒进行一次
    ///AnimatedContainer的装饰的阴影的高度的修改
    if (_progress % 2000 == 0) {
      if (_borderWidth == 1.0) {
        _borderWidth = 28.0;
      } else {
        _borderWidth = 1.0;
      }
    }

    ///计时完成后进入首页面
    if (_progress >= _totalProgress) {
      _timer.cancel();
    }

    _streamTimeController.add(_progress);
  }

  @override
  void dispose() {
    super.dispose();

    _timer.cancel();
    _mainLooptimer.cancel();
  }

  void startTimer() {
    _progress = 0;

    ///每100毫秒执行一次
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      ///发送事件
      getCurrentTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black45,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              buildBgWidget(),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: Container(
                  decoration: BoxDecoration(
                    color: (Color.fromRGBO(225, 225, 225, 1)).withOpacity(0.06),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              buildStreamBuilder(),
            ],
          ),
        ));
  }

  StreamController<double> _streamTimeController = new StreamController();

//层叠布局组合圆圈与显示的文本
  Widget buildStreamBuilder() {
    return StreamBuilder(
      initialData: 0,
      stream: _streamTimeController.stream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return AnimatedContainer(
          //过渡时间
          duration: Duration(milliseconds: 2000),
          decoration: BoxDecoration(
              color: Colors.grey[200],
              //背景装饰的圆角
              borderRadius: BorderRadius.all(Radius.circular(40)),
              //边框样式
              border: Border.all(color: Colors.grey[200], width: 2.0),
              //白色的高斯模糊背景阴影
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  //阴影的宽度
                  blurRadius: _borderWidth,
                ),
              ]),
          //倒计时使用的进度圆圈
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 66,
                width: 66,
                child: CircularProgressIndicator(
                  backgroundColor:Colors.grey,
                  valueColor:new AlwaysStoppedAnimation<Color>(Colors.blue),
                  value: snapshot.data / _totalProgress,
                ),
              ),
              Text(
                "${snapshot.data ~/ 1000}",
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 33),
              )
            ],
          ),
        );
      },
    );
  }

  ///构建填充页面的背景图片
  buildBgWidget() {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      bottom: 0,
      child: Image.asset(
        "assets/images/welcome_bg.jpeg",
        fit: BoxFit.fill,
      ),
    );
  }
}
