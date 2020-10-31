import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/10/31.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
///代码清单

void main() {
  runApp(RootPage());
}

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.white),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<HomePage> {
  ///RichText中隐私协议的手势
  TapGestureRecognizer _privacyProtocolRecognizer;

  ///RichText中注册协议的手势
  TapGestureRecognizer _registProtocolRecognizer;

  @override
  void initState() {
    super.initState();
    //注册协议的手势
    _registProtocolRecognizer = TapGestureRecognizer();
    //隐私协议的手势
    _privacyProtocolRecognizer = TapGestureRecognizer();
  }

  @override
  void dispose() {
    super.dispose();

    ///注册协议手势释放
    _registProtocolRecognizer.dispose();
    _privacyProtocolRecognizer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //标题栏
      appBar: buildAppBar(),
      //背景颜色
      backgroundColor: Colors.white,
      //页面主体
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Builder(
          builder: (BuildContext context) {
            return buildColumn(context);
          },
        ),
      ),
    );
  }

  Column buildColumn(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 44,
        ),
        Image.asset(
          "images/app_icon.png",
          width: 60,
          height: 60,
        ),
        SizedBox(
          height: 24,
        ),
        Text(
          "欢迎登录 精彩每一刻",
          style: TextStyle(fontSize: 22),
        ),
        Container(
          //上边距
          margin: EdgeInsets.only(top: 64),
          width: 220,
          height: 44,
          child: RaisedButton(
            //背景颜色
            color: Colors.blue,
            //按钮上的文字颜色
            textColor: Colors.white,
            //按钮上的文字
            child: Text(
              "手机号一键登录",
              style: TextStyle(fontSize: 16),
            ),
            //按钮的点击事件
            onPressed: () => {showBottomTips(context, "手机号登录")},
          ),
        ),
        SizedBox(
          height: 22,
        ),
        buildRichText(),
        Expanded(
          child: Builder(
            builder: (BuildContext context) {
              return buildContainer(context);
            },
          ),
        )
      ],
    );
  }

  RichText buildRichText() {
    return RichText(
      ///文字区域
      text: TextSpan(
          text: "注册同意",
          style: TextStyle(color: Colors.grey),
          children: [
            TextSpan(
                text: "用户注册协议",
                style: TextStyle(color: Colors.orange),
                //点击事件
                recognizer: _registProtocolRecognizer
                  ..onTap = () {
                    print("点击用户协议");
                  }),
            TextSpan(
              text: "和",
              style: TextStyle(color: Colors.grey),
            ),
            TextSpan(
                text: "隐私协议",
                style: TextStyle(color: Colors.orange),
                //点击事件
                recognizer: _privacyProtocolRecognizer
                  ..onTap = () {
                    print("点击隐私协议");
                  })
          ]),
    );
  }

  Container buildContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 34),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomOvalButton(
            iconData: Icons.app_blocking,
            onClick: () {
              showBottomTips(context, "电话");
            },
          ),
          SizedBox(
            width: 20,
          ),
          CustomOvalButton(
            iconData: Icons.android_outlined,
            onClick: () {
              showBottomTips(context, "Android");
            },
          ),
          SizedBox(
            width: 20,
          ),
          CustomOvalButton(
            iconData: Icons.more_horiz_outlined,
            onClick: () {
              showBottomTips(context, "更多");
            },
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_outlined),
        onPressed: () {},
      ),
      actions: [
        FlatButton(
          onPressed: () {},
          child: Text("遇到问题"),
        )
      ],
    );
  }
}

class CustomOvalButton extends StatefulWidget {
  final IconData iconData;
  final Function onClick;

  CustomOvalButton({@required this.iconData, this.onClick, Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CustomOvalButtonState();
  }
}

class _CustomOvalButtonState extends State<CustomOvalButton> {
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: InkWell(
        onTap: widget.onClick,
        //圆角设置,给水波纹也设置同样的圆角
        //如果这里不设置就会出现矩形的水波纹效果
        borderRadius: new BorderRadius.circular(30.0),
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black38),
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          child: Icon(
            widget.iconData,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}

showBottomTips(BuildContext context, String title) {
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Row(
      children: <Widget>[
        Icon(
          Icons.check,
          color: Colors.green,
        ),
        Text(title)
      ],
    ),
    duration: Duration(seconds: 1),
  ));
}
