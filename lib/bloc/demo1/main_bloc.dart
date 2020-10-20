import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app/bloc/demo1/test_bloc_time_page.dart';
import 'bloc_time.dart';

///flutter应用程序中的入口函数
void main() => runApp(BlocMainApp());

///应用的根布局
class BlocMainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ///构建Materia Desin 风格的应用程序
    return BlocProvider<TimeCounterBloc>(
      create: (context) => TimeCounterBloc(""),
      child: MaterialApp(
        ///Android应用程序中任务栏中显示应用的名称
        title: "配制",
        theme: ThemeData(
          accentColor: Colors.blue,
          ///默认是 Brightness.light
          brightness: Brightness.light,
        ),
        ///默认的首页面
        home: TestBlocTimePage(),
      ),
    );
  }
}
