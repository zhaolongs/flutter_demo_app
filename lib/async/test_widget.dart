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

  //定义 总的计时时间 ms
  double _totalTime = 10000;
  double _progressTime = 1000;

  //边框阴影的宽度
  double _borderWidth = 2.0;

  //一个计时器
  Timer _timer ;

  @override
  void initState() {
    super.initState();

    //100ms 执行一次
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {

      _progressTime +=100;

      if(_progressTime%2000==0){
        if(_borderWidth == 2.0){
          _borderWidth = 18.0;
        }else{
          _borderWidth = 2.0;
        }
      }

      if(_progressTime >_totalTime ){
        //停止 计时器
        _timer.cancel();
      }

      //流消息发送
      _streamController.add(_progressTime);


    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //当前显示页面的背景
      backgroundColor: Colors.white,
      body: Container(
        //填充父布局空间
        width: double.infinity,
        height: double.infinity,
        //一个层叠布局
        child: Stack(
          //内容居中
          alignment: Alignment.center,
          children: [
            //第一部分 图片背景
            buildImage(),
            //第二部分 高斯模糊
            buildBlureWidget(),
            //第三部分 倒计时圆圈
            buildTimeWidget(),
          ],
        ),
      ),
    );
  }

  //第一部分 图片背景
  buildImage() {
    return Positioned.fill(
      child: Image.asset(
        "assets/images/welcome_bg.jpeg",
        fit: BoxFit.fill,
      ),
    );
  }

  //第二部分 高斯模糊
  buildBlureWidget() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
      child: Container(
        color: Colors.white.withOpacity(0.06),
      ),
    );
  }

  //创建一个流控制器
  StreamController<double> _streamController = new StreamController();

//第三部分 倒计时圆圈
  buildTimeWidget() {
    //用于局部更新数据
    return StreamBuilder<double>(
      //绑定
      stream: _streamController.stream,
      //初始化默认数据
      initialData: 0.0,
      builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
        //用来实现过渡 圆环
        return AnimatedContainer(
          duration: Duration(milliseconds: 2000),
          //背景与边框
          decoration: BoxDecoration(
            //边框  颜色与宽度
            border: Border.all(color: Colors.grey[200], width: 2.0),
            //边框的圆角
            borderRadius: BorderRadius.all(Radius.circular(40)),
            //光环
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                blurRadius: _borderWidth,
              )
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              //小圆圈
              SizedBox(
                width: 66,
                height: 66,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  value:snapshot.data/_totalTime,
                ),
              ),
              //显示的文本
              Text(
                "${(snapshot.data / 1000).toInt()}",
                style: TextStyle(
                    fontSize: 33,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
            ],
          ),
        );
      },
    );
  }
}
