import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/10/19.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
///代码清单
class DateUtils {

  ///获取默认格式的日期时间
  String getDefaultCurrentTime() {
    ///获取当前时间对象
    DateTime now = DateTime.now();

    ///创建格式化对象
    DateFormat formatter = DateFormat('yy-MM-dd hh:mm:ss');
    return formatter.format(now);
  }
}
