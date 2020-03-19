import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StateListWdget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: new Text("有状态"),
      ),
      body: new ListView(
        itemExtent: 60,
        children: <Widget>[
          StateListItem(),
          StateListItem(),
          StateListItem(),
          StateListItem(),
        ],
      ),
    );
  }
}

class StateListItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateListItemState();
  }
}

class StateListItemState extends State<StateListItem> {
  @override
  bool _isFavorited = true;

  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child: new Row(
        children: <Widget>[
          new IconButton(
            icon: Icon(_isFavorited ? Icons.star : Icons.star_border),
            onPressed: () {
              setState(() {
                _isFavorited = !_isFavorited;
                print(_isFavorited);
              });
            },
          ),
          new Text(_isFavorited ? "已收藏" : "未收藏"),
        ],
      ),
    );
  }
}
