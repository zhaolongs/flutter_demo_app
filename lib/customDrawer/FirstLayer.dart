import 'package:flutter/material.dart';

class FirstLayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [Color(0xFF4c41a3), Color(0xFF1f186f)])),
    );
  }
}
