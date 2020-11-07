import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
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
        margin: EdgeInsets.all(20),
        child: Column(
          children: [buildTextButton()],
        ),
      ),
    );
  }

  Widget buildTextButton() {
    return TextButton(
      onPressed: () {},
      child: Text("TextButton按钮"),
    );
  }

  //这是一个文本按钮 未设置点击事件下的样式
  Widget buildTextButton2() {
    return TextButton(
      child: Text("TextButton按钮"),
      //添加一个点击事件
      onPressed: () {},
      //设置按钮是否自动获取焦点
      autofocus: true,
      //定义一下文本样式
      style: ButtonStyle(
        //定义文本的样式 这里设置的颜色是不起作用的
        textStyle: MaterialStateProperty.all(
            TextStyle(fontSize: 18, color: Colors.red)),
        //设置按钮上字体与图标的颜色
        //foregroundColor: MaterialStateProperty.all(Colors.deepPurple),
        //更优美的方式来设置
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.focused) &&
                !states.contains(MaterialState.pressed)) {
              //获取焦点时的颜色
              return Colors.blue;
            } else if (states.contains(MaterialState.pressed)) {
              //按下时的颜色
              return Colors.deepPurple;
            }
            //默认状态使用灰色
            return Colors.grey;
          },
        ),
        //背景颜色
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          //设置按下时的背景颜色
          if (states.contains(MaterialState.pressed)) {
            return Colors.blue[200];
          }
          //默认不使用背景颜色
          return null;
        }),
        //设置水波纹颜色
        overlayColor: MaterialStateProperty.all(Colors.yellow),
        //设置阴影  不适用于这里的TextButton
        elevation: MaterialStateProperty.all(0),
        //设置按钮内边距
        padding: MaterialStateProperty.all(EdgeInsets.all(10)),
        //设置按钮的大小
        minimumSize: MaterialStateProperty.all(Size(200, 100)),

        //设置边框
        side:
            MaterialStateProperty.all(BorderSide(color: Colors.grey, width: 1)),
        //外边框装饰 会覆盖 side 配置的样式
        shape: MaterialStateProperty.all(StadiumBorder()),
      ),
    );
  }
}
