import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:my_app/components/stackview.dart';
import 'package:my_app/components/statefullwdget.dart';
import 'article.dart';
import 'imagelist.dart';
import 'movies.dart';
import 'mylist.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new PageState();
  }
}

class PageState extends State<Home> {
  var titles = [
    "Article",
    "Images",
    "ListView",
    "Stack",
    "Container",
    "Movies",
    new WordPair.random()
  ];

  var swiperDataSource = [
    'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=190488632,3936347730&fm=26&gp=0.jpg'
  ];

  Widget firstSwiperView() {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Swiper(
        itemCount: swiperDataSource.length,
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            swiperDataSource[index],
            fit: BoxFit.fill,
          );
        },
        scrollDirection: Axis.horizontal,
        autoplay: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("工作"),
      ),
      body: new Container(
        child: new ListView(
          children: titles.map((index) {
            int num = titles.indexOf(index);

            if (num == 0) {
              return firstSwiperView();
            } else {
              return new MyListItems('$index', () {
                Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
                  if (num == 0) {
                    return Article();
                  } else if (num == 1) {
                    return ImageList();
                  } else if (num == 2) {
                    return MyList();
                  } else if (num == 3) {
                    return StackView();
                  } else if (num == 4) {
                    return StateListWdget();
                  } else if (num == 5) {
                    return Movies();
                  } else {
                    return Article();
                  }
                }));
              });
            }
          }).toList(),
        ),
      ),
    );
  }
}

typedef GestureTapCallback = void Function();

class MyListItems extends StatefulWidget {
  GestureTapCallback _callBack;

  String title;

  MyListItems(title, callBack)
      : this.title = title,
        this._callBack = callBack;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyListItemsState(this.title, this._callBack);
  }
}

class MyListItemsState extends State<MyListItems> {
  GestureTapCallback _callBack;

  String title;

  MyListItemsState(title, callBack)
      : this.title = title,
        this._callBack = callBack;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new GestureDetector(
      onTap: () {
        _callBack();
      },
      child: new Container(
        color: Colors.grey,
        margin: new EdgeInsets.all(5),
        child: new Row(
          children: <Widget>[
            new IconButton(
              icon: new Icon(
                Icons.menu,
                color: Colors.white,
              ),
              tooltip: title[0],
              onPressed: null,
            ),
            new Text(title, style: new TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
