
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_life_state/flutter_life_state.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/9/9.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572

class TestWidgetLivePage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends BaseLifeState<TestWidgetLivePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///一个标题
      appBar: AppBar( title: Text("A页面"), ),
      body: Center(
        ///竖起排列 线性布局
        child: Column(
          ///子 Widget  居中
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ///一个按钮
            buildRaisedButton(context)
          ],
        ),
      ),
    );
  }

  ///一个按钮 点击 push B页面
  RaisedButton buildRaisedButton(BuildContext context) {
    return RaisedButton(
      child: Text(" push B页面 "),
      onPressed: () {
        ///打开B页面
        Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
          return new TestBPage();
        }));
      },
    );
  }

  @override
  void onWillCreat() {
    super.onWillCreat();
    print(" A 页面 onWillCreat");
  }

  @override
  void onCreat() {
    super.onCreat();
    print(" A 页面 onCreat");
  }

  @override
  void onStart() {
    super.onStart();
    print(" A 页面 onStart");
  }

  @override
  void onResumed() {
    super.onResumed();
    print(" A 页面 onResumed");
  }

  @override
  void onPause() {
    super.onPause();
    print(" A 页面 onPause");
  }

  @override
  void onStop() {
    super.onStop();
    print(" A 页面 onStop");
  }

  @override
  void onWillDestory() {
    super.onWillDestory();
    print(" A 页面 onWillDestory");
  }

  @override
  void onDestory() {
    super.onDestory();
    print(" A 页面 onDestory");
  }
}

class TestBPage extends StatefulWidget {
  @override
  _TestBPageState createState() => _TestBPageState();
}

class _TestBPageState extends BaseLifeState<TestBPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("B页面"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
                child: Text("返回A页面 "),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
        ),
      ),
    );
  }

  @override
  void onWillCreat() {
    super.onWillCreat();
    print(" B 页面 onWillCreat");
  }

  @override
  void onCreat() {
    super.onCreat();
    print(" B 页面 onCreat");
  }

  @override
  void onStart() {
    super.onStart();
    print(" B 页面 onStart");
  }

  @override
  void onResumed() {
    super.onResumed();
    print(" B 页面 onResumed");
  }

  @override
  void onPause() {
    super.onPause();
    print(" B 页面 onPause");
  }

  @override
  void onStop() {
    super.onStop();
    print(" B 页面 onStop");
  }

  @override
  void onWillDestory() {
    super.onWillDestory();
    print(" B 页面 onWillDestory");
  }

  @override
  void onDestory() {
    super.onDestory();
    print(" B 页面 onDestory");
  }
}
