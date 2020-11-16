import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/9/25.
///
/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/10/31.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 西瓜视频 https://www.toutiao.com/c/user/token/MS4wLjABAAAAYMrKikomuQJ4d-cPaeBqtAK2cQY697Pv9xIyyDhtwIM/
/// 知乎视频 https://www.zhihu.com/people/zhao-long-90-89
///
///

//应用入口
void main() {
  ///启动根目录
  runApp(MaterialApp(
    theme: ThemeData(primaryColor: Colors.grey[200]),
    home: Example507(),
  ));
}

///代码清单 5-28 下拉放大顶部图片Demo
///lib/code/code5/example_507_NestScrollView.dart
class Example507 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ExampleState();
  }
}

class _ExampleState extends State<Example507>
    with SingleTickerProviderStateMixin {
  //SliverAppBar展开的高度
  double _defaultExpandHeight = 240;

  //初始化要加载到图片上的高度
  double _extraPicHeight = 0;

  //图片填充类型（刚开始滑动时是以宽度填充，拉开之后以高度填充）
  BoxFit _fitType = BoxFit.fitWidth;

  //前一次手指所在处的y值
  double _prePointDy = 0;

  //动画控制器
  AnimationController _ationController;

  //Stream 控制器用来这里的局部刷新功能
  StreamController<double> _streamController = new StreamController();

  //页面初始化方法
  @override
  void initState() {
    super.initState();
    //初始化 回弹执行时间为 400毫秒
    _ationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    //添加一个动画执行过程实时监听
    _ationController.addListener(() {
      //_ationController.value 的值是从 0.0~1.0
      _streamController.add(_extraPicHeight * (1.0 - _ationController.value));
    });

    //添加一个动画执行状态监听
    _ationController.addStatusListener((status) {
      //获取动画状态
      AnimationStatus animationStatus = _ationController.status;
      //动画执行完成
      if (animationStatus == AnimationStatus.completed) {
        //更新图片展开添加的高度为0
        _extraPicHeight = 0;
        //修改图片的填充方式
        _fitType = BoxFit.fitWidth;
      }
    });
  }

  //页面销毁回调生命周期
  @override
  void dispose() {
    super.dispose();
    //关闭通道
    _streamController.close();
    //释放动画控制器
    _ationController.dispose();
  }

  ///代码清单 5-29 下拉放大顶部图片Demo build函数
  ///lib/code/code5/example_507_NestScrollView.dart
  @override
  Widget build(BuildContext context) {
    //手势监听
    return Listener(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: NestedScrollView(
          physics: BouncingScrollPhysics(),
          //配置可折叠的头布局
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [buildStreamBuilder()];
          },
          //页面的主体内容
          body: PersonPage(),
        ),
      ),
      onPointerMove: (result) {
        //手指的移动时
        updatePicHeight(result.position.dy); //自定义方法，图片的放大由它完成。
      },
      onPointerUp: (result) {
        //当手指抬起离开屏幕时
        resetSetPicHeight();
      },
    );
  }

  ///代码清单 5-30 下拉放大顶部图片Demo build函数
  ///lib/code/code5/example_507_NestScrollView.dart
  StreamBuilder<double> buildStreamBuilder() {
    return StreamBuilder<double>(
      //绑定流
      stream: _streamController.stream,
      //初始化的数据 这里用作图片放大的高度
      initialData: 0.0,
      builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
        //构建需要更新的 Widget
        return buildSliverAppBar(snapshot.data);
      },
    );
  }

  ///代码清单 5-31 下拉放大顶部图片Demo SliverAppBar 的创建
  ///lib/code/code5/example_507_NestScrollView.dart
  Widget buildSliverAppBar(double extraHeight) {
    return SliverAppBar(
      title: Text("详情"),
      //标题居中
      centerTitle: true,
      floating: false,
      pinned: true,
      snap: false,
      elevation: 0.0,
      //展开的高度
      expandedHeight: _defaultExpandHeight + extraHeight,
      //第二部分 AppBar下的内容区域
      flexibleSpace: FlexibleSpaceBar(
        //背景
        //配置的是一个widget也就是说在这里可以使用任意的
        //Widget组合 在这里直接使用的是一个图片
        background: Column(
          children: [
            Container(
              //缩放的图片
              width: MediaQuery.of(context).size.width,
              child: Image.asset("images/banner3.webp",
                  height: 240 + extraHeight, fit: _fitType),
            )
          ],
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 80),
        child: Container(
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 30),
                padding: EdgeInsets.only(right: 16, left: 16),
                decoration: BoxDecoration(
                    color: Color(0xFFFBFBFB),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey[200]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2))),
                          child: Text(
                            "编辑资料",
                            style:
                                TextStyle(color: Colors.black87, fontSize: 12),
                          ),
                          padding: EdgeInsets.only(
                              left: 40, right: 40, top: 6, bottom: 6),
                          margin: EdgeInsets.only(right: 6),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2))),
                          child: Text(
                            "我的认证",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          padding: EdgeInsets.only(
                              left: 40, right: 40, top: 6, bottom: 6),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Text(
                          "早起的年轻人",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 6),
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2))),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                "images/man.png",
                                width: 12,
                                height: 12,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                "男",
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 12),
                              )
                            ],
                          ),
                          padding: EdgeInsets.only(
                              left: 4, right: 4, top: 2, bottom: 2),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    border: Border.all(color: Colors.white, width: 3.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(1, 1),
                          blurRadius: 10)
                    ]),
                width: 88,
                height: 88,
                child: ClipOval(
                  child: Image.asset(
                    "images/banner3.webp",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///代码清单 5-32
  ///lib/code/code5/example_507_NestScrollView.dart
  updatePicHeight(changed) {
    print("extraPicHeight $_extraPicHeight prev_dy $_prePointDy");
    //安全判断  qwer 77890
    if (_prePointDy == 0.0) {
      _prePointDy = changed;
    }
    //向下滑动时 会大于0
    if (_extraPicHeight >= 0) {
      //改变图片的填充方式，让它由以宽度填充变为以高度填充，从而实现了图片视角上的放大。
      _fitType = BoxFit.fitHeight;
    } else {
      //向上滑动时折叠隐藏
      _fitType = BoxFit.fitWidth;
    }
    //每次滑动的距离 加载到图片上的高度。
    _extraPicHeight += changed - _prePointDy;
    //更新手指位点坐标
    _prePointDy = changed;
    //只有向下滑动时图片放大的情况再更新放大的效果
    if (_extraPicHeight >= -300) {
      //更新图片的高度
      _streamController.add(_extraPicHeight);
    } else {
      //如果是向上折叠的过程不记录手指点位
      _prePointDy = 0.0;
    }
  }

  ///代码清单 5-33
  ///lib/code/code5/example_507_NestScrollView.dart
  resetSetPicHeight() {
    if (_prePointDy >= 0) {
      _prePointDy = 0;
      //设置动画让extraPicHeight的值从当前的值渐渐回到 0
      _ationController.reset();
      _ationController.forward();
    }
  }
}

class PersonPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PersonPage();
  }
}

