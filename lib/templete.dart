//import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
//import 'package:fluttertoast/fluttertoast.dart';
//import 'package:pull_to_refresh/pull_to_refresh.dart';
//
//import 'http/dartHttp.dart';
//
//class Templete extends StatefulWidget {
//  final Map<String, dynamic> params;
//
//  Templete({this.params});
//
//  @override
//  State<StatefulWidget> createState() {
//    // TODO: implement createState
//    return TempleteState();
//  }
//}
//
//class TempleteState extends State<Templete> {
//  RefreshController _refreshController =
//      RefreshController(initialRefresh: true);
//
//  var pageList = [];
//
//  var scripId;
//
//  var content = "";
//
//  void _onRefresh() async {
//    _getScrips();
//  }
//
//  void _onLoading() async {
//    _getScrips();
//    _refreshController.loadComplete();
//  }
//
//  _getScrips() async {
//    // 纸条数据
//    int page = (pageList.length / 20).toInt();
//    var result = await HttpUtils.comments(context,
//        params: {"page": page.toString(), "scripId": scripId});
//    print(result);
//    if (result["status"] == "0") {
//      List resultArray = result["comments"];
//      setState(() {
//        if (page == 0) {
//          pageList = resultArray;
//        } else {
//          pageList.addAll(resultArray);
//        }
//      });
//
//      if (_refreshController.isRefresh) {
//        _refreshController.refreshCompleted();
//      }
//
//      if (resultArray.length < 20) {
//        _refreshController.loadNoData();
//      } else {
//        _refreshController.resetNoData();
//      }
//
//      if (_refreshController.isLoading) {
//        _refreshController.loadComplete();
//      }
//    } else {
//      Fluttertoast.showToast(msg: result["msg"]);
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
////    final Map blog = ModalRoute.of(context).settings.arguments;
//    this.scripId = widget.params["ID"];
//    // TODO: implement build
//    return Scaffold(
//      backgroundColor: Color.fromRGBO(248, 249, 250, 1),
//      appBar: AppBar(
//        title: Text("纸条详情"),
//      ),
//      body: SmartRefresher(
//        enablePullDown: true,
//        enablePullUp: true,
//        controller: _refreshController,
//        onRefresh: _onRefresh,
//        onLoading: _onLoading,
//        header: WaterDropHeader(),
//        footer: CustomFooter(
//          builder: (BuildContext context, LoadStatus mode) {
//            Widget body;
//            if (mode == LoadStatus.idle) {
//              body = Text("pull up load");
//            } else if (mode == LoadStatus.loading) {
//              body = Text("Loading");
//            } else if (mode == LoadStatus.failed) {
//              body = Text("Load Failed!Click retry!");
//            } else if (mode == LoadStatus.canLoading) {
//              body = Text("release to load more");
//            } else {
//              body = Text("No more Data");
//            }
//            return Container(
//              height: 55.0,
//              child: Center(child: body),
//            );
//          },
//        ),
//        child: SafeArea(
//          child: Column(children: <Widget>[]),
//        ),
//      ),
//    );
//  }
//}
