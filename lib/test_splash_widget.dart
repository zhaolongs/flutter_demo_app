import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html_rich_text/flutter_html_rich_text.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/9/9.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
/// 代码清单 1-3-1
class LiquidSwipeDemo extends StatefulWidget {
  LiquidSwipeDemo({Key key}) : super(key: key);

  @override
  _demoState createState() => _demoState();
}

class _demoState extends State<LiquidSwipeDemo> {

  WaveType currentAnimate=WaveType.liquidReveal;

  void changeAnimate(){
    setState(() {
      if(currentAnimate==WaveType.liquidReveal){
        currentAnimate=WaveType.circularReveal;
      }else{
        currentAnimate=WaveType.liquidReveal;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("liquid_swipe"),
        actions: <Widget>[
        ],
      ),
      body: LiquidSwipe(
        pages: [
          Container(
            color: Colors.blue,
            child: Center(
              child: FlatButton(
                child: Text("切换效果"),
                onPressed: (){
                  changeAnimate();
                },
              ),
            ),
          ),
          Container(
            color: Colors.pink,
          ),
          Container(
              color: Colors.teal,
              child: ConstrainedBox(
                child:Image.network('http://hbimg.b0.upaiyun.com/c9d0ae1ea6dafe5b7af0e2387e161778d7a146b83f571-ByOb1k_fw658',
                  fit: BoxFit.cover,),
                constraints: new BoxConstraints.expand(),
              )
          ),
        ],
        fullTransitionValue: 200,
        enableSlideIcon: true,
        enableLoop: true,
        positionSlideIcon: 0.5,
        waveType: currentAnimate,
        onPageChangeCallback: (page) => pageChangeCallback(page),
        currentUpdateTypeCallback: (updateType) => updateTypeCallback(updateType),
      ),
    );
  }

  pageChangeCallback(int page) {
    print(page);
  }
  updateTypeCallback(UpdateType updateType) {
    print(updateType);
  }
}