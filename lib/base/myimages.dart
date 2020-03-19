import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyImages_new extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: new Text("图标"),
      ),
      body: new ListView(
        children: <Widget>[
          new Image(
            image: AssetImage("images/mine_safe.png"),
            repeat: ImageRepeat.repeatX,
            height: 50,
          ),
          new Image(
            image: AssetImage("images/mine_safe.png"),
            height: 50,
          ),
          new Image(
            image: AssetImage("images/mine_safe.png"),
            height: 50,
          ),

        ],
      ),
    );
  }
}
