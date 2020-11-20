import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:flutter/material.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/11/20.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
/// 
/// 代码清单 
///代码清单

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: Spinner(),
              ),
              FlatButton.icon(
                textColor: Colors.white,
                icon: Icon(Icons.favorite_border),
                label:
                Text('Follow me on Twitter'),
                onPressed: () {

                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Spinner extends StatefulWidget {
  @override
  _SpinnerState createState() => _SpinnerState();
}

class _SpinnerState extends State<Spinner> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  Offset _c1 = Offset(1.0, 0.5);
  Offset _c2 = Offset(0.75, 0.5);
  Offset _c3 = Offset(0.5, 0.5);
  Offset _c4 = Offset(0.25, 0.5);
  Offset _c5 = Offset(0.0, 0.5);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: Duration(milliseconds: 3000), vsync: this);

    AnimationSet _animationSet = AnimationSet(_controller);

    _controller.addListener(() {
      if (_controller.value < 0.8) {
        _c1 = _animationSet.c1p1.value;
      } else {
        _c1 = _animationSet.c1p2.value;
      }

      if (_controller.value < 0.6) {
        _c2 = _animationSet.c2p1.value;
      } else if (_controller.value < 0.8) {
        _c2 = _animationSet.c2p2.value;
      } else {
        _c2 = _animationSet.c2p3.value;
      }

      if (_controller.value < 0.4) {
        _c3 = _animationSet.c3p1.value;
      } else if (_controller.value < 0.6) {
        _c3 = _animationSet.c3p2.value;
      } else {
        _c3 = _animationSet.c3p3.value;
      }

      if (_controller.value < 0.2) {
        _c4 = _animationSet.c4p1.value;
      } else if (_controller.value < 0.4) {
        _c4 = _animationSet.c4p2.value;
      } else {
        _c4 = _animationSet.c4p3.value;
      }

      if (_controller.value < 0.2) {
        _c5 = _animationSet.c5p1.value;
      } else {
        _c5 = _animationSet.c5p2.value;
      }

      setState(() {});
    });

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: CustomPaint(
        size: Size(double.infinity, double.infinity),
        painter: _SpinnerPainter(_c1, _c2, _c3, _c4, _c5),
      ),
    );
  }
}

class AnimationSet {
  static Curve _curveOfCurve = Cubic(.51, .23, .8, .38);

  AnimationSet(this.controller)
      :
  // ********** C1 **********
        c1p1 = _OffsetTween(Offset(1.0, 0.5), Offset(0.0, 0.5))
            .animate(CurvedAnimation(
          parent: controller,
          curve: Interval(
            0.0,
            0.8,
            curve: Curves.linear,
          ),
        )),
        c1p2 = _CurveTween().animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.8,
              1.0,
              curve: _curveOfCurve,
            ),
          ),
        ),

  // ********** C2 **********
        c2p1 = _OffsetTween(Offset(0.75, 0.5), Offset(0.0, 0.5))
            .animate(CurvedAnimation(
          parent: controller,
          curve: Interval(
            0.0,
            0.6,
            curve: Curves.linear,
          ),
        )),
        c2p2 = _CurveTween().animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.6,
              0.8,
              curve: _curveOfCurve,
            ),
          ),
        ),
        c2p3 = _OffsetTween(Offset(1.0, 0.5), Offset(0.75, 0.5)).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.8,
              1.0,
              curve: Curves.linear,
            ),
          ),
        ),

  // ********** C3 **********
        c3p1 = _OffsetTween(Offset(0.5, 0.5), Offset(0.0, 0.5))
            .animate(CurvedAnimation(
          parent: controller,
          curve: Interval(
            0.0,
            0.4,
            curve: Curves.linear,
          ),
        )),
        c3p2 = _CurveTween().animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.4,
              0.6,
              curve: _curveOfCurve,
            ),
          ),
        ),
        c3p3 = _OffsetTween(Offset(1.0, 0.5), Offset(0.5, 0.5)).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.6,
              1.0,
              curve: Curves.linear,
            ),
          ),
        ),

  // ********** C4 **********
        c4p1 = _OffsetTween(Offset(0.25, 0.5), Offset(0.0, 0.5))
            .animate(CurvedAnimation(
          parent: controller,
          curve: Interval(
            0.0,
            0.2,
            curve: Curves.linear,
          ),
        )),
        c4p2 = _CurveTween().animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.2,
              0.4,
              curve: _curveOfCurve,
            ),
          ),
        ),
        c4p3 = _OffsetTween(Offset(1.0, 0.5), Offset(0.25, 0.5)).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.4,
              1.0,
              curve: Curves.linear,
            ),
          ),
        ),

  // ********** C5 **********
        c5p1 = _CurveTween().animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0,
              0.2,
              curve: _curveOfCurve,
            ),
          ),
        ),
        c5p2 = _OffsetTween(Offset(1.0, 0.5), Offset(0.0, 0.5)).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.2,
              1.0,
              curve: Curves.linear,
            ),
          ),
        );

  final AnimationController controller;

  final Animation<Offset> c1p1;
  final Animation<Offset> c1p2;

  final Animation<Offset> c2p1;
  final Animation<Offset> c2p2;
  final Animation<Offset> c2p3;

  final Animation<Offset> c3p1;
  final Animation<Offset> c3p2;
  final Animation<Offset> c3p3;

  final Animation<Offset> c4p1;
  final Animation<Offset> c4p2;
  final Animation<Offset> c4p3;

  final Animation<Offset> c5p1;
  final Animation<Offset> c5p2;
}

