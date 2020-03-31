import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_app/http/dartHttp.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Search extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SearchState();
  }
}

class SearchState extends State<Search> {

  List<Movie> items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getData();
  }

  _getData() async {

    var movies = await HttpUtils.getMoviesData(context);

    items.addAll([]);

    setState(() {

    });

    _refreshController.refreshCompleted(resetFooterState:true);
    _refreshController.loadComplete();

//    var url = "http://localhost/movies";
//
//    var httpClient = new HttpClient();
//    try {
//      var request = await httpClient.getUrl(Uri.parse(url));
//
//      var response = await request.close();
//
//      var responseBody = await response.transform(Utf8Decoder()).join();
//
//      var movies = jsonDecode(responseBody)["data"];
//
//      items.addAll(movies);
//
//      setState(() {
//
//      });
//      _refreshController.refreshCompleted();
//      print("complete");
//    } catch (e) {
//      print(e);
//      _refreshController.refreshCompleted();
//      print("complete");
//    }
  }



  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    _getData();
    items.clear();

  }

  void _onLoading() async {
    print("loadmore");
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("刷新"),
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("pull up load");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.canLoading) {
              body = Text("release to load more");
            } else if (mode == LoadStatus.failed) {
              body = Text("Load Failed!Click retry!");
            } else {
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(
          itemBuilder: (c, i) => ListTile(
            title: Text(items[i].title),
            subtitle: Text(items[i].other),
          ),
          itemExtent: 60.0,
          itemCount: items.length,
        ),
      ),
    );
  }
}
