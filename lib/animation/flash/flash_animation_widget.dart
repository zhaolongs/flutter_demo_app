///
/// * author: hunghd
/// * email: hunghd.yb@gmail.com
///

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'flash_animation_controller.dart';
import 'gradient/default_linear_gradient.dart';

///
///
/// 动画执行方向的枚举
/// [FlashAnimationDirection.ltr] 从左向右
/// [FlashAnimationDirection.rtl] 从右向左
/// [FlashAnimationDirection.ttb] 从上向下
/// [FlashAnimationDirection.btt] 从下向上
///
enum FlashAnimationDirection { ltr, rtl, ttb, btt }

///lib/demo/flash/flash_animation_widget.dart
///闪光动画
@immutable
class FlashAnimation extends StatefulWidget {
  ///子Widget
  final Widget child;

  ///动画执行的方向 默认从左向右
  final FlashAnimationDirection direction;

  ///渐变过渡
  final Gradient gradient;

  ///动画的循环次数
  /// 为0则为无限循环 默认为0
  /// 为大于0的数字则循环指定的次数
  final int animationLoopCount;

  /// 当配置为true时，动画开始执行 默认为true
  /// 配置为false时，动画停止执行
  final bool animationStart;

  ///动画执行的时间 默认为 1500毫秒
  final Duration animationDuration;

  ///控制器
  final FlashAnimationController flashAnimationController;

  ///默认的构造函数创建方法
  const FlashAnimation({
    Key key,

    ///动画占位的底层Widget
    @required this.child,

    ///颜色渐变
    @required this.gradient,

    ///动画执行的时间
    this.animationDuration = const Duration(milliseconds: 1500),

    ///动画执行的方向 默认从左向右
    this.direction = FlashAnimationDirection.ltr,

    ///动画执行重复的次数 为0时无限循环
    this.animationLoopCount = 0,

    ///为true时默认开始动画
    this.animationStart = true,

    ///动画控制器
    this.flashAnimationController,
  }) : super(key: key);

  ///
  /// 声明一个静态方法 快速创建使用[FlashAnimation]闪光动画
  /// 其实就是相当于便捷创建了一个[gradient]
  /// 一个[LinearGradient]线性渐变 方向为左上角到右下角
  FlashAnimation.fromColors({
    Key key,

    ///动画占位的底层Widget
    @required this.child,

    ///底层的颜色
    @required Color normalColor,

    ///高亮的颜色
    @required Color highlightColor,

    ///动画执行的时间
    this.animationDuration = const Duration(milliseconds: 1500),

    ///动画执行的方向 默认从左向右
    this.direction = FlashAnimationDirection.ltr,

    ///动画执行重复的次数 为0时无限循环
    this.animationLoopCount = 0,

    ///为true时默认开始动画
    this.animationStart = true,

    ///动画控制器
    this.flashAnimationController,

    ///使用默认的线性渐变
  })  : gradient = DefaultLinearGradient(
            normalColor: normalColor, highlightColor: highlightColor),
        super(key: key);

  ///构建对应的State
  @override
  _FlashAnimationState createState() => _FlashAnimationState();
}

///lib/demo/flash/flash_animation_widget.dart
class _FlashAnimationState extends State<FlashAnimation>
    with SingleTickerProviderStateMixin {
  ///动画控制器
  AnimationController _animationController;

  ///动画执行的次数
  int _animationCount = 0;

  ///初始化函数
  ///创建动画控制器并设置动画执行时间[widget.animationDuration]
  @override
  void initState() {
    super.initState();

    ///自定义控制器 用来控制动画的开启与结束
    if (widget.flashAnimationController != null) {
      widget.flashAnimationController.setListener((value) {
        if (value) {
          _animationController.forward();
        } else {
          _animationController.reset();
        }
      });
    }

    ///创建动画控制器
    _animationController = AnimationController(

        ///绑定Ticker
        vsync: this,

        ///动画执行时间
        duration: widget.animationDuration);

    ///添加动画状态监听
    _animationController.addStatusListener(animationStatusListener);

    ///Widget渲染完成的回调
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ///开启动画
      if (widget.animationStart) {
        ///正向执行
        _animationController.forward();
      }
    });
  }

  ///动画监听回调
  ///[status]动画的执行状态
  ///[AnimationStatus.forward]   回到动画起点处 动画停止在开始处
  ///[AnimationStatus.dismissed] 动画正在从开始处运行到结束处（正向运行）
  ///[AnimationStatus.completed] 动画正向运行 到达动画终点处
  ///[AnimationStatus.reverse]  动画正在从结束处运行到开始处（反向运行）
  void animationStatusListener(AnimationStatus status) {
    ///动画正向执行完毕后再做处理
    if (status == AnimationStatus.completed) {
      ///累计动画的执行次数
      _animationCount++;

      ///当配置为0时为无限循环执行
      if (widget.animationLoopCount <= 0) {
        ///forward：正向执行动画。
        ///reverse：反向执行动画。
        ///repeat：反复执行动画。
        ///reset：重置动画。
        _animationController.repeat();
      } else if (_animationCount < widget.animationLoopCount) {
        ///当配置的值大于0时 为具体的执行动画
        ///当动画执行到配置的 widget.animationLoop 的值后就
        ///不做处理了
        _animationController.forward(from: 0.0);
      }
    }
  }

  ///lib/demo/flash/flash_animation_widget.dart
  ///[AnimatedBuilder]用于从widget中分离出动画过渡
  ///它是渲染树中的一个独立的类,Animation 和 Widget 本身毫无关联
  ///通过[AnimatedBuilder]这个中间件，将 Animation 和要作用的 Widget 关联起来
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      ///动画控制器
      animation: _animationController,

      ///子Widget
      child: widget.child,

      ///构建单独的动画
      builder: (BuildContext context, Widget child) {
        return _FlashObjectWidget(
          child: child,
          direction: widget.direction,
          gradient: widget.gradient,
          percent: _animationController.value,
        );
      },
    );
  }

  @override
  void dispose() {
    ///销毁动画
    _animationController.dispose();
    super.dispose();
  }
}

