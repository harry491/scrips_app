import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_app/components/discover_tag.dart';
import 'package:my_app/http/dartHttp.dart';
import 'package:my_app/model/movie_entity.dart';
import 'package:my_app/theme/materialColor.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Recommand extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RecommandState();
  }
}

class RecommandState extends State<Recommand> {
  List<MovieMovie> datas = [];

  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  var loadFailed = false;

  void _onRefresh() async {
    _getScrips();
  }

  void _onLoading() async {
    _getScrips();
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  _getScrips() async {
    // 纸条数据
    int page = 0;

    if (_refreshController.isRefresh) {
      page = 0;
    }

    var result = await HttpUtils.getMoviesData(context, params: {});
    if ((result.code == null || result.code != '200') && page == 0) {
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
      List resultArray = result.movies;
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
      setState(() {
        loadFailed = false;
        datas = resultArray;
      });
    } else {
      Fluttertoast.showToast(msg: result.msg);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("RecommandState");
    return Container(
      color: Color.fromARGB(255, 244, 244, 244),
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
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
                padding: EdgeInsets.all(10),
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    height: 50,
                    child: Text(
                      "为您推荐",
                      style: bigFontStyle,
                    ),
                  ),
                  ...datas.map((movie) {
                    return DiscoverTag(movie.head, movie.title, movie.other, () {});
                  }).toList(),
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    height: 10,
                  ),
                ],
              ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
      ),
    );
  }
}
