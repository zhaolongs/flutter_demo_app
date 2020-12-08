import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'my-canvas.dart';

class MyPainter extends StatefulWidget {
  @override
  _MyPainterState createState() => _MyPainterState();
}

class _MyPainterState extends State<MyPainter> {
  @override
  void initState() {
    super.initState();
    // Load the images from assets
    loadImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          setState(() {
            this.selectedIndex++;
            this.selectedImage = this.images.length > 0
                ? this.images[this.selectedIndex % this.images.length]
                : null;
            print(
                "Selected image index = ${this.selectedIndex % this.images.length}");
          });
        },
        child: CustomPaint(
          child: Container(),
          painter: MyCanvas(
              this.selectedImage, this.images.length, this.selectedIndex),
        ),
      ),
    );
  }

  var images = new List<ui.Image>();
  ui.Image selectedImage;
  int selectedIndex = 0;
  void loadImages() {
    var names = ["3.webp", "1.webp", "2.webp"];
    names.forEach((name) {
      rootBundle.load("assets/images/banner$name").then((bd) {
        decodeImageFromList(bd.buffer.asUint8List()).then((img) {
          setState(() {
            this.images.add(img);
            this.selectedImage = this.images.length > 0 ? this.images[0] : null;
          });
        });
      });
    });
  }
}
