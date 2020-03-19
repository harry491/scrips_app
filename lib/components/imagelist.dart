import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImageList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("图标列表"),
        ),
        body: new ListView(
          children: <Widget>[
            new Column(
              children: [1, 2, 3, 4, 5, 6].map((value) {
                return ImageListRow();
              }).toList(),
            ),
          ],
        ));
  }
}

class ImageListRow extends StatelessWidget {
  @override
  String imgUrl =
      "https://user-gold-cdn.xitu.io/2019/9/19/16d47c2c9ef53bdc?imageView2/1/w/120/h/120/q/85/format/webp/interlace/1";

  Widget build(BuildContext context) {
    // TODO: implement build
    return new Row(
      children: <Widget>[
        new Expanded(
          child: new Container(
            decoration: new BoxDecoration(
              border: new Border.all(width: 2.0, color: Colors.black38),
              borderRadius: const BorderRadius.all(const Radius.circular(3.0)),
            ),
            child: new Image.network(
              imgUrl,
            ),
            margin: const EdgeInsets.all(4.0),
          ),
        ),
        new Expanded(
          child: new Container(
            decoration: new BoxDecoration(
              border: new Border.all(width: 2.0, color: Colors.black38),
              borderRadius: const BorderRadius.all(const Radius.circular(3.0)),
            ),
            child: new Image.network(imgUrl),
            margin: const EdgeInsets.all(4.0),
          ),
        ),
        new Expanded(
          child: new Container(
            decoration: new BoxDecoration(
              border: new Border.all(width: 2.0, color: Colors.black38),
              borderRadius: const BorderRadius.all(const Radius.circular(3.0)),
            ),
            child: new Image.network(imgUrl),
            margin: const EdgeInsets.all(4.0),
          ),
        )
      ],
    );
  }
}
