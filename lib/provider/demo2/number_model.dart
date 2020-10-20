



import 'dart:math';

import 'package:flutter/cupertino.dart';
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


class RandomNumberModel with ChangeNotifier {
  int _randomNumber=0;

  ///指定数据
  void testNumber(int number) {
    _randomNumber = number;
    notifyListeners();//2
  }

  ///随机数据
  void testRandom(){
    _randomNumber = Random().nextInt(100);
    notifyListeners();
  }
  get randomNumber => _randomNumber;//3
}