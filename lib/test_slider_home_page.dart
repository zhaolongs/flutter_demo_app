
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SliderHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SliderHomePageState();
  }
}

class SliderHomePageState extends State {
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
        title: Text("SliderHome"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: width,
              height: 300,
              alignment: Alignment.center,
              color: Colors.grey,

              /// Slider 是fluter 应用开发中的滑动条
              /// value
              child: Slider(
                ///当前进度值
                value: sliderVlaue,
                ///最小值
                min: 0,
                ///最大值
                max: 100,
                ///滑动时回调
                onChanged: (value) {
                  setState(() {
                    sliderVlaue = value;
                  },);
                },
                activeColor: Colors.red,
                inactiveColor: Colors.blue,
                label: "这是滑动的",
              ),
            )
          ],
        ),
      ),
    );
  }
}
