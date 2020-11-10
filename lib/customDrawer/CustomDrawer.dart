
import 'package:flutter/material.dart';

import 'FirstLayer.dart';
import 'HomePage.dart';
import 'SecondLayer.dart';
import 'ThirdLayer.dart';


void main() {
  runApp(CustomDrawerApp());
}

class CustomDrawerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CustomDrawer(),
    );
  }
}

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FirstLayer(),
          SecondLayer(),
          ThirdLayer(),
          HomewPage(),
        ],
      ),
    );
  }
}

