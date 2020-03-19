import 'package:flutter/material.dart';

class MyDialog extends Dialog {
  final String text;

  MyDialog({this.text});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
        type: MaterialType.transparency,
        child: Center(
          child: SizedBox(
            width: 120,
            height: 120,
            child: Container(
              decoration: ShapeDecoration(
                  color: Color(0xffffffff),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new CircularProgressIndicator(),
                  new Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(text),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