class _PersonPage extends State {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return buildItemWidget();
      },
      itemCount: 100,
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          height: 1,
          color: Colors.grey[200],
        );
      },
    );
  }

  Widget buildItemWidget() {
    //水波纹点击事件监听
    return InkWell(
      //手指点击抬起时的回调
      onTap: () {
        //打开新的页面
      },
      child: Container(
        padding: EdgeInsets.all(10),
        color: Colors.white,
        //线性布局左右排列
        child: Column(children: [
          Row(
            //主轴方向开始对齐 在这里是左对齐
            mainAxisAlignment: MainAxisAlignment.start,
            //交叉轴上开始对齐 在这里是顶部对齐
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //右侧的文本区域
              buildRightTextArea(),
              //左侧的图片
              buildLeftImage(),
            ],
          ),
          Row(
            children: [
              Text("10000播放",style: TextStyle(color: Colors.grey,fontSize: 12),),
              SizedBox(width: 10,),
              Text("245评论",style: TextStyle(color: Colors.grey,fontSize: 12),),
              SizedBox(width: 10,),
              Text("3天前",style: TextStyle(color: Colors.grey,fontSize: 12),),
            ],
          )
        ],),
      ),
    );
  }

  ///左侧的图片区域
  Container buildLeftImage() {
    return Container(
      margin: EdgeInsets.only(left: 12),
      child: Hero(
        tag: "test",
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(2)),
          child: Image.asset(
            "images/banner3.webp",
            width: 116,
            fit: BoxFit.fill,
            height: 76,
          ),
        ),
      ),
    );
  }

  ///右侧的文本区域
  Expanded buildRightTextArea() {
    return Expanded(
      child: Text(
        "优美的应用体验 来自于细节的处理，更源自于码农的自我要求与努力，当然也需要码农年轻灵活的思维。",
        softWrap: true,
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
