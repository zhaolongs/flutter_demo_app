import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as Math;

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/11/20.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProviderModel(),
      child: MaterialApp(
        //主题样式
        theme: ThemeData(
          //Scaffold 脚手架的背景色设置
          scaffoldBackgroundColor: Colors.white,
          //前景颜色
          accentColor: Color(0xff4A64FE),
        ),
        //不显示dubug
        debugShowCheckedModeBanner: false,
        //默认显示的页面
        home: HomePage(),
      ),
    );
  }
}

class HomeProviderModel extends ChangeNotifier {
  get isVisible => _isVisible;
  bool _isVisible = false;

  set isVisible(value) {
    _isVisible = value;
    notifyListeners();
  }

  get isValid => _isValid;
  bool _isValid = false;

  void isValidEmail(String input) {
    if (input == "928343994@qq.com") {
      _isValid = true;
    } else {
      _isValid = false;
    }
    notifyListeners();
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    final model = Provider.of<HomeProviderModel>(context);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          //第一层
          Container(
            height: size.height,
            color: Theme.of(context).accentColor,
          ),
          //第二层
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeOutQuad,
            top: keyboardOpen ? -size.height / 3.7 : 0.0,
            child: WaveWidget(
              size: size,
              yOffset: size.height / 3.0,
              color: Colors.white,
            ),
          ),
          //第三层
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Text(
              'Holl World',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 40.0,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          //第四层
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: buildColumn(model, context),
          ),
        ],
      ),
    );
  }

  Column buildColumn(HomeProviderModel model, BuildContext context) {
    return Column(
      //子Widget 底部对齐
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        TextFieldWidget(
          hintText: '邮箱',
          obscureText: false,
          prefixIconData: Icons.mail_outline,
          suffixIconData: model.isValid ? Icons.check : null,
          onChanged: (value) {
            model.isValidEmail(value);
          },
        ),
        SizedBox(
          height: 10.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextFieldWidget(
              hintText: '密码',
              obscureText: model.isVisible ? false : true,
              prefixIconData: Icons.lock_outline,
              suffixIconData:
                  model.isVisible ? Icons.visibility : Icons.visibility_off,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              '忘记密码?',
              style: TextStyle(
                color: Theme.of(context).accentColor,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20.0,
        ),
        ButtonWidget(
          buttonLabel: '登录',
          onTap: () {},
          hasBorder: false,
        ),
        SizedBox(
          height: 10.0,
        ),
        ButtonWidget(
          buttonLabel: '跳过',
          onTap: () {},
          hasBorder: true,
        ),
      ],
    );
  }
}

class WaveWidget extends StatefulWidget {
  final Size size;
  final double yOffset;
  final Color color;

  WaveWidget({
    this.size,
    this.yOffset,
    this.color,
  });

  @override
  _WaveWidgetState createState() => _WaveWidgetState();
}

class _WaveWidgetState extends State<WaveWidget> with TickerProviderStateMixin {
  
  //动画控制器
  AnimationController _animationController;
  //不规则波浪的点位
  List<Offset> _wavePoints = [];

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 5000),
    );
    //动画监听器
    _animationController.addListener(() {
      //每次都清空一下
      _wavePoints.clear();
      //振幅速度
      final double waveSpeed = _animationController.value * 1080;
      //弧度
      final double wavPoingRadian = _animationController.value * Math.pi * 2;
      //当前弧度对应的余弦值
      final double normalizer = Math.cos(wavPoingRadian);
      final double waveWidth = Math.pi / 250;
      final double waveHeight = 22.0;
      //循环计算点数
      for (int i = 0; i <= widget.size.width.toInt(); ++i) {
        double calc = Math.sin((waveSpeed - i) * waveWidth);
        print("$calc");
        _wavePoints.add(
          Offset(
            //每个点对应的x坐标
            i.toDouble(),
            //Y坐标计算
            calc * waveHeight * normalizer + widget.yOffset,
          ),
        );
      }
    });

    //重复执行动画
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //动画构建器
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) {
        //路径裁剪Path
        return ClipPath(
          //自定义Clipper
          clipper: WavePathClipper(
            //裁剪Path构建多边形使用到的点
            wavePointList: _wavePoints,
          ),
          //裁剪的目标Widget
          child: Container(
            width: widget.size.width,
            height: widget.size.height,
            color: widget.color,
          ),
        );
      },
    );
  }
}

