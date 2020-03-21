import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_app/blog/blog.dart';
import 'package:my_app/blog/myBlog.dart';
import 'package:my_app/components/home.dart';
import 'package:my_app/components/save.dart';
import 'package:my_app/discover/discover.dart';
import 'package:my_app/event/event_bus.dart';
import 'package:my_app/redux/appState.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 0;

  var _pageList = [new Blog(), new Discover(), new Home(), new MyBlog()];

  var _titleList = ["纸条", "发现", "临时", "我的"];

  var _iconList = [
    Icons.event_note,
    Icons.location_searching,
    Icons.folder_open,
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
