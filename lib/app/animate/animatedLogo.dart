import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedLogo extends AnimatedWidget {
  AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;

    // TODO: implement build
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: 40 + animation.value,
        width: 40 + animation.value,
        child: FlutterLogo(),
      ),
    );
  }
}
