import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyText extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: new Text("文本"),
      ),
      body: new ListView(
        children: <Widget>[
          new Text("123"),
        ],
      ),
    );
  }
}
