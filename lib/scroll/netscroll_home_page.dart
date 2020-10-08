import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NetScrollHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ScrollHomePageState();
  }
}

class ScrollHomePageState extends State with SingleTickerProviderStateMixin {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: Text(" 配制"),),
      /// 处理滑动
      body: buildNestedScrollView(),
    );
  }

  ///构建滑动布局
  NestedScrollView buildNestedScrollView() {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool b) {
        return [
          SliverAppBar(
            ///true SliverAppBar 不会滑动
            pinned: true,
            ///是否随着滑动隐藏标题
            floating: true,
            ///SliverAppBar展开的高度
            expandedHeight: 200,
            flexibleSpace: buildFlexibleSpaceBar(),
            bottom: buildTabBar(),
          ),
        ];
      },
      ///主体部分
      body: buildTabBarView(),
    );
  }

  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 3, vsync: this);
  }
  
  TabBarView buildTabBarView() {
    return TabBarView(
      controller: tabController,
      children: <Widget>[
        SingleChildScrollView(
          child: Container(
            alignment: Alignment.bottomLeft,
            child: Text("这是第一个页面"),
            height: 1000,
          ),
        ),
        Text(
          "这是第二个页面",
          style: TextStyle(color: Colors.blue),
        ),
        Text(
          "这是第三个页面",
          style: TextStyle(color: Colors.red),
        ),
      ],
    );
  }

  TabBar buildTabBar() {
    return TabBar(
      controller: tabController,
      tabs: <Widget>[
        new Tab(
          text: "标签一",
        ),
        new Tab(
          text: "标签二",
        ),
        new Tab(
          text: "标签三",
        ),
      ],
    );
  }

  String imageUrl =
      "https://timgsa.baidu.com/timg?demo.image&quality=80&size=b9999_10000&sec=1578583093&di=0bf687d9589dc5c6c0778de9576ee077&imgtype=jpg&er=1&src=http%3A%2F%2Ffile.mumayi.com%2Fforum%2F201403%2F28%2F111010vhgc45hkh41f1mfd.jpg";

  FlexibleSpaceBar buildFlexibleSpaceBar() {
    return FlexibleSpaceBar(
//                title: Text("FlexibleSpaceBar title"),
      centerTitle: true,
      background: Container(
        color: Colors.blue[300],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 150,
              child: Image.network(
                imageUrl,
                fit: BoxFit.fill,
                height: 160,
                width: 400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