class _CurveTween extends Tween<Offset> {
  static Rect _bounds = Rect.fromLTWH(0, 0, 1, 1);

  PathMetric metric = (Path()
    ..moveTo(_bounds.centerLeft.dx, _bounds.centerLeft.dy)
    ..quadraticBezierTo(_bounds.topCenter.dx, _bounds.topCenter.dy,
        _bounds.centerRight.dx, _bounds.centerRight.dy))
      .computeMetrics()
      .first;

  _CurveTween() : super(begin: _bounds.centerLeft, end: _bounds.centerRight);

  @override
  Offset lerp(double time) {
    return metric.getTangentForOffset(time * metric.length).position;
  }
}

class _OffsetTween extends Tween<Offset> {
  _OffsetTween(Offset begin, Offset end) : super(begin: begin, end: end);

  @override
  Offset lerp(double t) {
    return Offset.lerp(begin, end, t);
  }
}

class _SpinnerPainter extends CustomPainter {
  static Color _mango = Color(0xffffbe0b);
  static Color _orange = Color(0xfffb5607);
  static Color _winterSky = Color(0xffff006e);
  static Color _blueViolet = Color(0xff8338ec);
  static Color _azure = Color(0xff3a86ff);

  final Offset circle1;
  final Offset circle2;
  final Offset circle3;
  final Offset circle4;
  final Offset circle5;

  _SpinnerPainter(
      this.circle1,
      this.circle2,
      this.circle3,
      this.circle4,
      this.circle5,
      );

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width * 0.08;
    canvas.drawCircle(_map(circle1, size), radius, Paint()..color = _mango);
    canvas.drawCircle(_map(circle2, size), radius, Paint()..color = _orange);
    canvas.drawCircle(_map(circle3, size), radius, Paint()..color = _winterSky);
    canvas.drawCircle(
        _map(circle4, size), radius, Paint()..color = _blueViolet);
    canvas.drawCircle(_map(circle5, size), radius, Paint()..color = _azure);
  }

  Offset _map(Offset offset, Size size) {
    return Offset(offset.dx * size.width, offset.dy * size.height);
  }

  @override
  bool shouldRepaint(_SpinnerPainter old) =>
      this.circle1 != old.circle1 ||
          this.circle2 != old.circle2 ||
          this.circle3 != old.circle3 ||
          this.circle4 != old.circle4 ||
          this.circle5 != old.circle5;
}
