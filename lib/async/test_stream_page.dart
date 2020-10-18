


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'dart:async';


///多订阅流使用 Demo
StreamController<String> streamController = StreamController.broadcast();


class TestStreamBaseUsePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TestABPageState();
  }
}

class _TestABPageState extends State {
  ///页面B返回的数据
  String _message = "--";

  StreamSubscription _streamSubscription;

  @override
  void initState() {
    super.initState();
    ///监听一
    _streamSubscription=streamController.stream.listen((data){
      print("页面A接收到数据 $data");
      setState(() {
        _message = data;
      });

    },onError: (error){
      print(error.toString());
    });



  }


  @override
  void dispose() {
    super.dispose();
    streamController.close();
  }
  @override
  Widget build(BuildContext context) {
    ///页面主体脚手架
    return Scaffold(
      appBar: AppBar(
        title: Text("测试Stream"),
      ),

      /// 处理滑动
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),

          OutlineButton(
            child: Text("打开页面B"),
            onPressed: () {
              ///以动态路由的方式打开
              openPageFunction(context);
            },
          ),
          SizedBox(
            height: 40,
          ),
          //ValueListenableBuilder是简易版的Provider
          Text("页面B返回的数据 : $_message"),
          OutlineButton(
            child: Text(" 发送消息 "),
            onPressed: () {
              String result = "345";
              streamController.add("哈哈");
            },
          )
        ],
      ),
    );
  }
  ///代码清单 1-1 
  void openPageFunction(BuildContext context) {
    ///以动态路由的方式打开
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return TestBPage();
        },
      ),
      ///页面 TestBPage 关闭后会回调 then 函数
      ///其中参数 value 为回传的参数
    ).then((value) {
      if (value != null) {
        setState(() {
          _message = value;
        });
      }
    });
  }
}

class TestBPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TestBPageState();
  }
}

class _TestBPageState extends State {
  ///消息订单对象
  StreamSubscription _streamSubscription;
  @override
  void initState() {
    super.initState();
    ///监听二
    _streamSubscription=streamController.stream.listen((event) {
      print("页面B接收到数据 $event");
    });


  }
  test(){
    ///暂停消息订阅
    if(!_streamSubscription.isPaused){
      _streamSubscription.pause();
    }
    ///恢复消息订阅
    if(_streamSubscription.isPaused){
      _streamSubscription.resume();
    }



  }
  @override
  void dispose() {
    super.dispose();
    ///取消消息订阅
    _streamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("测试"),
      ),

      /// 处理滑动
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          OutlineButton(
            child: Text("打开页面C"),
            onPressed: () {
              ///以动态路由的方式打开
              openPageFunction(context);
            },
          ),

          OutlineButton(
            child: Text(" 发送消息 "),
            onPressed: () {
              String result = "345";
              streamController.add("哈哈");
            },
          )
        ],
      ),
    );
  }

  ///代码清单 1-1
  void openPageFunction(BuildContext context) {
    ///以动态路由的方式打开
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return TestCPage();
        },
      ),
      ///页面 TestBPage 关闭后会回调 then 函数
      ///其中参数 value 为回传的参数
    );
  }
}


class TestCPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TestCPageState();
  }
}

class _TestCPageState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("测试"),
      ),

      /// 处理滑动
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          buildOutlineButton(context),
        ],
      ),
    );
  }

  ///代码 清单 1-2
  OutlineButton buildOutlineButton(BuildContext context) {
    return OutlineButton(
      child: Text(" 发送消息 "),
      onPressed: () {
        String result = "345";
        streamController.add("345");
      },
    );
  }
}
