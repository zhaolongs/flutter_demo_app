import 'package:flutter/material.dart';

const backgroundGradient = LinearGradient(colors: <Color>[
  Color(0XffE5EEF4),
  Color(0XffCDDEEC),
], begin: Alignment.topCenter, end: Alignment.bottomCenter);

List<BoxShadow> softUiShadow = [
  BoxShadow(
    color: Colors.white,
    offset: Offset(-5, -5),
    spreadRadius: 1,
    blurRadius: 15,
  ),
  BoxShadow(
    color: Color(0XFF748CAC).withOpacity(.6),
    offset: Offset(5, 5),
    spreadRadius: 1,
    blurRadius: 15,
  ),
];

const activeGradient = LinearGradient(
  colors: <Color>[
    Color(0Xffc94b4b),
    Color(0Xff4b134f),
  ],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

List<IconData> iconBtns = [
  Icons.directions_run,
  Icons.donut_small,
  Icons.track_changes,
  Icons.tune
];
