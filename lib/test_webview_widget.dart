import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fai_webview/flutter_fai_webview.dart';




/**
 *   混合页面加载
 */
class DefaultHexRefreshPage extends StatefulWidget {
  @override
  MaxUrlHexRefreshState createState() => MaxUrlHexRefreshState();
}

class MaxUrlHexRefreshState extends State<DefaultHexRefreshPage> {
  //原生 发送给 Flutter 的消息
  String message = "--";
  String htmlUrl =
      "https://www.toushivip.com/portal/details/userAgreement.html";
  double webViewHeight = 1;
  FaiWebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = FaiWebViewController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          height: 28,
          alignment: Alignment(0, 0),
          color: Color.fromARGB(90, 0, 0, 0),
          child: Text(
            message,
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ),
      body: buildRefreshHexWidget(),
    );
  }


  dynamic pty =BouncingScrollPhysics();
  Widget buildRefreshHexWidget() {
    return RefreshIndicator(
      //下拉刷新触发方法
      onRefresh: _onRefresh,
      //设置webViewWidget
      child: NotificationListener(
        onNotification: (ScrollNotification notification) {

          ScrollMetrics metrics = notification.metrics;
          ///当前位置
          double pixels = metrics.pixels;
          print("当前位置 $pixels");

          ///是否在顶部或底部
          bool atEdge = metrics.atEdge;
          print("是否在顶部或底部 $atEdge");

          if(atEdge)
{
  pty =NeverScrollableScrollPhysics();
}
          ///滚动方向 垂直或水平滚动
          Axis axis = metrics.axis;
          print("滚动方向  $axis");


          ///滚动方向是down还是up
          AxisDirection axisDirection = metrics.axisDirection;
          print("滚动方向 $axisDirection");


          ///视口底部距离列表底部有多大
          double extentAfter = metrics.extentAfter;
          print("视口底部距离列表底部 $extentAfter");


          ///视口顶部距离列表顶部有多大
          double extentBefore = metrics.extentBefore;
          print("视口顶部距离列表顶部有多大 $extentBefore");

          ///视口范围内的列表长度
          double extentInside = metrics.extentInside;
          print("视口范围内的列表长度 $extentBefore");

          ///最大滚动距离，列表长度-视口长度
          double maxScrollExtent = metrics.maxScrollExtent;
          print("最大滚动距离 $maxScrollExtent");

          ///最小滚动距离
          double minScrollExtent = metrics.minScrollExtent;
          print("最小滚动距离 $minScrollExtent");

          ///视口长度
          double viewportDimension = metrics.viewportDimension;
          print("视口长度 $viewportDimension");

          ///是否越过边界
          bool outOfRange = metrics.outOfRange;
          print("是否越过边界 $outOfRange");

          ///滚动类型
          Type  runtimeType = notification.runtimeType;

          switch (runtimeType) {
            case ScrollStartNotification:
              print("开始滚动");
              break;
            case ScrollUpdateNotification:
              print("正在滚动");
              break;
            case ScrollEndNotification:
              print("滚动停止");
              break;
            case OverscrollNotification:
              print("滚动到边界");
              break;
          }

          ///可滚动组件在滚动过程中会发出ScrollNotification之外，还有一些其它的通知，
          ///如SizeChangedLayoutNotification、KeepAliveNotification 、LayoutChangedNotification等
          ///返回值类型为布尔值，当返回值为true时，阻止冒泡，其父级Widget将再也收不到该通知；当返回值为false 时继续向上冒泡通知。
          return true;
        },
        child: SingleChildScrollView(
          physics:NeverScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.grey,
                height: 220.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Center(
                      child: Text("这里是 Flutter widget  "),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment(0, 0),
                child: Text("以下是 Html 页面 "),
              ),
              Container(
                color: Colors.redAccent,
                height: 1.0,
              ),
              Container(
                height:webViewHeight>MediaQuery.of(context).size.height?MediaQuery.of(context).size.height:webViewHeight,
                child: FaiWebViewWidget(
                  //webview 加载网页链接
                  url: "https://www.toushivip.com/portal/details/userAgreement.html",
                  //webview 加载信息回调
                  callback: callBack,
                  //输出日志
                  isLog: true,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> _onRefresh() async {
    return await Future.delayed(Duration(seconds: 1), () {
      print('refresh');
    });
  }

  callBack(int code, String msg, content) {
    //加载页面完成后 对页面重新测量的回调
    if (code == 201) {
      //更新高度
      webViewHeight = content;
      print("webViewHeight " + content.toString());
    } else {
      //其他回调
    }
    setState(() {
      message = "回调：code[" + code.toString() + "]; msg[" + msg.toString() + "]";
    });
  }
}
