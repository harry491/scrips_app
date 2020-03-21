import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/http/dartHttp.dart';
import 'package:my_app/theme/materialColor.dart';

class DiscoverTag extends StatelessWidget {
  final String head;
  final String title;
  final String desc;
  final VoidCallback callback;

  DiscoverTag(this.head, this.title, this.desc, this.callback);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: callback,
      child: Column(
        children: <Widget>[
          Divider(
            height: 0.5,
          ),
          Container(
            padding: EdgeInsets.only(left: 15),
            color: Colors.white,
            height: 80,
            child: Row(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    image: DecorationImage(
                        image: head == ""
                            ? AssetImage("images/long.png")
                            : NetworkImage(head),
                        fit: BoxFit.fill),
                  ),
                  width: 50,
                  height: 50,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(title == "" ? "小纸条" : title, style: bigFontStyle),
                        Container(
                          height: 5,
                        ),
                        Text(
                          desc,
                          style: smallFontStyle,
                        )
                      ],
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.more_horiz),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
