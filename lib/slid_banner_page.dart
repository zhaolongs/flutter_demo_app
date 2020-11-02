import 'dart:async';

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
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScrollHomePageState();
  }
}

class _ScrollHomePageState extends State with SingleTickerProviderStateMixin {
  //轮播图使用的控制器
  PageController _pageController;
  //轮播图使用的定时器
  Timer _timer;
  //轮播图使用的当前的角标
  int currentIndex = 0;

  //页面初始化方法
  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ///当前页面绘制完第一帧后回调
      ///在这里开启定时器
      startTimer();
    });
  }

  void startTimer() {
    ///间隔2000毫秒执行时间
    _timer = Timer.periodic(Duration(milliseconds: 2000), (timer) {
      currentIndex++;
      _pageController.animateToPage(currentIndex % imagePathList.length,
          duration: Duration(milliseconds: 200), curve: Curves.ease);
      setState(() {});
    });
  }

  //页面销毁回调生命周期
  @override
  void dispose() {
    super.dispose();
    //释放资源
    _timer.cancel();
  }

  //页面构建方法
  @override
  Widget build(BuildContext context) {
    //构建页面的主体
    return Scaffold(
      appBar: AppBar(title: Text("轮播图"),),
      body: buildColumnWidget(),
    );
  }

  //显示图片与角标区域Widget构建
  buildColumnWidget() {
    return  Container(
      height: 240,
      child: Stack(
        children: [
          //用于显示图片的PageView
          buildImagePage(),
          //角标显示
          buildCornerMark(),
        ],
      ),
    );
  }

  //lib/code15/main_data1508.dart
  //图片数据
  List<String> imagePathList = [
    "images/banner1.webp",
    "images/banner2.webp",
    "images/banner3.webp",
    "images/banner4.webp",
  ];

  //构建用来显示多张图片的PageView
  //支持左右滚动
  Widget buildImagePage() {
    return Container(
      child: PageView.builder(
          controller: _pageController,
          //页面滚动后的回调
          //参数 [pageIndex] 为当前页面的角标
          onPageChanged: (int pageIndex) {
            setState(() {
              currentIndex = pageIndex;
            });
          },

          //滚动到边界时的回弹效果
          physics: BouncingScrollPhysics(),

          //图片个数
          itemCount: imagePathList.length,

          //构建每个条目的显示
          itemBuilder: (BuildContext context, int index) {
            return buildFlexibleSpaceItemWidget(index);
          }),
    );
  }

  //构建显示图片的Widget
  //参数[index]为当前显示PageView的角标 从0开始
  Widget buildFlexibleSpaceItemWidget(int index) {
    //这里是加载使用的本地资源目录assets下的文件
    //实际项目开发中一般使用的网络图片
    //只需要替换这里使用网络方式加载即可
    return Image.asset(
      imagePathList[index],
      //图片填充
      fit: BoxFit.fill,
    );
  }

  //lib/code15/main_data1508.dart
  //角标显示
  //用来显示滚动图片的位置
  Widget buildCornerMark() {
    //在层叠布局Stack中通过Positioned来定位子Widget
    //这里是右下角对齐
    return Positioned(
      bottom: 12,
      right: 12,

      //通过Container来实现一个半透明的体育场的背景
      child: Container(
        //内边距的设置
        padding: EdgeInsets.only(left: 10, right: 10, top: 4, bottom: 4),

        //边框的装饰
        decoration: BoxDecoration(

            //半透明背景设置
            color: Color(0x90999999),

            //圆角矩形的裁剪
            borderRadius: BorderRadius.all(Radius.circular(15))),

        //显示角标的文本
        child: Text(
          "${currentIndex % imagePathList.length + 1}/${imagePathList.length}",
          style: TextStyle(fontSize: 12, color: Colors.white),
        ),
      ),
    );
  }
}
