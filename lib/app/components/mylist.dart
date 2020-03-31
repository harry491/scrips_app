import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("列表"),
      ),
      body: new ListView(
        itemExtent: 60,
        children:
            [1, 2, 3, 4, 5, 6, 7, 8, 9, 1, 2, 3, 4, 5, 6, 7, 8, 9].map((value) {
          return MyListItem();
        }).toList(),
      ),
    );
  }
}

class MyListItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyListItemState();
  }
}

class MyListItemState extends State<MyListItem> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Row(
      children: <Widget>[
        new IconButton(icon: new Icon(Icons.map)),
        new Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text("标题"),
              new Text("内容"),
            ],
          ),
        )
      ],
    );
  }
}
