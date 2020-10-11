import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProgressHomePagePageState();
  }
}

class ProgressHomePagePageState extends State {
  @override
  void initState() {
    super.initState();
  }

  double sliderVlaue = 50;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("ProgressHomePage"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text("圆形"),
            Container(
              width: width,
              height: 300,
              alignment: Alignment.center,
              color: Colors.grey,
              child: buildSizedBox(),
            ),
            Text("条形"),
            Container(
              width: width,
              height: 300,
              alignment: Alignment.center,
              color: Colors.grey,
              child: buildLinearProgressIndicator(),
            )
          ],
        ),
      ),
    );
  }

  LinearProgressIndicator buildLinearProgressIndicator() {
    return LinearProgressIndicator(
      ///背景色
      backgroundColor: Colors.white,
      /// 前景色
      valueColor: AlwaysStoppedAnimation(Colors.red),
    );
  }

  SizedBox buildSizedBox() {
    return SizedBox(
      width: 44,
      height: 44,
      child: CircularProgressIndicator(
        ///背景色
        backgroundColor: Colors.white,

        /// 前景色
        /// AlwaysStoppedAnimation 动画的类型  Always 总是 Stopped 停止
        valueColor: AlwaysStoppedAnimation(Colors.red),
      ),
    );
  }
}
