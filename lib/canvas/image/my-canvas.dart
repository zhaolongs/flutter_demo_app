import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class MyCanvas extends CustomPainter {
  ui.Image bgImage;
  int imageCount = 0;
  int selectedIndex = 0;
  MyCanvas(this.bgImage, this.imageCount, this.selectedIndex);
  @override
  void paint(Canvas canvas, Size size) {
    var offset = Offset(size.width / 2, size.height / 2);
    drawImage(canvas, offset);
    drawFrame(canvas, offset);
    drawDots(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  var W = 600.0;
  void drawFrame(Canvas canvas, Offset offset) {
    var rect = Rect.fromCenter(center: offset, width: W, height: W);
    var border = Paint()
      ..color = Colors.black
      ..strokeWidth = 10.0
      ..style = PaintingStyle.stroke;

    canvas.drawRect(rect, border);
  }

  void drawImage(Canvas canvas, Offset offset) {
    if (this.bgImage != null) {
      var rect = Rect.fromCenter(center: offset, width: W, height: W);
      // canvas.drawImage(this.bgImage, Offset(0, 0), Paint());
      paintImage(this.bgImage, rect, canvas, Paint(), BoxFit.cover);
    }
  }

  void drawDots(Canvas canvas, Offset offset) {
    var pOff = Paint()
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..color = Colors.grey;
    var pOn = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.grey;

    var radius = 10.0;
    var k = 2 * radius + 5.0;
    var c = Offset(-k * (imageCount - 1.0) / 2.0, W / 2 + 20);
    for (var i = 0; i < imageCount; i++) {
      if (i == this.selectedIndex % imageCount) {
        canvas.drawCircle(c + offset, radius, pOn);
      } else {
        canvas.drawCircle(c + offset, radius, pOff);
      }
      c += Offset(k, 0);
    }
  }

  void paintImage(
      ui.Image image, Rect outputRect, Canvas canvas, Paint paint, BoxFit fit) {
    final Size imageSize =
        Size(image.width.toDouble(), image.height.toDouble());
    final FittedSizes sizes = applyBoxFit(fit, imageSize, outputRect.size);
    final Rect inputSubrect =
        Alignment.center.inscribe(sizes.source, Offset.zero & imageSize);
    final Rect outputSubrect =
        Alignment.center.inscribe(sizes.destination, outputRect);
    canvas.drawImageRect(image, inputSubrect, outputSubrect, paint);
  }
}
