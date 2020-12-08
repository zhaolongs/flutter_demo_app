import 'dart:async';

import 'package:flutter/material.dart';
import 'my_weather_canvas.dart';
import 'rain_widget.dart';

class WeatherWidget extends StatefulWidget {
  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  double t = 1.0;
  Timer timer;
  @override
  void initState() {
    super.initState();
    final fps = 50.0;
    var frameDuration = (1000 ~/ fps);
    timer = Timer.periodic(Duration(milliseconds: frameDuration), (timer) {
      setState(() {
        t = rng.nextDouble() < 0.001 ? 0.0 : t;
        t += 0.1;
        t = t > 1.0 ? 1.0 : t;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        // depending on the weather condition, set the correct widget
        // in this case it's the rain widget. You could also have
        // sunny widget, snowy widget, etc..
        child: Center(child: Transform.scale(scale: 0.5, child: RainWidget())),
        painter: MyWeatherCanvas(t),
      ),
    );
  }
}
