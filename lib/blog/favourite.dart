import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_app/blog/blog.dart';
import 'package:my_app/http/dartHttp.dart';
import 'package:my_app/model/scrip_model_entity.dart';
import 'package:my_app/router/NavigatorUtils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyFavourite extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyFavouriteState();
  }
}

class MyFavouriteState extends State<MyFavourite> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  List<ScripModelScrip> pageList = [];

  var loadFailed = false;

  void _onRefresh() async {
    _getScrips();
  }

  void _onLoading() async {
    _getScrips();
  }

  _getScrips() async {
    // 纸条数据
    int page = (pageList.length / 20).toInt();

    if (_refreshController.isRefresh) {
      page = 0;
    }

    var result =
    await HttpUtils.myCollect(context, params: {"page": page.toString()});
    if (result == null && page == 0) {
      Fluttertoast.showToast(msg: "加载失败");
      setState(() {
        loadFailed = true;
      });

      if (_refreshController.isRefresh) {
        _refreshController.refreshCompleted();
      }
      return;
    }

    if (result.code == "200") {
      List<ScripModelScrip> resultArray = result.scrips;
      setState(() {
        loadFailed = false;
        if (page == 0) {
          pageList = resultArray;
        } else {
          pageList.addAll(resultArray);
        }
      });

      if (_refreshController.isRefresh) {
        _refreshController.refreshCompleted();
      }

      if (resultArray.length < 20) {
        _refreshController.loadNoData();
      } else {
        _refreshController.resetNoData();
      }

      if (_refreshController.isLoading) {
        _refreshController.loadComplete();
      }
    } else {
      Fluttertoast.showToast(msg: result.msg);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 249, 250, 1),
      appBar: AppBar(
        title: Text("我的收藏"),
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: loadFailed ? false : true,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("pull up load");
            } else if (mode == LoadStatus.loading) {
              body = Text("Loading");
            } else if (mode == LoadStatus.failed) {
              body = Text("Load Failed!Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("release to load more");
            } else {
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        child: loadFailed
            ? Center(
                child: Text("加载失败"),
              )
            : ListView(
                children: pageList.asMap().keys.map((value) {
                  return BlogItem(
                    pageList[value],
                    index: value,
                    valueChanged: (index){},
                  );
                }).toList(),
              ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
      ),
    );
  }
}
