import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_app/components/mine.dart';
import 'package:my_app/event/event_bus.dart';
import 'package:my_app/event/event_model.dart';
import 'package:my_app/http/dartHttp.dart';
import 'package:my_app/model/scrip_model_entity.dart';
import 'package:my_app/redux/appState.dart';
import 'package:my_app/router/NavigatorUtils.dart';
import 'package:my_app/theme/materialColor.dart';
import 'package:my_app/utils/Utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Blog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BlogState();
  }
}

class BlogState extends State<Blog> with AutomaticKeepAliveClientMixin {
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  List<ScripModelScrip> pageList = [];

  var loadFailed = false;

  var msg = "";

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

    AppEvent.event.on<PublishNotification>().listen((event) {
      _refreshController.requestRefresh(needMove: true);
    });
  }

  _getScrips() async {
    // 纸条数据
    int page = (pageList.length / 20).toInt();

    if (_refreshController.isRefresh) {
      page = 0;
    }

    var result =
        await HttpUtils.scrips(context, params: {"page": page.toString()});
    if ((result.code == null || result.code != '200') && page == 0) {
      Fluttertoast.showToast(msg: "加载失败");
      setState(() {
        loadFailed = true;
        msg = result.msg;
      });

      if (_refreshController.isRefresh) {
        _refreshController.refreshCompleted();
      }
      return;
    }

    if (result.code == "200") {
      List<ScripModelScrip> resultArray = result.scrips;
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
        if (page == 0) {
          pageList = resultArray;
        } else {
          pageList.addAll(resultArray);
        }
      });
    } else {
      Fluttertoast.showToast(msg: result.msg);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 249, 250, 1),
//      drawer: Mine(),
      appBar: AppBar(
        title: Text("小纸条"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
            ),
            onPressed: () {
              NavigatorUtils.goWritePage(context);
            },
          ),
        ],
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
                child: Text(
                  "加载失败\n" + msg,
                  textAlign: TextAlign.center,
                ),
              )
            : ListView.builder(
                itemCount: pageList.length,
                itemBuilder: (context, pos) {
                  return new BlogItem(
                    pageList[pos],
                    index: pos,
                    pop: true,
                    valueChanged: (index) {},
                  );
                }),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class BlogItem extends StatefulWidget {
  final ScripModelScrip scrip;
  final int index;
  final bool pop;

  final ValueChanged<int> valueChanged;

  BlogItem(this.scrip, {this.index, this.pop, this.valueChanged});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new BlogItemState();
  }
}

class BlogItemState extends State<BlogItem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void updateScrips(ScripModelScrip s) {
    setState(() {
      widget.valueChanged(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        if (widget.pop) {
          NavigatorUtils.goBlogDetailPage(context, widget.scrip.toJson());
        }
      },
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.all(15),
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _blogItemInfo(widget.scrip),
              _blogItemText(context, widget.scrip.content),
              _blogItemImg(widget.scrip),
              _bolgItemTag(context, widget.scrip, widget.index, updateScrips),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bolgItemTag(
      BuildContext context, ScripModelScrip scrip, int index, updateScrips) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                Utils.timeFormat(scrip.createdAt),
                style: TextStyle(
                    fontSize: 13, color: Color.fromRGBO(179, 189, 199, 1)),
              )
            ],
          ),
        ),
        IconButton(
          icon: Icon(scrip.isCollect ? Icons.favorite : Icons.favorite_border),
          onPressed: () async {
            if (widget.valueChanged == null) return;

            /// 收藏
            var result = await HttpUtils.addCollect(context,
                params: {"scripId": scrip.iD});
            if (result["code"] == "200") {
              scrip.collectNumber = scrip.isCollect
                  ? scrip.collectNumber - 1
                  : scrip.collectNumber + 1;
              scrip.isCollect = !scrip.isCollect;
              updateScrips(scrip);
            }
          },
        ),
        Text(
          '${scrip.collectNumber}',
          style: smallFontStyle,
        ),
        IconButton(
          icon: Icon(scrip.isPoint
              ? Icons.sentiment_very_satisfied
              : Icons.sentiment_neutral),
          onPressed: () async {
            if (widget.valueChanged == null) return;

            /// 点赞
            var result = await HttpUtils.addPoint(context,
                params: {"scripId": scrip.iD});
            if (result["code"] == "200") {
              scrip.pointNumber =
                  scrip.isPoint ? scrip.pointNumber - 1 : scrip.pointNumber + 1;
              scrip.isPoint = !scrip.isPoint;
              updateScrips(scrip);
            }
          },
        ),
        Text(
          '${scrip.pointNumber}',
          style: smallFontStyle,
        ),
      ],
    );
  }

  Widget _blogItemText(BuildContext ctx, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 10,
        ),
        Text(
          content,
          overflow: TextOverflow.fade,
//          maxLines: 3,
          style: TextStyle(
            fontSize: 17,
            color: Color.fromRGBO(91, 101, 113, 1),
          ),
        ),
        Container(
          height: 5,
        ),
      ],
    );
  }

  Widget _blogItemImg(ScripModelScrip scrip) {
    if (scrip.images.length == 0) {
      return Container();
    } else {
      return Container(
        margin: EdgeInsets.only(top: 10, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: scrip.images.map((image) {
                return Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    image: DecorationImage(
                        image: new NetworkImage(HttpUtils.baseImageUrl + image),
                        fit: BoxFit.fill),
                  ),
                );
              }).toList(),
            ),
            Container(
              height: 10,
            ),
          ],
        ),
      );
    }
  }

  Widget _blogItemInfo(ScripModelScrip scrip) {
    return Row(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            image: DecorationImage(
                image: scrip.head == ""
                    ? AssetImage("images/long.png")
                    : NetworkImage(HttpUtils.baseImageUrl + scrip.head),
                fit: BoxFit.fill),
          ),
          width: 50,
          height: 50,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  scrip.alias == "" ? "小纸条" : scrip.alias,
                  style: TextStyle(
                      fontSize: 17, color: Color.fromRGBO(91, 101, 113, 1)),
                ),
                Container(
                  height: 5,
                ),
                Image.asset(
                  scrip.sex == 0 ? "images/nv.png" : "images/nan.png",
                  width: 15,
                  height: 15,
                ),
              ],
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.more_horiz),
        ),
      ],
    );
  }
}
