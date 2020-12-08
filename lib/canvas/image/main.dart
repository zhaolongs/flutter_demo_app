import 'package:flutter/material.dart';

import 'my-painter.dart';

void main() {
  runApp(MyApp());
}

//绘制图片
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Tutorials',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyPainter(),
    );
  }
}
