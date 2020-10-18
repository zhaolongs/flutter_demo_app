import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomScrollDemo2Page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScrollHomePageState();
  }
}

class _ScrollHomePageState extends State {
  ///图片地址
  String imageUrl =
      "http://file02.16sucai.com/d/file/2015/0408/779334da99e40adb587d0ba715eca102.jpg";

  @override
  Widget build(BuildContext context) {
    ///页面主体脚手架
    return Scaffold(
        appBar: AppBar(
          title: Text("测试"),
        ),

        /// 处理滑动
        body: CustomScrollView(
          slivers: <Widget>[
            TodayListTile(
              child: Container(
                child: Text("内容视图"),
                color: Colors.lightBlueAccent,
              ),
            ),

            TodayListTile(
              child: Container(
                child: Text("内容视图"),
                color: Colors.lightBlueAccent,
              ),
            ),

            SliverToBoxAdapter(
              child: Container(
                height: 800,
                alignment: Alignment.bottomCenter,
                color: Colors.grey,
                child: Text("其他内容部分"),
              ),
            )
          ],
        ));
  }
}

class TodayListTile extends StatefulWidget {
  const TodayListTile({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _TodayListTileState createState() => _TodayListTileState();
}

class _TodayListTileState extends State<TodayListTile> {
  double mainHeight;

  final GlobalKey mainKey = GlobalKey();

  double maxExtend = 100;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => setState(
        () {
          mainHeight = mainKey.currentContext.size.height;
          maxExtend = mainHeight;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: false,
      delegate: _TodayListTileDelegate(
          mainKey: mainKey,
          maxExtent: maxExtend,
          widget: widget,),
    );
  }
}

class _TodayListTileDelegate extends SliverPersistentHeaderDelegate {
  final TodayListTile widget;
  _TodayListTileDelegate({
    this.widget,
    this.maxExtent,
    this.mainKey,

  });

  final Key mainKey;

  ///开始折叠隐藏的高度
  final int foldHeight = 60;


  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    ///shrinkOffset 当前滑动的距离 相对于本 Widget 来讲
    print("$shrinkOffset   $maxExtent");
    var flagSize = maxExtent - shrinkOffset;
    ///v 的取值范围为 0 ~ 1.0
    var v = flagSize.clamp(0, foldHeight) / foldHeight;

    bool isShrinking = v < 1;
   ///计算缩放比例
    var scale = v * 0.2 + 0.8;
   ///y轴方向的平移距离
    var dy = 5 - (flagSize.clamp(0, 30) / 30) * 5;
    /// Transform 的缩放变换
    var child = Transform.scale(
      scale: scale,
      /// Transform 的平移变换
      child: Transform.translate(
        offset: Offset(0, dy),
        child: Container(
          margin: EdgeInsets.only(bottom: 5),
          height: isShrinking ? 40 : null,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 40),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.18),
                ),
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        key: mainKey,
                        child: widget.child,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    if (isShrinking) {
      return SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: IgnorePointer(
          ignoringSemantics: false,
          child: Container(
            padding: EdgeInsets.only(bottom: 10),
            child: child,
          ),
        ),
      );
    }

    return child;
  }

  @override
  double maxExtent;

  @override
  double get minExtent => 0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
