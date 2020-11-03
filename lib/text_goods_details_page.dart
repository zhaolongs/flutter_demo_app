import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/test_slid_banner_page.dart';

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
      theme: ThemeData(primaryColor: Colors.grey[200]),
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

  //在这里标签页面使用的是TabView所以需要创建一个控制器
  TabController tabController;

  //页面初始化方法
  @override
  void initState() {
    super.initState();
    //初始化
    tabController = new TabController(length: 3, vsync: this);
  }

  //页面销毁回调生命周期
  @override
  void dispose() {
    tabController.dispose();
  }

  //页面构建方法
  @override
  Widget build(BuildContext context) {
    //构建页面的主体
    return Scaffold(
      //下拉刷新
      body: RefreshIndicator(
        //可滚动组件在滚动时会发送ScrollNotification类型的通知
        notificationPredicate: (ScrollNotification notifation) {
          //该属性包含当前ViewPort及滚动位置等信息
          ScrollMetrics scrollMetrics = notifation.metrics;
          if (scrollMetrics.minScrollExtent == 0) {
            return true;
          } else {
            return false;
          }
        },
        //下拉刷新回调方法
        onRefresh: () async {
          //模拟网络刷新 等待2秒
          await Future.delayed(Duration(milliseconds: 2000));
          //返回值以结束刷新
          return Future.value(true);
        },
        child: buildNestedScrollView(),
      ),
    );
  }

  //NestedScrollView 的基本使用
  Widget buildNestedScrollView() {
    //滑动视图
    return NestedScrollView(
      //配置可折叠的头布局
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [buildSliverAppBar()];
      },
      //页面的主体内容
      body: buidChildWidget(),
    );
  }

  //SliverAppBar
  //flexibleSpace可折叠的内容区域
  buildSliverAppBar() {
    return SliverAppBar(
      title: buildHeader(),
      //标题居中
      centerTitle: true,
      //当此值为true时 SliverAppBar 会固定在页面顶部
      //当此值为fase时 SliverAppBar 会随着滑动向上滑动
      pinned: true,
      //当值为true时 SliverAppBar设置的title会随着上滑动隐藏
      //然后配置的bottom会显示在原AppBar的位置
      //当值为false时 SliverAppBar设置的title会不会隐藏
      //然后配置的bottom会显示在原AppBar设置的title下面
      floating: false,
      //当snap配置为true时，向下滑动页面，SliverAppBar（以及其中配置的flexibleSpace内容）会立即显示出来，
      //反之当snap配置为false时，向下滑动时，只有当ListView的数据滑动到顶部时，SliverAppBar才会下拉显示出来。
      snap: false,
      elevation: 0.0,
      //展开的高度
      expandedHeight: 380,
      //AppBar下的内容区域
      flexibleSpace: FlexibleSpaceBar(
        //背景
        //配置的是一个widget也就是说在这里可以使用任意的
        //Widget组合 在这里直接使用的是一个图片
        background: buildFlexibleSpaceWidget(),
      ),
      bottom: buildFlexibleTooBarWidget(),
    );
  }

  //通常在用到 PageView + BottomNavigationBar 或者 TabBarView + TabBar 的时候
  //大家会发现当切换到另一页面的时候, 前一个页面就会被销毁, 再返回前一页时, 页面会被重建,
  //随之数据会重新加载, 控件会重新渲染 带来了极不好的用户体验.
  //由于TabBarView内部也是用的是PageView, 因此两者的解决方式相同
  //页面的主体内容
  Widget buidChildWidget() {
    return TabBarView(
      controller: tabController,
      children: <Widget>[
        ItemPage1(1),
        ItemPage1(2),
        ItemPage1(3),
      ],
    );
  }

  //构建SliverAppBar的标题title
  buildHeader() {
    //透明组件
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 10),
      height: 38,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_rounded,
            size: 18,
          ),
          SizedBox(
            width: 4,
          ),
          Text(
            "搜索",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  //显示图片与角标区域Widget构建
  buildFlexibleSpaceWidget() {
    return Column(
      children: [
        Container(
          height: 240,
          child: BannerHomepage(isTitle: false,),
        ),
        Container(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 120,
                  color: Colors.blueGrey,
                  child: Image.asset("images/banner5.jpeg"),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.brown,
                  height: 120,
                  child: Image.asset("images/banner6.jpeg"),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  //[SliverAppBar]的bottom属性配制
  Widget buildFlexibleTooBarWidget() {
    //[PreferredSize]用于配置在AppBar或者是SliverAppBar
    //的bottom中 实现 PreferredSizeWidget
    return PreferredSize(
      //定义大小
      preferredSize: Size(MediaQuery.of(context).size.width, 44),
      //配置任意的子Widget
      child: Container(
        alignment: Alignment.center,
        child: Container(
          color: Colors.grey[200],
          //随着向上滑动，TabBar的宽度逐渐增大
          //父布局Container约束为 center对齐
          //所以程现出来的是中间x轴放大的效果
          width: MediaQuery.of(context).size.width,
          child: TabBar(
            controller: tabController,
            tabs: <Widget>[
              new Tab(
                text: "标签一",
              ),
              new Tab(
                text: "标签二",
              ),
              new Tab(
                text: "标签三",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemPage1 extends StatefulWidget {
  int pageIndex;

  ItemPage1(this.pageIndex);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<ItemPage1>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 44,
          child: Text("item $index"),
        );
      },
      itemCount: 100,
    );
  }
}
