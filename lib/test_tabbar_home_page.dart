import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/custom_tabbar.dart';

class TestTabBarHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SliderHomePageState();
  }
}

class SliderHomePageState extends State with SingleTickerProviderStateMixin {
  ///Tab 与 TabView 联动使用的控制器
  TabController tabController;
  //当前显示页面的
  int currentIndex = 0;
  //点击导航项是要显示的页面
  final pages = [Text("首页"), Text("发现"), Text("动态"), Text("我的")];

  @override
  void initState() {
    ///初始化，这个函数在生命周期中只调用一次
    super.initState();
    tabController = new TabController(length: pages.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("测试 Tab "),
        bottom: buildPreferredSize(),
      ),
      body: new TabBarView(controller: tabController, children: pages),
    );
  }

  PreferredSize buildPreferredSize() {
    return PreferredSize(
      preferredSize: Size(0, 84),
      child: buildTheme(),
    );
  }



  Widget buildTabBar() {
    return new TabBar(
      controller: tabController,
      tabs: <Tab>[
        new Tab(text: "首页", icon: new Icon(Icons.home)),
        new Tab(text: "发现", icon: new Icon(Icons.find_in_page)),
        new Tab(text: "动态", icon: new Icon(Icons.message)),
        new Tab(text: "我的", icon: new Icon(Icons.person)),
      ],
      indicatorWeight: 0.1,
    );
  }

  Widget testCustomTabBar(){
    return CustomTabBar(controller: null,);
  }

  Theme buildTheme() {
    return Theme(
      data: ThemeData(
        ///默认显示的背影颜色
        backgroundColor: Colors.blue[500],
        ///点击的高亮颜色
        highlightColor: Colors.blueGrey[600],
        ///水波纹颜色
        splashColor: Color.fromRGBO(0, 0, 0, 0),
      ),
      child: new TabBar(
        controller: tabController,
        tabs: <Tab>[
          new Tab(text: "首页", icon: new Icon(Icons.home)),
          new Tab(text: "发现", icon: new Icon(Icons.find_in_page)),
          new Tab(text: "动态", icon: new Icon(Icons.message)),
          new Tab(text: "我的", icon: new Icon(Icons.person)),
        ],
        indicatorWeight: 0.1,
      ),
    );
  }
}
