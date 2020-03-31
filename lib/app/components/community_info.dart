import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/app/theme/materialColor.dart';

class CommunityInfo extends StatefulWidget {
  final String title;
  final VoidCallback callback;

  CommunityInfo({this.title, this.callback});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CommunityInfoState();
  }
}

class CommunityInfoState extends State<CommunityInfo> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: widget.callback,
      child: Container(
        color: Colors.white,
        alignment: Alignment.centerLeft,
        height: 60,
        padding: EdgeInsets.only(left: 15, right: 15, bottom: 1),
        child: Text(
          widget.title,
          style: bigFontStyle,
        ),
      ),
    );
  }
}
