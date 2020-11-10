import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'DioUtils.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/10/31.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572

void main() {
  runApp(RootPage());
}

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<HomePage> {

  String _result ="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("测试网络请求"),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            buildTextButton(),
            SizedBox(height: 20,),
            Text("获取到的内容如下"),
            Container(child: Text("$_result"),)
          ],
        ),
      ),
    );
  }

  Widget buildTextButton() {
    return TextButton(
      onPressed: () {
        getRequest();
      },
      child: Text("TextButton按钮"),
    );
  }

  /// 网络调用通常遵循如下步骤：
  /// 1 创建 client.
  /// 2 构造 Uri.
  /// 3 发起请求, 等待请求，同时您也可以配置请求headers、 body。
  /// 4 关闭请求, 等待响应.
  /// 5 解码响应的内容.
  /// get 无参数请求
  getRequest() async {
    ///定义请求URL
    String  url = 'http://localhost:8080/getUserList';
    //第一就创建 Client
    HttpClient httpClient = new HttpClient();
    String result;
    try {
      //第二步构建 Uri
      Uri uri = Uri.parse(url);
      //第三步发送get请求
      HttpClientRequest request = await httpClient.getUrl(uri);
      //第四步获取响应同时关闭通道
      HttpClientResponse response = await request.close();

      if (response.statusCode == HttpStatus.ok) {
        //请求成功 获取数据
        String json = await response.transform(utf8.decoder).join();
        //解析数据
        var data = jsonDecode(json);
        result = data.toString();
        print("请求到的数据为 ${data.toString()}");
      } else {
        result =
            '请求异常 ${response.statusCode}';
      }
    } catch (exception) {
      result = 'Failed getting IP address';
    }

    if (!mounted) return;
    setState(() {
      _result = result;
    });
  }

  dioGetRequest() async{
    String  url = 'http://localhost:8080/getUserList';

    ResponseInfo responseInfo = await DioUtils.instance.getRequest(url: url );

    print("请求结果为 ${responseInfo.toString()}");
  }
}
