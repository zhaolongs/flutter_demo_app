import 'dart:math';

import 'package:flutter/material.dart';

class MyWeatherCanvas extends CustomPainter {
  final double t;
  MyWeatherCanvas(this.t);
  // define the styles
  var normalTextStyle = TextStyle(
    color: Color(0xff4a4e69), //Colors.black,
    fontSize: 40,
    fontWeight: FontWeight.w400,
  );
  var titleTextStyle = TextStyle(
    color: Color(0xff4a4e69), //Colors.black,
    fontSize: 150,
    fontFamily: "Oswald",
    fontWeight: FontWeight.normal,
  );
  var unitsTextStyle = TextStyle(
    color: Color(0xff4a4e69), //Colors.black,
    fontSize: 50,
    fontFamily: "Oswald",
    fontWeight: FontWeight.w100,
  );
  var rng = Random();
  @override
  void paint(Canvas canvas, Size size) {
    var center = Offset(size.width / 2.0, size.height / 2.0);

    var p1 = Paint()..color = Color(0xfffeeafa); //Colors.white;
    canvas.drawPaint(p1);
    // var col = rng.nextDouble() < 0.001 ? Colors.white : Color(0xffcbc0d3);
    var col = Color.lerp(Colors.white, Color(0xffcbc0d3), t);
    var p = Paint()
      ..color = col
      ..style = PaintingStyle.fill;
    var rect = Rect.fromCenter(center: center, width: W, height: W);
    canvas.drawRect(rect, p);

    // draw stuff
    drawFrame(canvas, center);
    drawPlace(canvas, center, normalTextStyle);
    drawCondition(canvas, center, normalTextStyle);
    drawTemperature(canvas, center, titleTextStyle, unitsTextStyle);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  var W = 600.0;
  void drawFrame(Canvas canvas, Offset center) {
    var rect = Rect.fromCenter(center: center, width: W, height: W);
    var border = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0;
    canvas.drawRect(rect, border);
  }

  void drawPlace(Canvas canvas, Offset center, TextStyle ts) {
    var offset = 50.0;
    var placeName = "TOKYO";
    var pos = center + Offset(0, W / 2.0 - offset);
    drawHText1(canvas, pos, W, ts, placeName);
  }

  void drawCondition(Canvas canvas, Offset center, TextStyle ts) {
    var condition = "RAINY";
    var offset = 30.0;
    var pos = center + Offset(W / 2.0 - offset, 0);
    drawVText1(canvas, pos, 10.0, ts, condition);
  }

  // draw horizontal text horizontally centered around pos.
  void drawHText1(Canvas canvas, Offset pos, double w, TextStyle ts, String s) {
    final textSpan = TextSpan(text: s, style: ts);
    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: w);

    var drawPosition = Offset(pos.dx - textPainter.width / 2.0, pos.dy);
    textPainter.paint(canvas, drawPosition);
  }

  double drawHText2(
      Canvas canvas, Offset pos, double w, TextStyle ts, String s) {
    final textSpan = TextSpan(text: s, style: ts);
    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: w);

    var drawPosition = Offset(pos.dx, pos.dy);
    textPainter.paint(canvas, drawPosition);
    return textPainter.width;
  }

  void drawVText1(Canvas canvas, Offset pos, double w, TextStyle ts, String s) {
    final textSpan = TextSpan(text: s, style: ts);
    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: w);

    var drawPosition = Offset(pos.dx, pos.dy - textPainter.height / 2.0);
    textPainter.paint(canvas, drawPosition);
  }

  void drawTemperature(
      Canvas canvas, Offset center, TextStyle ts1, TextStyle ts2) {
    var temp = "12";
    // draw the digits
    var offset = Offset(10, -40.0);
    var pos = center + Offset(-W / 2.0, -W / 2.0) + offset;
    var width = drawHText2(canvas, pos, W / 2.0, ts1, temp);
    // draw the units
    var units = "°c";
    var pos1 = pos + Offset(width, 45);
    drawHText2(canvas, pos1, 30, ts2, units);
  }
}
