import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/10/31.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
///代码清单

void main() {
  runApp(RootPage());
}

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("测试"),
      ),
      body: homeItemList[_selectIndex],
      bottomNavigationBar: buildBottom(),
    );
  }


  List<HomeItemPage> homeItemList = [
    HomeItemPage(0),
    HomeItemPage(1),
    HomeItemPage(2),
  ];

  int _selectIndex = 0;

  buildBottom() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
        BottomNavigationBarItem(icon: Icon(Icons.message), label: "消息"),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: "我的"),
      ],
      currentIndex: _selectIndex,
      onTap: (int index) {
        setState(() {
          _selectIndex = index;
        });
      },
    );
  }
}

class HomeItemPage extends StatelessWidget {
  int index = 0;
  HomeItemPage(this.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: selectColor(),
      body: Container(
        child: Text("页面  $index"),
      ),
    );
  }

  selectColor() {
    if (index == 0) {
      return Colors.grey;
    } else if (index == 1) {
      return Colors.blueGrey;
    } else {
      return Colors.green;
    }
  }
}
