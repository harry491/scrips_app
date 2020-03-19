import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_app/components/cert.dart';
import 'package:my_app/components/community_info.dart';
import 'package:my_app/components/mine_head.dart';
import 'package:my_app/http/dartHttp.dart';
import 'package:my_app/model/user.dart';
import 'package:my_app/model/user_model_entity.dart';
import 'package:my_app/redux/appState.dart';
import 'package:my_app/redux/userRedux.dart';
import 'package:my_app/router/NavigatorUtils.dart';

class MyBlog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyBlogState();
  }
}

class MyBlogState extends State<MyBlog> {

  ScrollController _scrollController = new ScrollController();

  double top = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero, () {
      getUserInfo();
      top = MediaQuery.of(context).padding.top;
    });

    _scrollController.addListener(() {
//      print(_scrollController.position.pixels);
    });
  }

  void getUserInfo() async {
    var newUser = await HttpUtils.getUserInfo(context, params: {});
    if (newUser.code == "200") {
      StoreProvider.of<AppState>(context)
          .dispatch(UserThemeDataAction(newUser));
      UserUtils.setUserInfo(newUser);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: null,
        body: MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                double progress = notification.metrics.pixels;
                print(progress);
              },
              child: StoreBuilder<AppState>(
                builder: (context, store) {
                  return ListView(
                      physics: AlwaysScrollableScrollPhysics(),
                      controller: _scrollController,
                      children: <Widget>[
                        MineHead(store.state.userModel.user , store.state.themeData , top: top,),
                        store.state.userModel.user.alias == ""
                            ? Cert()
                            : Container(),
                        Container(
                          height: 0.5,
                          color: Colors.black12,
                        ),
                        CommunityInfo(
                          title: "收藏",
                          callback: (){
                            NavigatorUtils.goFavouritePage(context);
                          },
                        ),
                        Container(
                          height: 0.5,
                          color: Colors.black12,
                        ),
                        CommunityInfo(
                          title: "关于",
                          callback: () {
                            NavigatorUtils.goWebPage(context, {
                              "url": HttpUtils.baseImageUrl +
                                  "src/static/html/about_us.html"
                            });
                          },
                        ),
                        Container(
                          height: 0.5,
                          color: Colors.black12,
                        ),
                        CommunityInfo(
                          title: "设置",
                          callback: () {
                            NavigatorUtils.goSetPage(context);
                          },
                        ),
                        Container(
                          height: 0.5,
                          color: Colors.black12,
                        ),
                      ]);
                },
              ),
            )));
  }
}
