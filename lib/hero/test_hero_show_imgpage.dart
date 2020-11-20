import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/11/12.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
import 'dart:math' as math;

///一个具备点击事件的 Image
class CustomImage extends StatelessWidget {
  CustomImage({@required this.assetPath, @required this.onTap, Key key})
      : super(key: key);

  //图片的资源路径
  final String assetPath;

  //图片的点击事件
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue.withOpacity(0.25),
      child: InkWell(
        onTap: onTap,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints size) {
            return Image.asset(
              assetPath,
              fit: BoxFit.contain,
            );
          },
        ),
      ),
    );
  }
}

class OvalTransitRectWidget extends StatelessWidget {
  OvalTransitRectWidget({
    Key key,
    @required this.maxRadius,
    @required this.child,
  })  : clipRectSize = 2.0 * (maxRadius / math.sqrt2),
        super(key: key);

  final double maxRadius;
  final double clipRectSize;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Center(
        child: SizedBox(
          width: clipRectSize,
          height: clipRectSize,
          child: ClipRect(
            child: child,
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: RadialExpansionDemo()));
}

class RadialExpansionDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('让你的应用程序动起来'),
      ),
      body: Container(
        //填充
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            //底部对齐
            Positioned(
              left: 40,
              right: 40,
              bottom: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildHeroImage(context, 'images/maomi1.jpg', '哈哈'),
                  _buildHeroImage(context, 'images/maomi2.jpg', '你知道的！！！'),
                  _buildHeroImage(context, 'images/maomi3.jpg', '困困困？？？'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHeroImage(
      BuildContext context, String imageName, String description) {
    return Container(
      width: 68,
      height: 68,
      child: Hero(
        //自定义路径方式
        createRectTween: (Rect begin, Rect end) {
          return MaterialRectCenterArcTween(begin: begin, end: end);
        },
        //Hero动画的标签
        tag: imageName,
        //自定义裁剪组件
        child: OvalTransitRectWidget(
          maxRadius: 140,
          //自定义具有点击事件的图片
          child: CustomImage(
            //资源目录下的图片路径
            assetPath: imageName,
            //点击事件回调
            onTap: () {
              //自定义路由方式打开新的页面
              openPageFunction(context, imageName, description);
            },
          ),
        ),
      ),
    );
  }

  ///自定义路由方式打开新的页面
  void openPageFunction(
      BuildContext context, String imageName, String description) {
    Navigator.of(context).push(
      buildCustomRoute2(
        tagChild: DetailsPage(
          imageName: imageName,
          description: description,
        ),
      ),
    );
  }

  buildCustomRoute({Widget tagChild}) {
    return PageRouteBuilder<void>(
      //背景透明方式打开
      opaque: false,
      //打开页面的过渡时间
      transitionDuration: Duration(milliseconds: 500),
      //退出页面的过渡时间
      reverseTransitionDuration: Duration(milliseconds: 800),
      //页面构建
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return tagChild;
      },
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return FadeTransition(
          opacity: Tween(begin: 0.0, end: 0.75).animate(
            CurvedAnimation(curve: Curves.fastOutSlowIn, parent: animation),
          ),
          child: child,
        );
      },
    );
  }

  buildCustomRoute2({Widget tagChild}) {
    return PageRouteBuilder<void>(
      //背景透明方式打开
      opaque: false,
      //打开页面的过渡时间
      transitionDuration: Duration(milliseconds: 500),
      //退出页面的过渡时间
      reverseTransitionDuration: Duration(milliseconds: 800),
      //页面构建
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget child) {
            return Opacity(
              opacity: Interval(0.0, 0.75, curve: Curves.fastOutSlowIn)
                  .transform(animation.value),
              child: tagChild,
            );
          },
        );
      },
    );
  }
}

//

class DetailsPage extends StatelessWidget {
  final String imageName;
  final String description;

  DetailsPage({this.imageName, this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //半透明的背景
      backgroundColor: Colors.black54.withOpacity(0.2),
      //居中显示
      body: Center(
        //卡片
        child: Card(
          elevation: 8.0,
          //线性排列的文本与图片
          child: buildColumn(context),
        ),
      ),
    );
  }

  ///线性排列的文本与图片
  Column buildColumn(BuildContext context) {
    return Column(
      //内容包裹
      mainAxisSize: MainAxisSize.min,
      children: [
        //定义卡片中内容图片的大小
        SizedBox(
          width: 140 * 2.0,
          height: 140 * 2.0,
          //构建Hero
          child: buildHero(context),
        ),
        Text(
          description,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        //占位
        const SizedBox(height: 30.0),
      ],
    );
  }

  Hero buildHero(BuildContext context) {
    return Hero(
      //自定义形状过渡
      createRectTween: (Rect begin, Rect end) {
        //Materal 风格的矩形与圆形的动态过渡
        return MaterialRectCenterArcTween(begin: begin, end: end);
      },
      tag: imageName,
      //
      child: OvalTransitRectWidget(
        maxRadius: 140,
        child: CustomImage(
          assetPath: imageName,
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
