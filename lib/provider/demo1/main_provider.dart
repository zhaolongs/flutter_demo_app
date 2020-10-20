import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/provider/demo1/test_provider_consumer_time_page.dart';
import 'package:flutter_test_app/provider/demo1/test_provider_time_page.dart';
import 'package:flutter_test_app/provider/demo2/test_provider_abc_page.dart';
import 'package:provider/provider.dart';
import 'time_model.dart';

///代码清单 1-1
///flutter应用程序中的入口函数
void main() => runApp(
      ChangeNotifierProvider(
        create: (BuildContext context) {
          return TimeCounterModel();
        },
        child: ProviderMainApp(),
      ),
    );

///应用的根布局
class ProviderMainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ///构建Materia Desin 风格的应用程序
    return MaterialApp(
      ///Android应用程序中任务栏中显示应用的名称
      title: "配制",
      theme: ThemeData(
        accentColor: Colors.blue,

        ///默认是 Brightness.light
        brightness: Brightness.light,
      ),

      ///默认的首页面

      home: ProviderHomePage(),
    );
  }
}

class ProviderHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProviderHomePageState();
  }
}

class _ProviderHomePageState extends State {
  final List<Map<String, dynamic>> itemList = [
    {"name": "Provider 接收数据", "widget": TestProviderTimePage()},
    {"name": "Consumer 接收数据", "widget": TestProviderConsumerTimePage()},
    {"name": "多个页面传值", "widget": TestProviderMulPage()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Provider 专题 "),
      ),
      body: Container(
        width: double.infinity,
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return itemBuildWidget(index);
          },
          itemCount: itemList.length,
        ),
      ),
    );
  }

  Widget itemBuildWidget(int index) {
    Map<String, dynamic> item = itemList[index];
    String buttonTitle = item["name"];
    Widget toPage = item["widget"];

    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: OutlineButton(
        child: Text(buttonTitle),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return toPage;
          }));
        },
      ),
    );
  }
}
