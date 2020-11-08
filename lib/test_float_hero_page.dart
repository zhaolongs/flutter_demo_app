import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
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
      floatingActionButton: FloatingActionButton(
        heroTag: "testHero",
        child: Icon(Icons.share),
        onPressed: () {
          openBottomPage();
        },
      ),
    );
  }

  void openBottomPage() {
    Navigator.of(context).push(
      new PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return ItemPage();
        },
      ),
    );
  }
}

class ItemPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ItemPageState();
  }
}

class _ItemPageState extends State<ItemPage> {
  List<IconData> iconList = [
    Icons.school_rounded,
    Icons.school_rounded,
    Icons.school_rounded,
    Icons.score,
    Icons.score,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Hero(
              flightShuttleBuilder: (flightContext, animation, direction,
                  fromContext, toContext) {
                return FadeTransition(
                  // 从0开始到1
                  opacity: Tween(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      // 传入设置的动画
                      parent: animation,
                      // 设置效果，快进漫出   这里有很多内置的效果
                      curve: Curves.ease,
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.all(40),
                    color: Colors.blue,
                  ),
                );
              },
              tag: "testHero",
              child: Material(
                child: Container(
                  margin: EdgeInsets.all(20),
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Stack(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      Positioned(
                        top: 40,
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(top: 8),
                          //配置列代理
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            //每行三列
                            crossAxisCount: 4,
                            //行之间的间隔
                            mainAxisSpacing: 1.0,
                            //列之间的间隔
                            crossAxisSpacing: 1.0,
                            //子 Item 的 宽高比
                            childAspectRatio: 1.8,
                          ),
                          //子Item的个数
                          itemCount: iconList.length,
                          //子Item的具体构建
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: 44,
                                    width: 44,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                    ),
                                    child: Icon(
                                      iconList[index],
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
