import 'package:flutter/material.dart';

class ThirdLayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FlutterLogo(
                        size: MediaQuery.of(context).size.width / 4,
                      ),
                      Row(
                        children: [
                          Text(
                            "FLUTTER",
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "HOLIC",
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.blue[200],
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Home Screen",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                ),
                Text(
                  "Screen 2",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                ),
                Divider(
                  color: Color(0xFF5950a0),
                  thickness: 2,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                ),
                Text(
                  "About",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                ),
                Text(
                  "Share App",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                ),
                Divider(
                  color: Color(0xFF5950a0),
                  thickness: 2,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                ),
                Text(
                  "Bye",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
