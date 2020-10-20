



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


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
///Bolc 的泛型数据类型
///在这里 int 代表输入的事件类型
///      String 代表输出的数据结果
class TimeCounterBloc extends Bloc<int, String> {
  ///默认构造
  ///[initialState]默认的数据
  TimeCounterBloc(String initialState) : super(initialState);

  ///业务逻辑处理 [event] 事件标识
  @override
  Stream<String> mapEventToState(int event) async* {
    ///获取当前的时间
    DateTime dateTime= DateTime.now();
    ///格式化时间 import 'package:intl/intl.dart';
    ///需要添加 intl 依赖
    String formatTime = DateFormat("HH:mm:ss").format(dateTime);
    ///发射更新数据
    yield formatTime;
  }
}