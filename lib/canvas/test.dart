import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/11/20.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
/// 


///这是一个非常简单的应用程序，在屏幕中央显示一个太阳图标。太阳图标托管在一个容器中，这是您要装饰的容器。
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            width: 264,
            height: 360,
            decoration: CustomDecoration(24.0),
            child: Icon(
              Icons.wb_sunny,
              size: 90,
              color: Colors.orange,
            ),
          ),
        ),
      ),
    );
  }
}


///要创建自定义装饰，需要从 Flutter 框架中实现 Decoration 抽象类。
///这个抽象类在 Flutter 框架中有不同的实现，
///比如 ShapeDecoration、 BoxDecoration 和 FlutterLogoDecoration。
//创建一个实现 Decoration 抽象类的 CustomDecoration 类
class CustomDecoration extends Decoration {
  //创建一个构造函数，该构造函数接受一个双精度值，该值是您将绘制的模式的长度
  CustomDecoration(this._patternLength);

  //3
  final double _patternLength;

  //4
  @override
  BoxPainter createBoxPainter([onChanged]) {
    //5
    return _CustomDecorationPainter(_patternLength);
  }
}

///实现 BoxPainter BoxPainter 是一个绘制特定装饰的类。
///通过实现 BoxPainter 抽象类创建一个 _ CustomDecorationPainter 类。
///实现 BoxPainter 抽象类
class _CustomDecorationPainter extends BoxPainter {
  //创建一个构造函数，该构造函数接受一个双精度值，该值是您将绘制的模式的长度
  _CustomDecorationPainter(this._patternLength);

  //3
  final double _patternLength;

  //实现 BoxPainter 抽象类中的 paint ()方法，您的所有绘图代码都将通过该方法执行，
  // 其中有一个画布用于绘制装饰，一个偏移量用于将所有绘图放置到屏幕上的适当位置，还有一个配置用于知道您的画布(容器小部件)的大小
  //
  // 偏移量是一个点，这个点有个坐标，一对浮点数定义了它在画布上的精确位置。
  // 例如，x = 0和 y = 0的偏移量表示画布上的左上角。
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    //在这里，您使用 Offset 类中的“ & ”操作符，
    // 它结合一个 Offset 和一个 Size 来创建一个矩形，
    // 该矩形的左上角位于给定的偏移位置，其大小由 configuration.Size 给出。
    final Rect bounds = offset & configuration.size;
    _drawDecoration(canvas, bounds);
  }

  //1
  void _drawDecoration(Canvas canvas, Rect bounds) {
    //用于绘制大纲矩形，
    Paint innerPaint = Paint()..color = Colors.lightBlue;
    //用于绘制实心(填充)矩形
    Paint outerPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    //创建两个路径对象，第一个用于大纲矩形，第二个用于实心(实心)矩形
    Path innerPath = Path();
    Path outerPath = Path();

    //向左侧和右侧垂直方向添加装饰
    _addVerticalSides(bounds, innerPath, outerPath);

    _addHorizontalSides(bounds, innerPath, outerPath);

    //5
    canvas.drawPath(innerPath, innerPaint);
    canvas.drawPath(outerPath, outerPaint);
  }

  //1
  void _addVerticalSides(Rect bounds, Path innerPath, Path outerPath){
    //2 计算多少模式，你需要绘制填补高度的界限
    int patternsCount = bounds.height ~/ _patternLength;
    //3 计算精确的长度，为模式能够填补整个高度时
    double _accurateLength = bounds.height / patternsCount;

    //4 创建一个从0到 patternsCount 的 for 循环，添加需要填充整个高度的模式数
    for (var i = 0; i < patternsCount; ++i) {
      //5 创建一个高度和宽度等于 _ accurateLength 的 rect，并且在左侧，rect 将在第一次迭代中位于顶部，并且每次迭代时它将被移动(i * _ accurateLength)
      Rect leftSidePatternRect = Rect.fromLTWH(
        bounds.left,
        bounds.top + (i * _accurateLength),
        _accurateLength,
        _accurateLength,
      );

      //6 创建一个高度和宽度等于 _ accurateLength 的 rect，在右侧，rect 将在第一次迭代中位于顶部，并且每次迭代都会被(i * _ accurateLength)移动
      Rect rightSidePatternRect = Rect.fromLTWH(
        bounds.right - _accurateLength,
        bounds.top + (i * _accurateLength),
        _accurateLength,
        _accurateLength,
      );

      //7添加一个旋转过的矩形并将其添加到位于 leftSidePatternRect 的 innerPath 中
      innerPath.addRotatedRect(leftSidePatternRect);
      //8 将一个矩形添加到位于左侧的 outerPath 中
      outerPath.addRect(leftSidePatternRect);

      //9添加一个旋转过的矩形，并将其添加到 rightSidePatternRect 的 innerPath 中，稍后将实现 addRotatedRect ()扩展方法
      innerPath.addRotatedRect(rightSidePatternRect);
      //10添加一个矩形
      outerPath.addRect(rightSidePatternRect);
    }
  }

  ///要绘制顶部装饰和底部装饰
  void _addHorizontalSides(Rect bounds, Path innerPath, Path outerPath) {
    int patternsCount = bounds.width ~/ _patternLength;

    double _accurateLength = (bounds.width / patternsCount);

    for (var i = 0; i < patternsCount; ++i) {
      Rect topSidePatternRect = Rect.fromLTWH(
        bounds.left + (i * _accurateLength),
        bounds.top,
        _accurateLength,
        _accurateLength,
      );

      Rect bottomSidePatternRect = Rect.fromLTWH(
        bounds.left + (i * _accurateLength),
        bounds.bottom - _accurateLength,
        _accurateLength,
        _accurateLength,
      );

      innerPath.addRotatedRect(topSidePatternRect);
      outerPath.addRect(topSidePatternRect);

      innerPath.addRotatedRect(bottomSidePatternRect);
      outerPath.addRect(bottomSidePatternRect);
    }
  }

}

///addRotatedRect ()方法不是 Path 类中的方法，
extension on Path {
  void addRotatedRect(Rect bounds) {
    moveTo(bounds.left, bounds.center.dy);
    lineTo(bounds.center.dx, bounds.top);
    lineTo(bounds.right, bounds.center.dy);
    lineTo(bounds.center.dx, bounds.bottom);
    close();
  }
}