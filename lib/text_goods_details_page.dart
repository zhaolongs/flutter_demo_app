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
  //NestedScrollView的滚动控制器
  //用来监听滚动距离
  ScrollController scrollController = new ScrollController();

  //在这里标签页面使用的是TabView所以需要创建一个控制器
  TabController tabController;
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
    //初始化
    tabController = new TabController(length: 3, vsync: this);
    //轮播图
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
      _pageController.animateToPage(currentIndex % 3,
          duration: Duration(milliseconds: 200), curve: Curves.ease);
      setState(() {});
    });
  }

  //页面销毁回调生命周期
  @override
  void dispose() {
    super.dispose();
    //释放资源
    scrollController.dispose();
    tabController.dispose();
    _timer.cancel();
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
          //页面的主体内容
          //是一个 NestedScrollView
          child: buildNestedScrollView()),
    );
  }


  //动态计算展开的高度，以很好的适配图片的显示
  void calculateExpandedHeight() {}

  //NestedScrollView 的基本使用
  Widget buildNestedScrollView() {
    //滑动视图
    return NestedScrollView(
      //配置控制器
      controller: scrollController,
      //配置可折叠的头布局
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [buildSliverAppBar2()];
      },
      //页面的主体内容
      body: buidChildWidget(),
    );
  }

  //lib/code15/main_data1508.dart
  //SliverAppBar
  //flexibleSpace可折叠的内容区域
  buildSliverAppBar2() {
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

  //lib/code15/main_data1508.dart
  //显示图片与角标区域Widget构建
  buildFlexibleSpaceWidget() {
    return Column(
      children: [
        Container(
          height: 240,
          child: Stack(
            children: [
              //用于显示图片的PageView
              buildImagePage(),
              //角标显示
              buildCornerMark(),
            ],
          ),
        ),
        Container(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 120,
                  color: Colors.blueGrey,
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.brown,
                  height: 120,
                ),
              ),
            ],
          ),
        )
      ],
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

  //当前显示图片的角标
  int currentShowImageIndex = 0;

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
              currentShowImageIndex = pageIndex;
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
            color: Color(0x50999999),

            //圆角矩形的裁剪
            borderRadius: BorderRadius.all(Radius.circular(15))),

        //显示角标的文本
        child: Text(
          "${currentShowImageIndex + 1}/${imagePathList.length}",
          style: TextStyle(fontSize: 12, color: Colors.white),
        ),
      ),
    );
  }

  //lib/code15/main_data1508.dart
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
