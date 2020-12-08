import 'package:flutter/material.dart';

import 'weather_widget.dart';

void main() {
  runApp(MyApp());
}

///下雨
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WeatherWidget(),
    );
  }
}
