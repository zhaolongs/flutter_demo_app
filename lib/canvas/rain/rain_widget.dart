import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'my_rain_canvas.dart';
import 'particle.dart';

class RainWidget extends StatefulWidget {
  @override
  _RainWidgetState createState() => _RainWidgetState();
}

var rng = Random();

class _RainWidgetState extends State<RainWidget> {
  var particles = List<Particle>();
  Timer timer;
  @override
  void initState() {
    super.initState();

    var xx = 0.0;
    // create particles
    for (var i = 0; i < 15; i++) {
      xx += rng.nextDouble() * 12.0 + 12.0;
      var dx = xx;
      var dy = -rng.nextDouble() * 150.0;
      // generate the length and speed
      var len = rng.nextDouble() * 30.0 + 30.0;
      var speed = rng.nextDouble() * 5.0 + 1.0;
      particles.add(Particle()
        ..position = Offset(dx, dy)
        ..original = Offset(dx, dy)
        ..speed = speed
        ..length = len);
    }

    // animation timer
    final fps = 50.0;
    var frameDuration = (1000 ~/ fps);
    timer = Timer.periodic(Duration(milliseconds: frameDuration), (timer) {
      setState(() {
        particles.forEach((p) {
          p.position += Offset(0, p.speed);
          if (p.position.dy > 200) {
            p.position = p.original;
          }
        });
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: CustomPaint(
      child: Container(),
      painter: MyRainCanvas(particles),
    ));
  }
}
