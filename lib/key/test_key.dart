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
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TestPage(),
    );
  }
}

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  List<TestBean> _list = [];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 100; ++i) {
      _list.add(TestBean(title: "测试数据 $i",));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      backgroundColor: Colors.white,

      ///填充布局
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          TestBean testBean = _list[index];
          return ItemWidget(key: testBean.globalKey,index: index,);
        },
        itemCount: _list.length,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          TestBean testBean = _list[4];
          GlobalKey<_ItemWidgetState> globalKey = testBean.globalKey;
          globalKey.currentState.test("就是这么 666");

        },
      ),
    );
  }
}

class TestBean {
  GlobalKey<_ItemWidgetState> globalKey;
  String title;

  TestBean({this.title}) : globalKey = GlobalKey();
}

class ItemWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _ItemWidgetState();
  }

  final int index ;
  ItemWidget({Key key,this.index}) : super(key: key);
}

class _ItemWidgetState extends State<ItemWidget> {


  void test(String test){
    print(" ${widget.index}调用 到 test");
    setState(() {
      message = test;
    });
  }

  String message ="--";
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.white,
      padding: EdgeInsets.all(6),
      child: Container(color: Colors.grey[200],child: Text("$message ${widget.index}"),),
    );
  }
}
