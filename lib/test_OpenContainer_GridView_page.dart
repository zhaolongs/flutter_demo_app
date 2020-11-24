import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/11/1.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///

//启动函数
void main() {
  runApp(RootApp());
}

//根目录
class RootApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //默认启动的页面
      home: AnimationOpenContainerPage(),
    );
  }
}

class AnimationOpenContainerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<AnimationOpenContainerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //页面背景
      backgroundColor: Colors.grey[300],
      //标题
      appBar: AppBar(
        title: Text("浏览图片"),
      ),
      //页面主体
      body: buildBodyWidget(),
    );
  }

  Widget buildBodyWidget() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(10),
      //九宫格
      child: new GridView.builder(
        //配置列代理
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //每行三列
          crossAxisCount: 3,
          //行之间的间隔
          mainAxisSpacing: 1.0,
          //列之间的间隔
          crossAxisSpacing: 1.0,
          //子 Item 的 宽高比
          childAspectRatio: 0.8,
        ),
        //子Item的个数
        itemCount: 100,
        //子Item的具体构建
        itemBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.grey,
            child: buildItemAnimationWidget(index),
          );
        },
      ),
    );
  }

  Widget buildItemAnimationWidget(int index) {
    return OpenContainer(
      //定义下过渡时间
      transitionDuration: Duration(milliseconds: 800),
      //当前显示的背景色
      closedColor: Colors.transparent,
      //打开过程中的背景色
      openColor: Colors.transparent,
      //打开Widget的阴影
      openElevation: 0.0,
      //当前显示Widget的阴影
      closedElevation: 0.0,
      //点击打开 的页面 如这里的详情页面
      openBuilder:
          (BuildContext context, void Function({Object returnValue}) action) {
        return DetailsPage();
      },
      //当前显示的Widget
      closedBuilder: (BuildContext context, void Function() action) {
        return buildItem(index);
      },
    );
  }

  Widget buildItemWidget(int index) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return DetailsPage();
        }));
      },
      child: buildItem(index),
    );
  }






  Widget buildOpenContainer(int index) {
    return OpenContainer(
      //背景颜色
      closedColor: Colors.transparent,
      //阴影
      closedElevation: 0.0,
      //圆角
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      //显示的布局
      closedBuilder: (context, action) {
        return buildItem(index);
      },
      //过渡的方式
      transitionType: ContainerTransitionType.fade,
      //过渡的时间
      transitionDuration: const Duration(milliseconds: 800),

      //即将打开的 Widget 的边框样式
      openShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(1.0)),
      ),
      //即将打开的 Widget 的背景
      openColor: Colors.transparent,
      //阴影
      openElevation: 1.0,
      //布局
      openBuilder: (context, action) {
        return DetailsPage();
      },
    );
  }

  Widget buildItem(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/banner3.webp",
          width: 96,
          fit: BoxFit.fill,
          height: 96,
        ),
        SizedBox(
          width: 12,
        ),
        Text(
          "优美的应用",
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          style: TextStyle(fontSize: 16),
        )
      ],
    );
  }
}

class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //背景透明
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("商品详情"),
      ),
      body: buildCurrentWidget(),
    );
  }

  Widget buildCurrentWidget() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            "assets/images/banner3.webp",
            fit: BoxFit.fill,
          ),
          SizedBox(
            width: 12,
          ),
          Text(
            "每日分享 精彩一刻",
            style: TextStyle(fontSize: 22),
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            child: Text(
              "优美的应用体验 来自于细节的处理，更源自于码农的自我要求与努力",
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