///根据点位来构建 PathClipper
class WavePathClipper extends CustomClipper<Path> {
  
  WavePathClipper({@required this.wavePointList});
  //创建Path
  final Path path = Path();
  //点位信息集合
  final List<Offset> wavePointList;

  @override
  getClip(Size size) {
    //根据点来构建多边形
    path.addPolygon(wavePointList, false);
    //绘制直线
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    //闭合路径
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}

///自定义文本输入框
class TextFieldWidget extends StatelessWidget {
  //占位提示文本
  final String hintText;
  //输入框前置图标
  final IconData prefixIconData;
  //输入框后置图标
  final IconData suffixIconData;
  //是否隐藏文本
  final bool obscureText;
  //输入实时回调
  final Function onChanged;

  TextFieldWidget({
    Key key,
    this.hintText,
    this.prefixIconData,
    this.suffixIconData,
    this.obscureText,
    this.onChanged,
  }):super(key: key);

  @override
  Widget build(BuildContext context) {

    //获取绑定的数据体
    final model = Provider.of<HomeProviderModel>(context);
    //构建输入框
    return TextField(

      //实时输入回调
      onChanged: onChanged,
      //是否隐藏文本
      obscureText: obscureText,
      //隐藏文本小圆点的颜色
      cursorColor: Theme.of(context).accentColor,
      //文本样式
      style: TextStyle(
        color: Theme.of(context).accentColor,
        fontSize: 14.0,
      ),
      //输入框的边框
      decoration: InputDecoration(
        //提示文本
        labelText: hintText,
        //提示文本的样式
        labelStyle: TextStyle(color: Theme.of(context).accentColor),
        //可编辑时的提示文本的颜色
        focusColor: Theme.of(context).accentColor,
        //填充
        filled: true,
        //可编辑时 无边框样式
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),

        //获取输入焦点时的边框样式
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Theme.of(context).accentColor),
        ),

        //文本前置的图标
        prefixIcon: Icon(
          prefixIconData,
          size: 18,
          color: Theme.of(context).accentColor,
        ),
        //文本后置的图标
        suffixIcon: GestureDetector(
          onTap: () {
            model.isVisible = !model.isVisible;
          },
          child: Icon(
            suffixIconData,
            size: 18,
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}

///自定义按钮
class ButtonWidget extends StatelessWidget {
  //按钮上的文字
  final String buttonLabel;
  //是否填充背景
  final bool hasBorder;
  //点击事件回调
  final GestureTapCallback onTap;

  ButtonWidget({
    Key key,
    @required this.buttonLabel,
    this.hasBorder = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        //边框
        decoration: BoxDecoration(
          //定义填充颜色
          color: hasBorder ? Colors.white : Theme.of(context).accentColor,
          //点击事件高亮的边框圆角
          borderRadius: BorderRadius.circular(10),
          //边框设置
          border: hasBorder
              ? Border.all(
                  color: Theme.of(context).accentColor,
                  width: 1.0,
                )
              : Border.fromBorderSide(BorderSide.none),
        ),
        //事件监听回调
        child: buildInkWell(context),
      ),
    );
  }

  InkWell buildInkWell(BuildContext context) {
    return InkWell(
      //事件回调
      onTap: onTap,
      //点击的水波纹与高亮颜色 与Ink设置的背景圆角一致
      borderRadius: BorderRadius.circular(10),
      //按钮样式
      child: Container(
        height: 60.0,
        child: Center(
          child: Text(
            //文本内容
            buttonLabel,
            //文本样式
            style: TextStyle(
              //文本颜色
              color: hasBorder ? Theme.of(context).accentColor : Colors.white,
              //加粗
              fontWeight: FontWeight.w600,
              //文字大小
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}
