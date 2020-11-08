
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shake_animation_widget/shake_animation_widget.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/10/31.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单  向上浮动弹出的效果
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
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("测试"),
      ),
      body: Container(
        //填充
        constraints: BoxConstraints.expand(),
        //层叠布局
        child: Stack(
          children: [

            Positioned(
              right: 33,
              bottom: 33,
              //悬浮按钮
              child: RoteFloatingButton(
                //菜单图标组
                iconList: [
                  Icon(Icons.add),
                  Icon(Icons.message),
                  Icon(Icons.aspect_ratio),
                ],
                //点击事件回调
                clickCallback: (int index){

                },
              ),
            ),

          ],
        ),
      ),
    );
  }






















  //定义菜单按钮选项
  List<Icon> iconList = [
    Icon(Icons.add),
    Icon(Icons.save_outlined),
    Icon(Icons.share),
  ];

  ///向上弹出的按钮组件
  RoteFloatingButton buildRoteFloatingButton() {
    return RoteFloatingButton(
      //子菜单按钮选项
      iconList: iconList,
      ///子菜单按钮的点击事件回调
      clickCallback: (int index) {
        print("点击了按钮$index");

      },
    );
  }
}
