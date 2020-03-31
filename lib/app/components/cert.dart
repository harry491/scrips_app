import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/router/NavigatorUtils.dart';
import 'package:my_app/app//theme/materialColor.dart';

class Cert extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CertState();
  }
}

class CertState extends State<Cert> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
      child: Container(
        padding: EdgeInsets.only(left: 15, top: 15),
        alignment: Alignment.centerLeft,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.amberAccent,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "你还没信息没有完善 ,\n 去完善",
              style: bigFontStyle,
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
                  side: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              color: Colors.red,
              child: Text(
                "去完善",
                style: bigButtonStyle,
              ),
              onPressed: () {
                NavigatorUtils.goPersonInfoPage(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
