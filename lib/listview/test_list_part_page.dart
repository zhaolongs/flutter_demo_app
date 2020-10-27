import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

///ListView 局部数据更新使用 Demo
class TestListPartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TestABPageState();
  }
}

class _TestABPageState extends State {
  ///测试数据集合
  List<TestBean> _testList = [];

  @override
  void initState() {
    super.initState();
    ///模拟测试数据
    for (int i = 0; i < 100; i++) {
      _testList.add(TestBean(name: "测试数据 $i", isCollect: false));
    }
  }

  @override
  Widget build(BuildContext context) {

    int testFlag =0;

    String textMessage ="";
    Color textColor = Colors.red;


    if(testFlag==0){
      textMessage ='执行中';
      textColor = Colors.green;
    }else if(testFlag==1){

    }
    ///页面主体脚手架
    return Scaffold(
      appBar: AppBar(
        title: Text("ListView 局部数据更新 $textMessage"),
      ),
      body: buildListView(),
    );
  }

  ///构建一个列表 ListView
  buildListView() {
    ///懒加载模式构建
    return ListView.builder(
      ///子Item的构建器
      itemBuilder: (BuildContext context, int index) {
        ///每个子Item的布局
       ///在这里是封装到了独立的 StatefulWidget
        return TestListItemWidget(
          ///子Item对应的数据
          bean: _testList[index],
          ///可选参数 子Item标识
          key: GlobalObjectKey(index),
        );
      },
      ///ListView子Item的个数
      itemCount: _testList.length,
    );
  }
}

///ListView 测试数据 Model
class TestBean {
  String name;
  bool isCollect;

  TestBean({this.name, this.isCollect});
}

///ListView 的子Item
class TestListItemWidget extends StatefulWidget {
  ///本Item对应的数据模型
  final TestBean bean;

  TestListItemWidget({@required this.bean, Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ListItemState();
  }
}

class _ListItemState extends State<TestListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.grey[300],
        padding: EdgeInsets.only(
          top: 5,
          bottom: 5,
        ),
        child: Container(
          padding: EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          color: Colors.white,
          height: 60,
          child: buildRow(),
        ),
      ),
    );
  }

  ///内容区域
  Row buildRow() {
    ///左右线性排开
    return Row(
      children: [
        ///权重布局 文本占用空白区域
        Expanded(
            child: Text(
          "${widget.bean.name}",
        )),
        ///收藏按钮
        RaisedButton(
          ///按钮的背景
          color: widget.bean.isCollect ? Colors.blue : Colors.grey[200],
          ///点击更新当前 Item 数据以及刷新页面显示
          onPressed: () {
            setState(() {
              widget.bean.isCollect = !widget.bean.isCollect;
            });
          },
          child: Text(
            "${widget.bean.isCollect ? '已收藏' : '收藏'}",
            style: TextStyle(
                color: widget.bean.isCollect ? Colors.white : Colors.red),
          ),
        ),
      ],
    );
  }
}
