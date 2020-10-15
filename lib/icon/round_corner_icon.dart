import 'package:flutter/material.dart';



class RoundCornerIcon extends StatelessWidget {

  final IconData iconData;
  final Gradient gradient;

  const RoundCornerIcon({
    Key key,
    @required this.gradient,
    @required this.iconData,
  })  : assert(iconData != null),
        assert(gradient != null),
        super(key: key);


  @override
  Widget build(BuildContext context) {
    ///圆角裁剪
    return ClipRRect(
      ///四个圆角的角度
      borderRadius: BorderRadius.circular(5),
      ///被裁剪的子Widget
      child:Container(
        ///渐变样式的背景装饰
        decoration: BoxDecoration(
          gradient: gradient
        ),
        ///圆角背景大小
        height: 23,
        width: 23,
        ///中间的小图标
        child: Icon(
          ///图标数据
          iconData,
          ///图标大小
          size: 18,
          ///图标的颜色
          color: Colors.white,
        ),
      ),
    );
  }
}
