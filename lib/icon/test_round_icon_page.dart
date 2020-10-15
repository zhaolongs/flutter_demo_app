import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/icon/round_corner_icon.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/10/15.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
///代码清单
class TestRuondIconPage extends StatefulWidget {
  @override
  _TestRuondIconPageState createState() => _TestRuondIconPageState();
}

class _TestRuondIconPageState extends State<TestRuondIconPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("圆角图标"),
      ),
      backgroundColor: Colors.white,

      ///填充布局
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [

              SizedBox(height: 50,),
              buildDefaultIcon(),

              SizedBox(height: 50,),
              buildRoundCornerIcon(),
            ],
          )),
    );
  }

  RoundCornerIcon buildRoundCornerIcon() {
    return RoundCornerIcon(
      ///电话小图标
      iconData: CupertinoIcons.phone_solid,
      ///线性渐变的背景
      gradient: LinearGradient(
        ///颜色过渡
        colors: [
          Colors.redAccent,
          Colors.orange,
        ],
        ///颜色过渡的开始位置  左上角
        begin: Alignment.topLeft,
        ///颜色过渡的结束位置  右下角
        end: Alignment.bottomRight,
      ),
    );
  }

  buildDefaultIcon() {
    return Icon(
        ///图标数据
        CupertinoIcons.phone_solid,
        ///图标大小
        size: 18,
    );
  }
}
