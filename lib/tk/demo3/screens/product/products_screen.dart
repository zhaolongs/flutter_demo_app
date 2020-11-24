import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test_app/tk/demo3/constants.dart';

import 'components/body.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: kPrimaryColor,
      body: Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      centerTitle: false,
      title: Text('Dashboard'),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset("assets/images/notification.svg"),
          onPressed: () {},
        ),
      ],
    );
  }
}
