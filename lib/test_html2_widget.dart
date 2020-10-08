import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html_rich_text/flutter_html_rich_text.dart';
import 'package:flutter_html_text_plugin/flutter_html_text_plugin.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:http/http.dart' as http;

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/9/9.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
/// 代码清单 1-3-1
class TestHtmlPage2 extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestHtmlPage2> {

  String txt =
      "<p>长途轮 <h4>高速驱动</h4><span style='background-color:#ff3333'>"
      "<span style='color:#ffffff;padding:10px'> 3条立减 购胎抽奖</span></span></p>"
      "<p>长途高速驱动轮<span ><span style='color:#cc00ff;'> 3条立减 购胎抽奖</span></span></p>";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///一个标题
      appBar: AppBar(title: Text('A页面'),),
      body: Center(
        ///一个列表
        child: ListView.builder(
          itemBuilder: (BuildContext context, int postiont) {
            return buildItemWidget(postiont);
          },
          itemCount: 100,
        ),
      ),
    );
  }

  ///ListView的条目
  Widget buildItemWidget(int postiont) {
    return Container(
      ///内容边距
      padding: EdgeInsets.all(8),
      child: Column(
        ///子Widget左对齐
        crossAxisAlignment: CrossAxisAlignment.start,

        ///内容包裹
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "测试标题 $postiont",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),

          ///html富文本标签
          Container(
            height: 140,
            margin: EdgeInsets.only(top: 8),
            child: HTMLTextWidet(
              htmlText: txt,
            ),
          )
        ],
      ),
    );
  }

  ///一个按钮 点击 push B页面
  RaisedButton buildRaisedButton(BuildContext context) {
    return RaisedButton(
      child: Text(' push B页面 '),
      onPressed: () {
        test();
      },
    );
  }

  void test() async {
    String htmlUrl =
        'https://blog.csdn.net/zl18603543572/article/details/93532582';
    final res = await http.Client().get(Uri.parse(htmlUrl));

    if (res.statusCode == 200) {
      ///将 HTML 解析为文档的解析阶段。包保证解析任何 HTML，
      ///从最无效的到完全有效的，就像现代浏览器所做的那样
      ///获取请求的内容
      var document = htmlParser.parse(res.body);

      print('获取的内容： ${document.outerHtml}');

      setState(() {
        txt = document.outerHtml;
      });
    } else {
      throw Exception();
    }
  }

  void test2() async {
    var document = htmlParser.parse(txt);
    print('获取的内容： ' + document.getElementsByClassName('p').length.toString());

    var firstChild = document.firstChild;

    String html = document.outerHtml;
//
    var body = document.body;

    print('firstChild： ' + firstChild.toString());
    print('outerHtml： ' + html);
    print('body： ' + body.nodes.toString());
  }
}
