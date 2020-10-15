import 'package:flutter/material.dart';
import 'package:flutter_life_state/flutter_life_state.dart';
import 'package:flutter_test_app/test_custom_camera_widget.dart';
import 'package:flutter_test_app/test_drag_and_drop_gridview_widget.dart';
import 'package:flutter_test_app/test_html2_widget.dart';
import 'package:flutter_test_app/test_html_widget.dart';
import 'package:flutter_test_app/test_orientation_widget.dart';
import 'package:flutter_test_app/test_progress_home_page.dart';
import 'package:flutter_test_app/test_slider_home_page.dart';
import 'package:flutter_test_app/test_splash_widget.dart';
import 'package:flutter_test_app/test_webview_widget.dart';
import 'package:flutter_test_app/test_widget_live_widget.dart';

import 'clip/clip_main.dart';
import 'icon/test_round_icon_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Test Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      navigatorObservers: [lifeFouteObserver],
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("测试生命周期"),
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
                  return new TestWidgetLivePage();
                }));
              },
            ),
            RaisedButton(
              child: Text("测试 相机相册功能"),
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
                  return new TestCustomCameraPage();
                }));
              },
            ),
            RaisedButton(
              child: Text("测试 横竖屏切换"),
              onPressed: () {//OrientationBuilder
                Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
                  return new TestOrientationPage();
                }));
              },
            ),
            OutlineButton(
              child: Text("GridView 的拖动切换"),
              onPressed: () {//OrientationBuilder
                Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
                  return new TestDropGridPage();
                }));
              },
            ),
            OutlineButton(
              child: Text("玩一玩解析 HTML"),
              onPressed: () {//OrientationBuilder
                Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
                  return new TestHtmlPage();
                }));
              },
            ),
            OutlineButton(
              child: Text("骚操作 HTML"),
              onPressed: () {//OrientationBuilder
                Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
                  return new TestHtmlPage2();
                }));
              },
            ),
            OutlineButton(
              child: Text("骚操作 页面切换"),
              onPressed: () {//OrientationBuilder
                Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
                  return new LiquidSwipeDemo();
                }));
              },
            ),

            OutlineButton(
              child: Text("测试 Html "),
              onPressed: () {//OrientationBuilder
                Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
                  return new DefaultHexRefreshPage();
                }));
              },
            ),
            OutlineButton(
              child: Text("裁剪 组件测试 "),
              onPressed: () {//OrientationBuilder
                Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
                  return new TestClipMainPage();
                }));
              },
            ),

            OutlineButton(
              child: Text("滑块 Slider  "),
              onPressed: () {//OrientationBuilder
                Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
                  return new SliderHomePage();
                }));
              },
            ),
            OutlineButton(
              child: Text(" 进度条 "),
              onPressed: () {//OrientationBuilder
                Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
                  return new ProgressHomePage();
                }));
              },
            ),
            OutlineButton(
              child: Text(" 圆角图标 "),
              onPressed: () {//OrientationBuilder
                Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
                  return new TestRuondIconPage();
                }));
              },
            ),




          ],
        ),
      ),
    );
  }
}
