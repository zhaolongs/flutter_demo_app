
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomScrollHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ScrollHomePageState();
  }
}

class ScrollHomePageState extends State with SingleTickerProviderStateMixin {
  List<String> _list = new List();
  List<Color> myColors = new List();

  String imageUrl =
      "https://timgsa.baidu.com/timg?demo.image&quality=80&size=b9999_10000&sec=1578583093&di=0bf687d9589dc5c6c0778de9576ee077&imgtype=jpg&er=1&src=http%3A%2F%2Ffile.mumayi.com%2Fforum%2F201403%2F28%2F111010vhgc45hkh41f1mfd.jpg";

  TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = new TabController(length: 3, vsync: this);
    _list.add("政府");
    _list.add("部门11");
    _list.add("部门22");
    myColors.add(Colors.red);
    myColors.add(Colors.lightBlue);
    myColors.add(Colors.lightBlue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text(" 配制"),
      ),

      ///SingleChildScrollView
      ///NestedScrollView
      /// 处理滑动
      body: CustomScrollView(
        ///反弹效果
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            title: Text("讲解组合滑动"),
          ),

          SliverPadding(
            padding: EdgeInsets.all(5),
          ),

          ///九宫格
          SliverGrid(
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
            delegate: new SliverChildBuilderDelegate(
                (BuildContext context, num index) {
              return Container(
                color: Colors.blue,
                child: Text("grid $index"),
              );
            }, childCount: 10),
          ),
          SliverPadding(
            padding: EdgeInsets.all(5),
          ),
          SliverFixedExtentList(
            itemExtent: 40,
            delegate: new SliverChildBuilderDelegate(
                (BuildContext context, num index) {
              return Container(color: Colors.red, child: Text("list $index"),margin: EdgeInsets.only(bottom: 10),);
            }, childCount: 40),
          )
        ],
      ),
    );
  }
}
