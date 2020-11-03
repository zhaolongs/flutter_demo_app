import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/11/2.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///

void main() {
  runApp(RootApp());
}

class RootApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BannerHomepage(),
    );
  }
}

class BannerHomepage extends StatefulWidget {
  final bool isTitle;


  BannerHomepage({this.isTitle=true});

  @override
  State<StatefulWidget> createState() {
    return _BannerHomepageState();
  }
}

class _BannerHomepageState extends State<BannerHomepage> {

  //轮播图 PageView 使用的控制器
  PageController _pageController;
  //定时器自动轮播
  Timer _timer;
  //本地资源图片
  List<String> imageList = [
    "images/banner1.webp",
    "images/banner2.webp",
    "images/banner3.webp",
    "images/banner4.webp",
  ];

  //当前显示的索引
  int currentIndex = 1000;

  @override
  void initState() {
    super.initState();
    //初始化控制器
    // initialPage 为初始化显示的子Item
    _pageController = new PageController(initialPage: currentIndex);

    ///当前页面绘制完第一帧后回调
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      startTimer();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }



  void startTimer() {
    //间隔两秒时间
    _timer = new Timer.periodic(Duration(milliseconds: 2000), (value) {
      print("定时器");
      currentIndex++;
      //触发轮播切换
      _pageController.animateToPage(currentIndex,
          duration: Duration(milliseconds: 200), curve: Curves.ease);
      //刷新
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:widget.isTitle? AppBar(
        title: Text("轮播图"),
      ):null,
      body: Container(
        child: buildBanner(),
      ),
    );
  }

  Widget buildBanner() {
    return Container(
      // height: 200,
      width: double.infinity,
      child: Stack(
        children: [
          //轮播图片
          buildBannerWidget(),
          //指示器
          buildTipsWidget(),
        ],
      ),
    );
  }



  buildBannerWidget() {
    //懒加载方式构建
    return PageView.builder(
      //构建每一个子Item的布局
      itemBuilder: (BuildContext context, int index) {
        return buildPageViewItemWidget(index);
      },
      //控制器
      controller: _pageController,
      //轮播个数 无限轮播 ??
      itemCount: imageList.length * 10000,
      //PageView滑动时回调
      onPageChanged: (int index) {
        setState(() {
          currentIndex = index;
        });
      },
    );
  }

  //轮播显示图片
  buildPageViewItemWidget(int index) {
    return Image.asset(
      imageList[index % imageList.length],
      fit: BoxFit.fill,
    );
  }

  //指示器
  buildTipsWidget() {
    return Positioned(
      bottom: 20,
      right: 20,
      child: Container(
        //内边距
        padding: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
        //圆角边框
        decoration: BoxDecoration(
          //背景
            color: Colors.white,
            //边框圆角
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child:
            Text("${currentIndex % imageList.length + 1}/${imageList.length}"),
      ),
    );
  }
}
