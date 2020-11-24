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

///启动函数
void main() {
  runApp(RootApp());
}

class RootApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.white),
      home: LoginPage(),
    );
  }
}

//定义登录页面
class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {

  //RichText 富文本中使用的手势识别
  TapGestureRecognizer _gestureRecognizer;
  TapGestureRecognizer _gestureRecognizer2;

  @override
  void initState() {
    super.initState();
    _gestureRecognizer = TapGestureRecognizer();
    _gestureRecognizer2 = TapGestureRecognizer();
  }

  @override
  void dispose() {
    super.dispose();
    _gestureRecognizer.dispose();
    _gestureRecognizer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //背景颜色
      backgroundColor: Colors.white,
      //构建APPBar
      appBar: buildAppBar(),
      //内容主体
      body: Container(
        //填充屏幕空间
        width: double.infinity,
        height: double.infinity,
        child: buildColumn(),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      children: [
        SizedBox(
          height: 44,
        ),
        Image.asset(
          "assets/images/app_icon.png",
          width: 60,
          height: 60,
        ),
        SizedBox(
          height: 24,
        ),
        Text(
          "欢迎登录 精彩每一天",
          style: TextStyle(fontSize: 22),
        ),

        //登录按钮
        buildLoginButton(),

        SizedBox(height: 22),
        //隐私协议
        buildRichText(),
        //填充空白
        Expanded(
          child: Container(
            padding: EdgeInsets.only(bottom: 34),
            //水平方向排开
            child: buildRow(),
          ),
        )
      ],
    );
  }

  Row buildRow() {
    return Row(
      //水平方向居中
      mainAxisAlignment: MainAxisAlignment.center,
      //竖直方向底部对齐
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        //定义小圆圈的图标按钮
        CustumOvalButton(
          iconData: Icons.app_blocking,
          clickCallBack: () {
            print("点击 了手机");
          },
        ),
        SizedBox(
          width: 22,
        ),
        CustumOvalButton(
          iconData: Icons.android_rounded,
          clickCallBack: () {
            print("点击 了Android ");
          },
        ),
        SizedBox(
          width: 22,
        ),
        CustumOvalButton(
          iconData: Icons.more_horiz_outlined,
          clickCallBack: () {
            print("点击 更多");
          },
        ),
      ],
    );
  }

  Container buildLoginButton() {
    return Container(
      margin: EdgeInsets.only(top: 64),
      width: 220,
      height: 44,
      child: RaisedButton(
        //按钮背景颜色
        color: Colors.blue,
        //按钮上的颜色
        textColor: Colors.white,
        onPressed: () {
          print("点击了手机号登录");
        },
        child: Text("手机号一键登录"),
      ),
    );
  }

  //封装方法
  RichText buildRichText() {
    return RichText(
      text: TextSpan(
          text: "登录同意",
          style: TextStyle(color: Colors.grey),
          children: [
            TextSpan(
                text: "用户协议",
                style: TextStyle(
                  color: Colors.orange,
                ),
                //点击事件
                recognizer: _gestureRecognizer
                  ..onTap = () {
                    print("用户协议点击");
                  }),
            TextSpan(
              text: "和",
              style: TextStyle(color: Colors.grey),
            ),
            TextSpan(
                text: "隐私协议",
                style: TextStyle(
                  color: Colors.orange,
                ),
                //点击事件
                recognizer: _gestureRecognizer2
                  ..onTap = () {
                    print("隐私协议点击");
                  }),
          ]),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      //阴影高度
      elevation: 0.0,
      //左侧的按钮
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_outlined),
        onPressed: () {
          print("返回键点击 ");
        },
      ),
      //右侧的按钮
      actions: [
        FlatButton(
          child: Text("登录遇到问题"),
          onPressed: () {},
        )
      ],
    );
  }
}

class CustumOvalButton extends StatefulWidget {
  //图标
  final IconData iconData;

  //点击事件回调
  final Function() clickCallBack;

  CustumOvalButton({@required this.iconData, this.clickCallBack, Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CustumOvalButtonState();
  }
}

class _CustumOvalButtonState extends State<CustumOvalButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      //点击事件的响应范围
      borderRadius: BorderRadius.all(Radius.circular(30)),
      //点击事件
      onTap: widget.clickCallBack,
      child: Container(
        width: 50,
        height: 50,
        //自定义边框
        decoration: BoxDecoration(
            //边框
            border: Border.all(color: Colors.grey),
            //边框圆角
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Icon(
          widget.iconData,
          //图标颜色
          color: Colors.black87,
        ),
      ),
    );
  }
}
