import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

String imgUrl =
    "https://user-gold-cdn.xitu.io/2019/9/20/16d4c9d7642779d3?imageView2/0/w/1280/h/960/format/webp/ignore-error/1";

class StackView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: null,
      body: ListView(
        children: <Widget>[
          StackChildView(),
        ],
      ),
    );
  }
}

class StackChildView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Stack(
      children: <Widget>[
        new Image.network(imgUrl),
        new Container(
          decoration: new BoxDecoration(
            color: Colors.black45,
          ),
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.all(15),
          child: new Text("Hello" , style: TextStyle(
            color: Colors.white,
          ),),
        ),
      ],
    );
  }
}
