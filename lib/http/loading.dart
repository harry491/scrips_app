import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class Loading extends Dialog {
  final String tips;

  Loading(this.tips);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Container(
        color: Colors.grey,
        padding: EdgeInsets.all(20),
        child: Text(
          tips,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
