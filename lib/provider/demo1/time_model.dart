




/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/10/20.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
/// 
/// 代码清单 
///代码清单
///
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class TimeCounterModel with ChangeNotifier {

  String _formatTime="00:00:00";

  void getCurrentTime() {
    ///获取当前的时间
    DateTime dateTime= DateTime.now();
    ///格式化时间 import 'package:intl/intl.dart';
    ///需要添加 intl 依赖
    _formatTime = DateFormat("HH:mm:ss").format(dateTime);
    notifyListeners();//2
  }

  get formatTime => _formatTime;//3
}