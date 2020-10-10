import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomScrollHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ScrollHomePageState();
  }
}

class ScrollHomePageState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text(" 配制"),
      ),

      ///SingleChildScrollView
      ///NestedScrollView
      /// 处理滑动
      body: buildCustomScrollView(),
    );
  }

  CustomScrollView buildCustomScrollView() {
    return CustomScrollView(
      ///反弹效果
      physics: BouncingScrollPhysics(),

      ///Sliver 家族的 Widget
      slivers: <Widget>[
        ///复杂的标题
        buildSliverAppBar(),

        ///间距
        SliverPadding(
          padding: EdgeInsets.all(5),
        ),

        ///九宫格
        buildSliverGrid(),

        ///间距
        SliverPadding(
          padding: EdgeInsets.all(5),
        ),

        ///列表
        buildSliverFixedExtentList()
      ],
    );
  }

  SliverAppBar buildSliverAppBar() {
    return SliverAppBar(
      title: Text("讲解组合滑动"),
    );
  }

  SliverGrid buildSliverGrid() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        ///九宫格的列数
        crossAxisCount: 3,
        ///子Widget 宽与高的比值
        childAspectRatio: 2.0,
        ///主方向的 两个 子Widget 之间的间距
        mainAxisSpacing: 10,
        /// 次方向 子Widget 之间的间距
        crossAxisSpacing: 10,
      ),
      ///子Item构建器
      delegate: new SliverChildBuilderDelegate(
        (BuildContext context, num index) {
          ///每一个子Item的样式
          return Container(
            color: Colors.blue,
            child: Text("grid $index"),
          );
        },
        ///子Item的个数
        childCount: 10,
      ),
    );
  }

  SliverFixedExtentList buildSliverFixedExtentList() {
    return SliverFixedExtentList(
      ///子条目的高度
      itemExtent: 40,
      ///子条目布局构建代理
      delegate: new SliverChildBuilderDelegate(
        (BuildContext context, num index) {
          ///子条目的布局样式
          return Container(
            color: Colors.red,
            child: Text("list $index"),
            margin: EdgeInsets.only(bottom: 10),
          );
        },
        ///子条目的个数
        childCount: 40,
      ),
    );
  }
}
