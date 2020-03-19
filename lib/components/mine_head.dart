import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/http/dartHttp.dart';
import 'package:my_app/model/user_model_entity.dart';
import 'package:my_app/router/NavigatorUtils.dart';
import 'package:my_app/theme/materialColor.dart';

class MineHead extends StatelessWidget {

  final double top;

  final UserModelUser user;

  final ThemeData data;

  MineHead(this.user, this.data , {this.top = 0});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        NavigatorUtils.goPersonInfoPage(context);
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 30),
            padding: EdgeInsets.only(top: top + 40, bottom: 60, left: 15, right: 15),
            color: data.primaryColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    image: DecorationImage(
                        image: user.head == ""
                            ? AssetImage("images/long.png")
                            : NetworkImage(HttpUtils.baseImageUrl + user.head),
                        fit: BoxFit.fill),
                  ),
                ),
                Container(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        user.alias,
                        style: bigFontStyle,
                      ),
                      Container(
                        height: 10,
                      ),
                      Image.asset(
                        user.sex == 0 ? "images/nv.png" : "images/nan.png",
                        width: 15,
                        height: 15,
                      ),
                      Container(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 5, right: 5, top: 2.5, bottom: 2.5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "个人主页",
                              style: smallFontStyle,
                            ),
                            Icon(Icons.arrow_right),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    NavigatorUtils.goSetPage(context);
                  },
                  child: Icon(Icons.settings),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.white,
              ),
              height: 60,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "0赞",
                      textAlign: TextAlign.center,
                      style: normalFontStyle,
                    ),
                    flex: 1,
                  ),
                  Container(
                    height: 20,
                    width: 1,
                    color: Colors.black12,
                  ),
                  Expanded(
                    child: Text(
                      "0收藏",
                      textAlign: TextAlign.center,
                      style: normalFontStyle,
                    ),
                    flex: 1,
                  ),
                  Container(
                    width: 1,
                    height: 20,
                    color: Colors.black12,
                  ),
                  Expanded(
                    child: Text(
                      "0纸条",
                      textAlign: TextAlign.center,
                      style: normalFontStyle,
                    ),
                    flex: 1,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
