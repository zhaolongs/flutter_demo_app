import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * 创建人： Created by zhaolong
 * 创建时间：Created by  on 2020/7/19.
 *
 * 可关注公众号：我的大前端生涯   获取最新技术分享
 * 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
 * 可关注博客：https://blog.csdn.net/zl18603543572
 */

///lib/demo/flash/gradient/default_linear_gradient.dart
///默认的线性渐变
class DefaultLinearGradient extends LinearGradient {
  DefaultLinearGradient({
    ///高亮颜色
    @required Color normalColor,
    ///高亮颜色
    @required Color highlightColor,
  }) : super(
          ///开始位置为左上角
          begin: Alignment.topLeft,
          ///结束的位置为右中间
          end: Alignment.centerRight,
          ///过渡的颜色组
          colors: <Color>[
            normalColor,
            normalColor,
            highlightColor,
            normalColor,
            normalColor
          ],
          ///取范围为0.0到1.0 数值表示梯度方向上的分割比例
          ///如果stops是空的，那么stops里面默认存放一组均匀分布的点，并且第一个点是0.0，最后一个点是1.0。
          ///stops值列表中的数据必须是升序。如果stops值列表有一个数据小于前一个数据值，那么这个数据会被默认等于前面的数据值
          ///如果Stops不为空，那么它必须与colors中颜色个数保持一致，否则运行异常
          ///如果第一个数值不为0，此时会默认一个stop位置0.0，颜色和colors中第一个颜色相同。
          ///如果最后一个数值不为1.0，此时会默认一个stop位置1.0，颜色和colors中最后一个颜色相同
          stops: const <double>[0.0, 0.35, 0.5, 0.65, 1.0],
        );
}
