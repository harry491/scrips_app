import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Article extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: Text("文章"),
      ),
      body: new Container(
        child: new ListView(
          children: <Widget>[
            new Image.network("https://user-gold-cdn.xitu.io/2019/9/20/16d4c9d7642779d3?imageView2/0/w/1280/h/960/format/webp/ignore-error/1"),
            new DescWidget(),
            new ButtonWidget(),
            new Container(
              padding: EdgeInsets.all(15),
              child: new Text("Docker 提供了一个叫做 Volume 的东西，可以将容器内和宿主机的某个文件夹进行”绑定“，任何文件改动都会得到同步。所以，我可以将整个站点目录和 MySQL 目录都挂载为 Volume。这样，当容器删除时，所有数据文件和源码都会保留。" , style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),),
            )
          ],
        ),
      ),
    );
  }
}

class DescWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(5),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: new Text(
                    "按钮部分包含3个使用相同布局的列",
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: new Text("按钮部分包含3个使用相同布局的列"),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.star),
            tooltip: "41",
          ),
          Text("41"),
        ],
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new Container(
          margin: const EdgeInsets.only(top: 8.0),
          child: new Column(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.call),
                tooltip: "41",
              ),
              Text("41"),
            ],
          ),
        ),
        new Container(
          margin: const EdgeInsets.only(top: 8.0),
          child: new Column(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.near_me),
                tooltip: "41",
              ),
              Text("41"),
            ],
          ),
        ),
        new Container(
          margin: const EdgeInsets.only(top: 8.0),
          child: new Column(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.share),
                tooltip: "41",
              ),
              Text("41"),
            ],
          ),
        ),
      ],
    );
  }
}
