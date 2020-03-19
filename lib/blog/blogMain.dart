import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BlogMain extends StatelessWidget {
  String imgUrl =
      "https://user-gold-cdn.xitu.io/2019/9/20/16d4c9d7642779d3?imageView2/0/w/1280/h/960/format/webp/ignore-error/1";

  String bg = "http://dik.img.kttpdq.com/pic/26/18049/4aa88747b7d38d46.jpg";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: ListView(
        children: <Widget>[
          _buildHeader(),
          Divider(
            height: 1,
          ),
          ListTile(
            title: Text("我的纸条"),
            leading: Icon(Icons.wrap_text),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          Divider(
            height: 1,
          ),
          ListTile(
            title: Text("我的点赞"),
            leading: Icon(Icons.wrap_text),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          Divider(
            height: 1,
          ),
          ListTile(
            title: Text("我的收藏"),
            leading: Icon(Icons.wrap_text),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: Text("我的评论"),
            leading: Icon(Icons.wrap_text),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          Divider(
            height: 1,
          ),
          Divider(
            height: 1,
          ),
          ListTile(
            title: Text("设置"),
            leading: Icon(Icons.settings),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          Divider(
            height: 1,
          ),
          _buildFooter(),
          Divider(
            height: 1,
          ),
        ],
      ),
    ));
  }

  Widget _buildHeader() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        new Image.network(bg),
        new Center(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    color: Colors.red),
                width: 80,
                height: 80,
              ),
              Container(
                height: 15,
              ),
              Text(
                "昵称",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: EdgeInsets.all(15),
      child: FlatButton(
        child: Text("退出登录"),
      ),
    );
  }
}
