import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/app/animate/animatedLogo.dart';

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

    _animation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 100.0).chain(CurveTween(curve: Curves.easeInOut)), weight: 10),
      TweenSequenceItem(tween: Tween(begin: 100.0, end: 80.0), weight: 10),
      TweenSequenceItem(tween: Tween(begin: 89.0, end: 200.0), weight: 10)
    ]).animate(_controller);
//    CurvedAnimation(parent: _controller, curve: Curves.easeInOut)
//      ..addListener(() {
//        setState(() {});
//      });

    tween = Tween<double>(begin: 0, end: titles.length * 50.0);

    colorTween = ColorTween(begin: Colors.black38, end: Colors.white);
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
          title: Text("放大缩小"),
        ),
        body: AnimatedLogo(
          animation: _animation,
        )
//      Container(
//          margin: EdgeInsets.all(5),
//          decoration: BoxDecoration(
//              color: colorTween.evaluate(_controller),
//              borderRadius: BorderRadius.only(
//                  topLeft: Radius.circular(10),
//                  bottomRight: Radius.circular(10)),
//              boxShadow: [
//                BoxShadow(
//                    color: Colors.black38,
//                    offset: Offset(5, 5),
//                    blurRadius: 14,
//                    spreadRadius: 2)
//              ]),
//          child: ListView(
//            itemExtent: 50,
//            shrinkWrap: true,
//            children: titles.map((value) {
//              return GestureDetector(
//                onTap: () {
//                  forward = false;
//                  _controller.reverse();
//                },
//                child: ListTile(
//                  title: Text(value),
//                ),
//              );
//            }).toList(),
//          ),
//          height: tween.evaluate(_controller)),
        );
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _controller.dispose();
    super.dispose();
  }
}
