
import 'package:flutter/material.dart';

import 'CustomDrawer.dart';

void main() {
  runApp(CustomDrawerApp());
}

class CustomDrawerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CustomDrawer(),
    );
  }
}
