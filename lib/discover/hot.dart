import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Hot extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HotState();
  }
}

class HotState extends State<Hot> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("HotState");
    return Container(
      color: Colors.white,
      child: Text("111"),
    );
  }
}
