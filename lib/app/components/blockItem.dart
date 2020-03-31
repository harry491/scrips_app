import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/app//theme/materialColor.dart';

class BlockItem extends StatelessWidget {
  final String title;
  final VoidCallback callback;
  final List items;

  BlockItem(this.title, this.items, this.callback);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(left: 15 , right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 10 , left: 15),
            child: Text(
              "其他工具",
              style: bigFontStyle,
            ),
          ),
          Wrap(
              children: [1, 1, 1, 1, 1, 1, 1, 1, 1, 1].map((vaule) {
            return Container(
              width: (MediaQuery.of(context).size.width / 4.0) - 30,
              margin: EdgeInsets.only(left: 3 , top: 10),
              color: Colors.red,
              child: AspectRatio(
                aspectRatio: 1,
              ),
            );
          }).toList()),
        ],
      ),
    );
  }
}
