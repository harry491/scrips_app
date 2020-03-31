import 'dart:async';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LineAnimate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LineAnimateState();
  }
}

class LineAnimateState extends State<LineAnimate>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  Tween<double> tween;
  Tween<Color> colorTween;

  List titles = ["1", "2", "3"];

  bool forward = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 300));

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut)
      ..addListener(() {
        setState(() {});
      });

    tween = Tween(begin: 0, end: titles.length * 50.0);

    colorTween = ColorTween(begin: Colors.white, end: Colors.white);

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      floatingActionButton: IconButton(
        icon: Icon(Icons.forward),
        onPressed: () {
          if (forward) {
            _controller.reverse();
          } else {
            _controller.forward();
          }
          forward = !forward;
        },
      ),
      appBar: AppBar(
        title: Text("线性动画"),
      ),
      body: Container(
          child: ListView(
            itemExtent: 50,
            shrinkWrap: true,
            children: titles.map((value) {
              return GestureDetector(
                onTap: (){
                  forward = false;
                  _controller.reverse();
                },
                child: ListTile(
                  title: Text(value),
                ),
              );
            }).toList(),
          ),
          color: colorTween.evaluate(_controller),
          height: tween.evaluate(_controller)),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _controller.dispose();
    super.dispose();
  }
}
