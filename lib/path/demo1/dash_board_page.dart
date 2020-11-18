import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/11/18.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
///代码清单
///
void main() {
  //启动根目录
  runApp(MaterialApp(
    home: ClipperCard(),
  ));
}


class ClipperCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        //裁剪背景
        child: ClipPath(
          //定义裁切路径
          clipper: BackgroundClipper(),
          child: buildContainer(context),
        ),
      ),
    );
  }

  //一个普通的背景
  Container buildContainer(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.width * 0.8 * 1.33,
      //背景装饰
      decoration: BoxDecoration(
        //线性渐变
        gradient: LinearGradient(
          //渐变使用到的颜色
          colors: [Colors.orange, Colors.deepOrangeAccent],
          //开始位置为右上角
          begin: Alignment.topRight,
          //结束位置为左下角
          end: Alignment.bottomLeft,
        ),
      ),
    );
  }
}

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double roundnessFactor = 50.0;
    Path path = Path();

    //移动到A点
    path.moveTo(0, size.height * 0.33);
    //画直线到B点 同时也充当 下一个二阶贝塞尔曲线 的起点
    path.lineTo(0, size.height - roundnessFactor);

    //二阶贝塞尔曲线 只有一个控制点
    // 控制点 C (0, size.height)
    // 终点 D (roundnessFactor, size.height)
    path.quadraticBezierTo(0, size.height, roundnessFactor, size.height);


    //二阶贝塞尔曲线 只有一个控制点
    //画直线到 E点 同时也充当 二阶贝塞尔曲线 的起点
    path.lineTo(size.width - roundnessFactor, size.height);
    // 控制点 F (size.width, size.height)
    // 终点 G (size.width, size.height - roundnessFactor)
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - roundnessFactor);

    //二阶贝塞尔曲线 只有一个控制点
    //画直线到 H 点 同时也充当 二阶贝塞尔曲线 的起点
    path.lineTo(size.width, roundnessFactor * 2);
    // 控制点 M 与 终点 K
    path.quadraticBezierTo(size.width - 10, roundnessFactor,
        size.width - roundnessFactor * 1.5, roundnessFactor * 1.5);

    //二阶贝塞尔曲线 只有一个控制点
    //画直线到 T点 同时也充当 二阶贝塞尔曲线 的起点
    path.lineTo(
        roundnessFactor * 0.6, size.height * 0.33 - roundnessFactor * 0.3);
    //控制点 W Z
    path.quadraticBezierTo(
        0, size.height * 0.33, 0, size.height * 0.33 + roundnessFactor);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
