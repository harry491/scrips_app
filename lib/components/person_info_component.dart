import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/theme/materialColor.dart';

class PersonInfoComponent extends StatelessWidget {
  @required
  final String title;

  final Widget right;

  final bool click;

  @required
  final double height;

  final VoidCallback callback;

  PersonInfoComponent(this.title, this.height, {this.right, this.click , this.callback});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: callback,
      child: Container(
        height:height,
        padding: EdgeInsets.only(left: 15, right: 15),
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                title,
                style: titleFontStyle,
              ),
            ),
            right ?? Container(),
            click ? Icon(Icons.keyboard_arrow_right) : Container()
          ],
        ),
      ),
    );
  }
}
