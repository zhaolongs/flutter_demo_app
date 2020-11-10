import 'package:flutter/material.dart';
import 'package:matrix4_transform/matrix4_transform.dart';

import 'SecondLayer.dart';

class HomewPage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomewPage> with TickerProviderStateMixin {
  double xoffSet = 0;
  double yoffSet = 0;
  double angle = 0;

  bool isOpen = false;
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        transform: Matrix4Transform()
            .translate(x: xoffSet, y: yoffSet)
            .rotate(angle)
            .matrix4,
        duration: Duration(milliseconds: 250),
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.blue[200],
                borderRadius: isOpen
                    ? BorderRadius.circular(10)
                    : BorderRadius.circular(0)),
            child: SafeArea(
              child: Stack(
                children: [
                  !isOpen
                      ? IconButton(
                          icon: Icon(
                            Icons.menu,
                            color: Color(0xFF1f186f),
                          ),
                          onPressed: () {
                            setState(() {
                              xoffSet = 250;
                              yoffSet = 0;
                              angle = 0;
                              isOpen = true;
                            });

                            secondLayerState.setState(() {
                              secondLayerState.xoffSet = 122;
                              secondLayerState.yoffSet = 110;
                              secondLayerState.angle = -0.275;
                            });
                          })
                      : IconButton(
                          icon: Icon(Icons.arrow_back_ios,
                              color: Color(0xFF1f186f)),
                          onPressed: () {
                            if (isOpen == true) {
                              setState(() {
                                xoffSet = 0;
                                yoffSet = 0;
                                angle = 0;
                                isOpen = false;
                              });

                              secondLayerState.setState(() {
                                secondLayerState.xoffSet = 0;
                                secondLayerState.yoffSet = 0;
                                secondLayerState.angle = 0;
                              });
                            }
                          }),
                  Center(
                    child: Image.asset(
                      "images/welcome_bg.jpeg",
                      height: MediaQuery.of(context).size.height / 2,
                    ),
                  ),
                ],
              ),
            )));
  }
}