///lib/demo/flash/flash_animation_widget.dart
///是负责效果绘画的内部类
///继承于 SingleChildRenderObjectWidget
///该基类露出一个 Canvas 对象。
///Canvas 是一个对象，它负责在屏幕上绘制内容，它的saveLayer方法可以
///用来“在保存堆栈上保存当前变换和片段的副本，然后创建一个新的组，用于保存后续调用
@immutable
class _FlashObjectWidget extends SingleChildRenderObjectWidget {
  ///用来记录动画执行的进度结果
  final double percent;

  ///动画执行的方向
  final FlashAnimationDirection direction;

  ///渐变设置
  final Gradient gradient;

  const _FlashObjectWidget({
    Widget child,
    this.percent,
    this.direction,
    this.gradient,
  }) : super(child: child);

  @override
  _FlashRenderBox createRenderObject(BuildContext context) {
    ///创建一个RenderProxyBox
    return _FlashRenderBox(percent, direction, gradient);
  }

  ///对应的[RenderProxyBox]数据更新绑定
  @override
  void updateRenderObject(BuildContext context, _FlashRenderBox flash) {
    flash.percent = percent;
    flash.gradient = gradient;
  }
}

///lib/demo/flash/flash_animation_widget.dart
class _FlashRenderBox extends RenderProxyBox {
  ///动画执行的方向
  final FlashAnimationDirection _direction;

  ///样式
  Gradient _gradient;

  ///执行比率  0.0 ~ 1.0
  double _percent;

  _FlashRenderBox(this._percent, this._direction, this._gradient);

  @override
  ShaderMaskLayer get layer => super.layer;

  @override
  bool get alwaysNeedsCompositing => child != null;

  ///动画进度值有更新时
  ///调用 markNeedsPaint 重新绘制 Widget
  ///只有这个值更新时才去重绘
  set percent(double newValue) {
    assert(newValue != null);
    if (newValue == _percent) {
      return;
    }
    _percent = newValue;
    markNeedsPaint();
  }

  ///样式值有更新时也t重绘制
  set gradient(Gradient newValue) {
    assert(newValue != null);
    if (newValue == _gradient) {
      return;
    }
    _gradient = newValue;
    markNeedsPaint();
  }

  ///lib/demo/flash/flash_animation_widget.dart
  ///重写了 paint 方法来执行绘制任务
  ///Canvas 对象的 saveLayer 和 paintChild 方法来捕捉
  /// child 作为一个图层并在上面绘制渐变效果
  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      ///检查是否满足合成的条件
      assert(needsCompositing);

      ///获取子Widget的宽与高
      ///这里设置渲染动画的大小与子Widget的大小一至
      final double width = child.size.width;
      final double height = child.size.height;

      ///一般是一个矩形
      Rect rect;
      double dx, dy;

      if (_direction == FlashAnimationDirection.rtl) {
        ///从右向左
        dx = _offset(width, -width, _percent);
        dy = 0.0;
        rect = Rect.fromLTWH(dx - width, dy, 3 * width, height);
      } else if (_direction == FlashAnimationDirection.ttb) {
        ///从上向下
        dx = 0.0;
        dy = _offset(-height, height, _percent);
        rect = Rect.fromLTWH(dx, dy - height, width, 3 * height);
      } else if (_direction == FlashAnimationDirection.btt) {
        ///从下向上
        dx = 0.0;
        dy = _offset(height, -height, _percent);
        rect = Rect.fromLTWH(dx, dy - height, width, 3 * height);
      } else {
        ///从左向右 默认
        dx = _offset(-width, width, _percent);
        dy = 0.0;
        rect = Rect.fromLTWH(dx - width, dy, 3 * width, height);
      }

      ///如果当前的图层为null就创建一个新的图层
      layer ??= ShaderMaskLayer();

      ///设置图层的渐变样式[_gradient]以及区域[rect]
      layer
        ..shader = _gradient.createShader(rect)

        ///裁剪一下
        ..maskRect = offset & size

        ///设置图层混合模式
        ..blendMode = BlendMode.srcOut;
      context.pushLayer(layer, super.paint, offset);
    } else {
      layer = null;
    }
  }

  ///计算边距
  ///[start] 矩形的左边框距离左侧的距离或者是
  ///       矩形的顶部边框距离顶侧的距离
  ///[end] 矩形的右边距离左侧的距离
  double _offset(double start, double end, double percent) {
    /// end - start 值为矩形的长度或者是高度
    return start + (end - start) * percent;
  }
}
