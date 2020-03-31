import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Movies extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MoviesState();
  }
}

class MoviesState extends State<Movies> {
  static const loadingTag = "##loading##"; //表尾标记
  var _words = <String>[loadingTag];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _retrieveData();
  }

  _retrieveData() {
    Future.delayed(Duration(seconds: 2)).then((e) {
      _words.insertAll(
          _words.length - 1,
          generateWordPairs().take(20).map((e) {
            return e.asPascalCase;
          }));

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("豆瓣Top"),
        ),
        body: ListView.separated(
            itemBuilder: (context, index) {
              if (_words[index] == loadingTag){
                if (_words.length - 1 < 100){
                  _retrieveData();

                  return Container(
                    padding: const EdgeInsets.all(16),
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2,),
                    ),
                  );
                }else{
                  return Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(16.0),
                      child: Text("没有更多了", style: TextStyle(color: Colors.grey),)
                  );
                }
              }else{
                //显示单词列表项
                return ListTile(title: Text(_words[index]));
              }
            },
            separatorBuilder: (context, index) => Divider(
                  height: .0,
                ),
            itemCount: _words.length));
  }
}

class MovieItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child: new Column(
        children: <Widget>[
          new ListTile(
            title: new Text("Word"),
            subtitle: new Text("Hello"),
            trailing: new Icon(Icons.star),
          ),
          new Divider(),
        ],
      ),
    );
  }
}
