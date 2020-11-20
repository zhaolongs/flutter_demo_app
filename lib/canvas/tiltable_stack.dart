import 'package:flutter/cupertino.dart';
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
void main() => runApp(MaterialApp(
      home: HomePage(),
    ));

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("test"),
      ),
      backgroundColor:Colors.grey[200],
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TiltableStack(
              children: [
                ClipOval(
                  child: Container(
                   decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.all(Radius.circular(100)),
                     border: Border.all(color: Colors.grey,width: 10)
                   ),
                    alignment: Alignment.center,
                    width: 200,
                    height: 200,
                    child: Text("A"),
                  ),
                ),
                ClipOval(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(100)),

                    ),
                    alignment: Alignment.center,
                    width: 180,
                    height: 180,
                    child: Text("A"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TiltableStack extends StatefulWidget {
  final List<Widget> children;
  final Alignment alignment;

  const TiltableStack({
    Key key,
    this.children,
    this.alignment = Alignment.center,
  }) : super(key: key);

  @override
  _TiltableStackState createState() => _TiltableStackState();
}

class _TiltableStackState extends State<TiltableStack>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> tilt;
  Animation<double> depth;
  double pitch = 0;
  double yaw = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this)
      ..addListener(() {
        setState(() {
          if (tilt != null) {
            pitch *= tilt.value;
            yaw *= tilt.value;
          }
        });
      })
      ..forward(from: 1.0);
  }

  @override
  dispose() {
    super.dispose();
    _controller.dispose();
  }

  cancelPan() {
    tilt = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticIn.flipped,
      ),
    );
    depth = tilt;
    _controller.forward();
  }

  startPan() {
    tilt = null;
    depth = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Cubic(1.0, 0.0, 1.0, 1.0),
      ),
    );
    _controller.reverse();
  }

  updatePan(DragUpdateDetails drag) {
    setState(() {
      var size = MediaQuery.of(context).size;
      pitch += drag.delta.dy * (1 / size.height);
      yaw -= drag.delta.dx * (1 / size.width);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: updatePan,
      onPanEnd: (_) => cancelPan(),
      onPanCancel: cancelPan,
      onPanDown: (_) => startPan(),
      child: Stack(
        alignment: widget.alignment,
        children: widget.children
            .asMap()
            .map(
              (i, element) {
                return MapEntry(
                  i,
                  Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateX(pitch)
                      ..rotateY(yaw)
                      ..translate(-yaw * i * 70, pitch * i * 70, 0)
                      ..scale((depth?.value ?? 0) * (i + 1) * 0.1 + 1),
                    child: element,
                    alignment: FractionalOffset.center,
                  ),
                );
              },
            )
            .values
            .toList(),
      ),
    );
  }
}
