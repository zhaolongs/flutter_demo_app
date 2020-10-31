 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/10/30.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
/// 
/// 代码清单 
///代码清单
class CustomTabBar extends StatefulWidget {
  final TabController controller;

  CustomTabBar({@required this.controller,Key key}):super(key: key);

  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {

  @override
  Widget build(BuildContext context) {
    return  Theme(
      data: ThemeData(
        ///默认显示的背影颜色
        backgroundColor: Colors.blue[500],
        ///点击的高亮颜色
        highlightColor: Colors.blueGrey[600],
        ///水波纹颜色
        splashColor: Color.fromRGBO(0, 0, 0, 0),
      ),
      child: new TabBar(
        controller: widget.controller,
        tabs: <Tab>[
          new Tab(text: "首页", icon: new Icon(Icons.home)),
          new Tab(text: "发现", icon: new Icon(Icons.find_in_page)),
          new Tab(text: "动态", icon: new Icon(Icons.message)),
          new Tab(text: "我的", icon: new Icon(Icons.person)),
        ],
        indicatorWeight: 0.1,
      ),
    );;
  }

}