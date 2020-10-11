import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestClipReactPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ClipOvalState();
  }
}

class _ClipOvalState extends State   {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: new AppBar(title: Text(" ClipOval "),),
      body: Container(
        width: 100,
        height: 100,
        ///裁剪组件
        child: ClipRect(
          ///一个图片
          child: new Image.network(
              imageUrl, //图片地址
              ///填充
              fit: BoxFit.fill),
        ),
      ),
    );
  }

  String imageUrl =
      "https://timgsa.baidu.com/timg?demo.image&quality=80&size=b9999_10000&sec=1578583093&di=0bf687d9589dc5c6c0778de9576ee077&imgtype=jpg&er=1&src=http%3A%2F%2Ffile.mumayi.com%2Fforum%2F201403%2F28%2F111010vhgc45hkh41f1mfd.jpg";
}
