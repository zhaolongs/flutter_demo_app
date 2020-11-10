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

void main() {
  runApp(RootPage());
}


///仿开源中国APP底部弹出菜单
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
            buildContainer(),
          ],
        ),
      ),
    );
  }

  Container buildContainer() {
    return Container(
      child: BottomRoundFlowMenu(
        //菜单图标组
        iconList: [
          Icon(
            Icons.backup_table_sharp,
            color: Colors.white,
          ),
          Icon(Icons.aspect_ratio, color: Colors.white),
          Icon(Icons.medical_services, color: Colors.white),
          Icon(Icons.add, color: Colors.white),
        ],
        iconBackgroundColorList: [
          Colors.deepOrangeAccent,
          Colors.deepPurple,
          Colors.blueGrey,
          Colors.blueAccent,
        ],
        //点击事件回调
        clickCallBack: (int index) {},
      ),
    );
  }
}
