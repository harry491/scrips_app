import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_app/app/animate/animate.dart';
import 'package:my_app/app/blog/blog.dart';
import 'package:my_app/app/blog/myBlog.dart';
import 'package:my_app/app//discover/discover.dart';
import 'package:my_app/redux/appState.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 0;

  var _pageList = [new Animate(), new Blog(), new Discover(), new MyBlog()];

  var _titleList = ["动画", "纸条", "发现", "我的"];

  var _iconList = [
    Icons.event_note,
    Icons.location_searching,
    Icons.label_important,
    Icons.person
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ThemeData>(
      converter: (store) => store.state.themeData,
      builder: (context, themeData) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _page,
            type: BottomNavigationBarType.fixed,
            items: _titleList.asMap().keys.map((index) {
              return BottomNavigationBarItem(
                  icon: Icon(
                    _iconList[index],
                  ),
                  title: Text(
                    _titleList[index],
                  ));
            }).toList(),
            onTap: (index) {
              this.setState(() {
                _page = index;
              });
            },
          ),
          body: IndexedStack(
            index: _page,
            children: _pageList,
          ),
        );
      },
    );
  }
}
