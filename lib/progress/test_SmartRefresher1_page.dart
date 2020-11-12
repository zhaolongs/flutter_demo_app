import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/10/31.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单 下拉刷新 RefreshIndicator

void main() {
  runApp(RootPage());
}

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePageRefreshIndicator(),
    );
  }
}

///下拉刷新组件
class HomePageRefreshIndicator extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<HomePageRefreshIndicator> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("下拉刷新"),
      ),
      //下拉刷新组件
      body: SmartRefresher(
        controller: _refreshController,
        //水滴刷新头
        header: WaterDropMaterialHeader(),
        enablePullUp: true,
        onRefresh: () async {
          //模拟网络请求
          await Future.delayed(Duration(milliseconds: 2000));
          //结束刷新
          _refreshController.refreshCompleted();
        },
        //一个列表
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 66,
              child: Text("测试数据"),
            );
          },
          //列表数据源数量
          itemCount: 100,
        ),
      ),
    );
  }
}
