import 'package:clip_shadow/clip_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_test_app/tk/demo4/style.dart';
import 'package:flutter_test_app/tk/demo4/widgets/iconbutton.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XffCDDEEC),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            ClipShadow(
              clipper: RoundedDiagonalPathClipper(),
              boxShadow: softUiShadow,
              child: Container(
                height: 450,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(36.0)),
                  color: Color(0XffCDDEEC),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 60,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CustomIconButton(iconName: Icons.dehaze,)
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}


