import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_app/model/user.dart';
import 'package:my_app/redux/appState.dart';
import 'package:my_app/redux/userRedux.dart';
import 'package:my_app/router/NavigatorUtils.dart';

class BlogSplash extends StatefulWidget {
  final List<String> images;
  final double width;
  final Widget exit;

  BlogSplash({this.images, this.width = 100, this.exit});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BlogSplashState();
  }
}

class BlogSplashState extends State<BlogSplash> {
  Timer countdownTimer;

  int pass = 3;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    countdownTimer = new Timer.periodic(new Duration(seconds: 1), (timer) {
      setState(() {
        pass--;
      });
      if (pass == 0) {
        countdownTimer.cancel();
        countdownTimer = null;
        passSplash();
      }
    });
  }

  void passSplash() async {
    var token = await UserUtils.getUserToken();
    if (token != null && token != "") {
      var userModel = await UserUtils.getUserInfo();
      StoreProvider.of<AppState>(context)
          .dispatch(UserThemeDataAction(userModel));
      NavigatorUtils.goHomePage(context);
    } else {
      NavigatorUtils.goLoginPage(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: PageView(
          children: widget.images.asMap().keys.map((index) {
            return Container(
              child: Stack(
                fit: StackFit.expand,
                alignment: AlignmentDirectional.bottomEnd,
                children: <Widget>[
                  Image.network(
                    widget.images[index],
                    fit: BoxFit.fill,
                  ),
                  index == (widget.images.length - 1)
                      ? Positioned(
                          bottom: MediaQuery.of(context).padding.bottom + 20,
                          right: 15,
                          child: GestureDetector(
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  color: Colors.black38,
                                ),
                                width: widget.width,
                                height: 30,
                                child: Center(
                                  child: Text(
                                    '${pass}s跳过',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                                )),
                            onTap: () {
                              passSplash();
                            },
                          ))
                      : Container(),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (countdownTimer != null){
      countdownTimer.cancel();
      countdownTimer = null;
    }
  }
}
