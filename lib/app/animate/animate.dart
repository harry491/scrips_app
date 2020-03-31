import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/router/NavigatorUtils.dart';

class Animate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AnimateState();
  }
}

class AnimateState extends State<Animate> {
  List titles = ["线性动画"];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("动画"),
        ),
        body: Container(
          child: ListView(
            children: titles.map((value) {
              return GestureDetector(
                onTap: () {
                  NavigatorUtils.goLineAnimatePage(context);
                },
                child: ListTile(
                  title: Text(value),
                ),
              );
            }).toList(),
          ),
        ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
