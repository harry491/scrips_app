import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_app/http/dartHttp.dart';
import 'package:my_app/model/comments_entity.dart';
import 'package:my_app/model/scrip_model_entity.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'blog.dart';

class BlogDetail extends StatefulWidget {
  final Map<String, dynamic> params;

  BlogDetail({this.params});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BlogDetailState();
  }
}

class BlogDetailState extends State<BlogDetail> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  var pageList = [];

  var scripId;

  var content = "";

  void _onRefresh() async {
    _getScrips();
  }

  void _onLoading() async {
    _getScrips();
    _refreshController.loadComplete();
  }

  _getScrips() async {
    // 纸条数据
    int page = (pageList.length / 20).toInt();
    var result = await HttpUtils.comments(context,
        params: {"page": page.toString(), "scripId": scripId});
    print(result);
    if (result.code == "200") {
      List resultArray = result.comments;
      setState(() {
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
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      _onRefresh();
    });
  }

  @override
  Widget build(BuildContext context) {
//    final Map blog = ModalRoute.of(context).settings.arguments;
    this.scripId = widget.params["ID"];
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 249, 250, 1),
      appBar: AppBar(
        title: Text("纸条详情"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            BlogItem(
              ScripModelScrip.fromJson(widget.params),
              pop: false,
            ),
            Expanded(
              child: SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
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
                child: ListView(
                  children: pageList.map((value) {
                    return BlogComment(value);
                  }).toList(),
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom),
                height: 100 + MediaQuery.of(context).padding.bottom,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "输入你评论",
                          ),
                          maxLines: 10,
                          onChanged: (e) {
                            setState(() {
                              if (e != null) {
                                this.content = e;
                              }
                            });
                          },
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 5),
                      child: Column(
                        children: <Widget>[
                          RaisedButton(
                            child: Text("确定"),
                            onPressed: () async {
                              if (content.length == 0) {
                                Fluttertoast.showToast(msg: "请输入评论");
                                return;
                              }

                              var result = await HttpUtils.writeComment(context,
                                  params: {
                                    "content": content,
                                    "authorId": "1",
                                    "scripId": widget.params["ID"],
                                  });
                              print(result);
                              if (result["code"] == "200") {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                _refreshController.requestRefresh();
                              } else {
                                Fluttertoast.showToast(msg: result["msg"]);
                              }
                            },
                          ),
                          RaisedButton(
                            child: Text("取消"),
                            onPressed: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BlogComment extends StatelessWidget {
  final CommantsCommants comment;

  BlogComment(this.comment);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          _blogItemInfo(comment),
          _blogItemText(context, comment.content, comment.createdAt),
        ],
      ),
    );
  }

  Widget _blogItemInfo(CommantsCommants comment) {
    return Row(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            image: DecorationImage(
                image: comment.head == ""
                    ? AssetImage("images/long.png")
                    : NetworkImage(HttpUtils.baseImageUrl + comment.head),
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
                  comment.alias == "" ? "小纸条" : comment.alias,
                  style: TextStyle(
                      fontSize: 17, color: Color.fromRGBO(91, 101, 113, 1)),
                ),
                Container(
                  height: 5,
                ),
                Image.asset(
                  comment.sex == 0 ? "images/nv.png" : "images/nan.png",
                  width: 15,
                  height: 15,
                ),
              ],
            ),
          ),
        ),
//        IconButton(
//          icon: Icon(Icons.more_horiz),
//        ),
      ],
    );
  }

  Widget _blogItemText(BuildContext ctx, String content, String time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 10,
        ),
        Text(
          content ?? "--",
          overflow: TextOverflow.fade,
          maxLines: 3,
          style: TextStyle(
            fontSize: 17,
            color: Color.fromRGBO(91, 101, 113, 1),
          ),
        ),
        Container(
          height: 5,
        ),
        Text(
          _timeFormat(time),
          style:
              TextStyle(fontSize: 13, color: Color.fromRGBO(179, 189, 199, 1)),
        ),
      ],
    );
  }

  /**
   * 时间格式化
   */
  String _timeFormat(String time) {
    if (time == null) return "--";

    var date = DateTime.parse(time).toLocal();
    return date.year.toString() +
        " " +
        date.month.toString() +
        "-" +
        date.day.toString() +
        " " +
        date.hour.toString() +
        ":" +
        date.minute.toString();
  }
}
