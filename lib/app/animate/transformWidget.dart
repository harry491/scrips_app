import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransformWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TransformWidgetState();
  }
}

class TransformWidgetState extends State<TransformWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  Animation<double> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);

    // 旋转角度为弧度 0 - 2 * PI
    _animation = Tween(begin: 0.0, end: pi).animate(_controller)..addListener((){
      setState(() {

      });
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      } else {
        print(status);
      }
    });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("旋转"),
      ),
      body: Container(
        child: Center(
            child: Transform.rotate(
          angle: _animation.value,
          child: FlutterLogo(
            size: 200,
          ),
        )),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
}
