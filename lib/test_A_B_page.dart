import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/9/25.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
///

///代码清单 2-16
///lib/code/code2/example_scaffold_207_page.dart
///Scaffold的基本使用 内容主体页面
import 'package:flutter/painting.dart';


///启动函数配置
void main() => runApp(MyApp());

//定义根目录Widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //根视图
    return MaterialApp(
      //配制路由规则
      routes: {
        //默认显示页面
        "/": (BuildContext context) => ExampleAPage(),
        "/second": (BuildContext context) => ExampleBPage(), //自定义的页面
      },
    );
  }
}


class ExampleAPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ExampleAPageState();
  }
}

class _ExampleAPageState extends State<ExampleAPage> {
  //定义变量来接收B页面返回数据
  String result = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("A页面"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            child: Text("点击打开B页面"),
            onPressed: () {
              openBFunction();
            },
          ),
          ElevatedButton(
            child: Text("点击打开B页面 并获取B页面回传的参数"),
            onPressed: () {
              openBAndResultFunction();
            },
          ),

          ElevatedButton(
            child: Text("点击打开B页面 动态路由"),
            onPressed: () {
              openB();
            },
          ),
          Container(
            child: Text("页面B返回数据为 $result"),
          )
        ],
      ),
    );
  }

  //打开B页面
  void openBFunction() {
    Map<String, String> map = new Map();
    map["name"] = "张三";

    //跳转第二个页面
    //[arguments]传到第二个页面的参数
    Navigator.of(context).pushNamed("/second", arguments: map);
  }

  //打开B页面并获取回传参数
  void openBAndResultFunction() {
    Map<String, String> map = new Map();
    map["name"] = "张三";
    //跳转第二个页面
    //[arguments]传到第二个页面的参数
    Navigator.of(context).pushNamed("/second", arguments: map).then((value) {
      //当页面二关闭时不设置传值时 value的值为 null
      if (value != null) {
        //需要注意的是这里的数据类型与第二个页面关闭时返回的类型一至才可以
        Map<String, String> resultMap = value;
        print("页面二回传的数据是 ${resultMap['result']}");
        //刷新页面显示
        setState(() {
          result = resultMap.toString();
        });
      }
    });
  }

  //动态路由方式打开B页面
  void openB() {
    //跳转第二个页面
    Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
      ///直接通过构建函数来传参数
      return new ExampleBPage(title: "这是传递的参数");
    })).then((value) {
      if (value) {
        Map<String, String> resultMap = value;
        print("页面二回传的数据是 ${resultMap['result']}");
      }
    });
  }
}


class ExampleBPage extends StatefulWidget {
  final String title;

  ExampleBPage({this.title});

  @override
  State<StatefulWidget> createState() {
    return _ExampleBPageState();
  }
}

class _ExampleBPageState extends State<ExampleBPage> {
  //记录传过来的参数
  String _message = "";

  //页面创建时执行的第一个方法
  @override
  void initState() {
    super.initState();
  }

  ///页面创建执行的第二个方法
  ///页面 State、Context已绑定
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    //是否是路由栈中的第一个页面
    bool isFirst = ModalRoute.of(context).isFirst;

    //当前手机屏幕上显示的是否是这个页面Widget
    bool isCurrent = ModalRoute.of(context).isCurrent;

    //当前Widget是否是活跃可用的
    //当调用 pop 或者是关闭当前Widget时 isActive 为false
    bool isActive = ModalRoute.of(context).isActive;

    if (isActive) {
      //获取路由信息
      RouteSettings routeSettings = ModalRoute.of(context).settings;
      //获取传递的参数
      Map<String, String> arguments = routeSettings.arguments;
      if(arguments!=null){
        print(
            "接收到参数 ${arguments["name"]} isCurrent$isCurrent isFirst$isFirst  isActive$isActive");

        //变量赋值
        _message = arguments.toString();
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///通过widget来调用
      appBar: AppBar(
        ///这里是通过插值表达式的方式来直接引用的
        title: Text("B页面 ${widget.title}"),
      ),
      body: Column(
        children: [
          FlatButton(
            child: Text("关闭当前页面"),
            onPressed: () {
              closeBFunction();
            },
          ),
          SizedBox(
            height: 20,
          ),
          Text("接收到的数据是 $_message")
        ],
      ),
    );
  }

  //关闭B页面
  void closeBFunction() {
    //这里是向上一个页面回传的数据
    Map<String, String> resultMap = new Map();
    resultMap["result"] = "AESC";

    ///回传数据
    Navigator.of(context).pop(resultMap);
  }
}
